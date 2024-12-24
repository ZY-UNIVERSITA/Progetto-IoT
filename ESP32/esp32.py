# Librerie per connettersi al wifi wowki
import network
import time

# Libreria per connettersi al server MQTT
from umqtt.simple import MQTTClient

# Libreria per connettersi ai pin e usare il sensore dht
import dht
import machine

# Libreria per aggiornare la data
import ntptime

# Libreria di micropython per gestire i file json, simile alla libreria json di python
import ujson

# Liberia json di python, è meno efficiente da usare ujson è progettato per i sistemi embedded dove c'è l'orientamento all'efficienza
# import json 

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
  sensors.append(dht.DHT22(machine.Pin(pin)))

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

# Limiti di umidità classici
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

# Aggiornare la data dell'ESP32
ntptime.settime()

while True:
  # Controlla eventuali messaggi di aggiornamenot dei messaggi che arrivano dal frontend
  print(f"I {len(sensors)} sensori hanno rilevato i seguenti valori: ", end="\n")
  MQTTclient.check_msg()

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

    # Controlla se i valori rilevati sono nei limiti
    if sensorMessage["temp"] > sensor_limits[i]["temp"]:
      MQTTClient.publish(MQTT_TOPIC_PUBLISHER_EMERGENCY, ujson.dumps({
        "sensor": i,
        "temp": sensor.temperature(),
        "temp_limit": sensor_limits[i]["temp"]
      }))
      print("Temperatura troppo elevata.")

    if sensorMessage["hum"] > sensor_limits[i]["hum"]:
      MQTTClient.publish(MQTT_TOPIC_PUBLISHER_EMERGENCY, ujson.dumps({
        "sensor": i,
        "hum": sensor.humidity(),
        "hum_limit": sensor_limits[i]["hum"]
      }))
      print("Umidità troppo elevata.")

    i+=1

  # Esegue la lettura ogni 1.5 perchè il sensore fornisce un input ogni 2 secondi. Con 1.5 si è sicuri di ottenere tutti i valori
  time.sleep(1.5)

