import ina226
import time 
from machine import Pin, I2C
# i2c
i2c = I2C(0,scl=Pin(1), sda=Pin(0),freq=100000)
# ina226
ina = ina226.INA226(i2c, 0x40)
# default configuration and calibration value
ina.set_calibration()
print(ina.bus_voltage)
print(ina.shunt_voltage)
print(ina.current)
print(ina.power)
while True:
    print(ina.bus_voltage)
    print(ina.current)
    time.sleep(0.5)
    