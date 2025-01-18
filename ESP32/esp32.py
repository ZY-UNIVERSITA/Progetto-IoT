# Librerie per connettersi al wifi wowki
import network
import time

# Libreria per connettersi al server MQTT
from umqtt.simple import MQTTClient

# Libreria per connettersi ai pin e usare il sensore dht
import dht
from machine import Pin
from machine import SoftI2C

# Libreria per aggiornare la data
import ntptime

# Libreria di micropython per gestire i file json, simile alla libreria json di python
import ujson

# Liberia json di python, è meno efficiente da usare ujson è progettato per i sistemi embedded dove c'è l'orientamento all'efficienza
# import json 

# Libreria per usare lo schermo ssd1306
import ssd1306

# Parametri del server MQTT
MQTT_CLIENT_ID = "progetto-iot-rile-temp-hum"
MQTT_BROKER_SERVER_URL = "broker.mqttdashboard.com"
MQTT_USERNAME = ""
MQTT_PASSWORD = ""
MQTT_TOPIC_PUBLISHER_NORMAL = "sensors_to_server"
MQTT_TOPIC_PUBLISHER_EMERGENCY = "sensors_to_server_emergency"
MQTT_TOPIC_SUBSCRIBER = "server_to_sensor"

# Associazione sensori ai pin
sensorPins = [ 15, 32 ]
sensors = []
for pin in sensorPins:
  sensors.append(dht.DHT22(Pin(pin)))

# Configurazione dello schermo SSD1306
i2c = SoftI2C(sda=Pin(26), scl=Pin(27))
display = ssd1306.SSD1306_I2C(128, 64, i2c)

# Configurazione led
led1 = Pin(23, Pin.OUT)


# Dalla documentazione di WOKWI per connettersi al wifi
print("Connecting to WiFi", end="")
sta_if = network.WLAN(network.STA_IF)
sta_if.active(True)
sta_if.connect('Wokwi-GUEST', '')
while not sta_if.isconnected():
  print(".", end="")
  time.sleep(0.1)
print(" Connected!")

# Dalla documentazione umqtt.simple per connettersi al server MQTT
# Connessione al server MQTT
print("Connessione al server MQTT in corso...", end="")
# Creazione dell'oggetto MQTTClient
MQTTclient = MQTTClient(MQTT_CLIENT_ID, MQTT_BROKER_SERVER_URL, user=MQTT_USERNAME, password=MQTT_PASSWORD)
# Connessione al server MQTT
MQTTclient.connect()
if MQTTclient:
  print("Tutto ok. Connesso.")
else:
  print("Errore nella connessione.")

# Limiti di umidità di default
sensor_limits = {i: {"temp": 25, "hum": 15} for i in range(len(sensorPins))}

# Impostazioni come subscriber
def onMessage(topic, msg):
  # byte -> string 
  try:
    # Decodifica il messaggio da byte in string
    messagesString = msg.decode()
    
    # Trasforma la stringa in un oggetto json
    messages = ujson.loads(messagesString)

    # Permette di accettare l'invio di più limiti in una volta
    for message in messages:
      print(f"Sensor: {message["sensor"]}, temp: {message["temp"]}, hum: {message["hum"]}", end="\n")
      updateLimit(message)

  except Exception as e:
    print("Errore nel parsing del messaggio: ", e)

# Aggiorna i limiti
def updateLimit(message):
  sensor_id = message.get("sensor")
  if sensor_id in sensor_limits:
    sensor_limits[sensor_id]["temp"] = message.get("temp", sensor_limits[sensor_id]["temp"])
    sensor_limits[sensor_id]["hum"] = message.get("temp", sensor_limits[sensor_id]["hum"])
    print(f"Aggiornati limiti per sensore {sensor_id}: {sensor_limits[sensor_id]}")

# Quando c'è un messaggio viene richiamata questa funzione
MQTTclient.set_callback(onMessage)

# Impostazioni come publisher
MQTTclient.subscribe(MQTT_TOPIC_SUBSCRIBER)

# Aggiorna la data dell'ESP32
ntptime.settime()

while True:
  # Controlla eventuali messaggi di aggiornamenot dei messaggi che arrivano dal frontend
  MQTTclient.check_msg()

  # Legge i dati che arrivano dai sensori
  print(f"I {len(sensors)} sensori hanno rilevato i seguenti valori: ", end="\n")

  # Resetta il display ssd1306
  display.fill(0)
  
  # riga di separazione tra i valori dei 2 sensori
  display.hline(0, 30, 128, 1)


  # Manda i dati al server MQTT
  i = 0
  for sensor in sensors:
    sensor.measure()
    
    sensorMessage = {
        "sensor": i,
        "temp": sensor.temperature(),
        "hum": sensor.humidity(),
        "timestamp":  time.gmtime(time.time())
    }

    message = ujson.dumps(sensorMessage)

    MQTTclient.publish(MQTT_TOPIC_PUBLISHER_NORMAL, message)

    print(sensorMessage)

    # Scrivi sullo schermo lasciando dello spazio
    y_position = 35 * i
    display.text(f'Sensor: {i}', 0, y_position, 1)
    display.text(f'Temp: {sensorMessage["temp"]}', 0, y_position + 10, 1)
    display.text(f'Hum: {sensorMessage["hum"]}', 0, y_position + 20, 1)


    # Controlla se i valori rilevati sono nei limiti
    limit_to_control = [ "temp", "hum" ]

    for limit in limit_to_control:
      if sensorMessage[limit] > sensor_limits[i][limit]:
        if i == 0:
          led1.on()

        print(sensorMessage[limit], sensor_limits[i][limit])

        sensorOverLimit = {
          "sensor": i,
          "misured_value": sensor.temperature() if limit == "temp" else sensor.humidity(),
          f"{limit}_limit": sensor_limits[i][limit],
          "timestamp": time.gmtime(time.time())
        }

        message = ujson.dumps(sensorOverLimit)

        MQTTclient.publish(MQTT_TOPIC_PUBLISHER_EMERGENCY, message)

        print(sensorOverLimit)

        print(f"{limit} troppo elevata.")

    i+=1

  # Visualizzazione su schermo
  display.show()

  # Esegue la lettura ogni 1.5 perchè il sensore fornisce un input ogni 2 secondi. Con 1.5 si è sicuri di ottenere tutti i valori
  time.sleep(1.5)

