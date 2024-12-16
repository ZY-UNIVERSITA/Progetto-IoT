# Librerie per connettersi al wifi wowki
import network
import time

# Libreria per connettersi ai pin e usare il sensore dht
import dht
import machine

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