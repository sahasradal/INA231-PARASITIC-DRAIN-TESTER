from machine import Pin, I2C

# Initialize I2C on bus 0 with specific SCL and SDA pins
# Replace GP17 and GP16 with the actual GPIO pins you are using for SCL and SDA
i2c = I2C(1, scl=Pin(3), sda=Pin(2), freq=100000) 
#

print('Scanning I2C bus...')
devices = i2c.scan()
print(devices)
if len(devices) == 0:
    print("No I2C devices found.")
else:
    print('I2C devices found at addresses:')
    for device in devices:
        print(hex(device))