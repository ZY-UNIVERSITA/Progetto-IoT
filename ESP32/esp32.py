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

# MQTT Server Parameters
MQTT_CLIENT_ID = "progetto-iot-rile-temp-hum"
MQTT_BROKER_SERVER_URL = "broker.mqttdashboard.com"
MQTT_USERNAME = ""
MQTT_PASSWORD = ""
MQTT_TOPIC_PUBLISHER = "sensori-server"
MQTT_TOPIC_SUBSCRIBER = "server-sensori"

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

limits = {i: {"temp": 25, "hum": 15} for i in range(len(sensorPins))}

# Impostazioni come subscriber
def onMessage(topic, msg):
  # byte -> string 
  try:
    messages = ujson.loads(msg.decode())
    print(f"Sensor: {message.sensor}, temp: {message.temp}, hum: {message.hum}", end="")

    if isinstance(messages, list):
      for message in messages:
        updateLimit(message)
    
    elif isinstance(messages, dict):
      updateLimit(message)

  except Exception as e:
    print("Errore nel parsing del messaggio: ", e)

# Aggiorna i limiti
def updateLimit(message):
  sen_id = message.get("sensor")
  if sen_id in limits:
    limits[sen_id]["temp"] = message.get("temp", limits[sen_id]["temp"])
    limits[sen_id]["hum"] = message.get("temp", limits[sen_id]["hum"])
    print(f"Aggiornati limiti per sensore {sen_id}: {limits[sen_id]}")

def get_formatted_time():
  return time.strftime("%Y-%m-%dT%H:%M:%S", time.localtime())

# Quando c'è un messaggio viene richiamata questa funzione
MQTTclient.set_callback(onMessage)

# Impostazioni come publisher
MQTTclient.subscribe(MQTT_TOPIC_SUBSCRIBER)

# Aggiornare la data dell'ESP32
ntptime.settime()

while True:
  print(f"I {len(sensors)} sensori ha rilevato i valori: ", end="")

  # Controlla i messaggi
  MQTTclient.check_msg()

  # Manda i dati al server MQTT
  i = 0
  for sensor in sensors:
    sensor.measure()
    
    sensorMessage = {
        "sensor": i,
        "temp": sensor.temperature(),
        "humidity": sensor.humidity(),
        "timestamp":  get_formatted_time()
    }

    message = ujson.dumps(sensorMessage)

    MQTTclient.publish(MQTT_TOPIC_PUBLISHER, message)

    print(sensorMessage)

    i+=1

  # Esegue la lettura ogni 5 secondi
  time.sleep(5)
