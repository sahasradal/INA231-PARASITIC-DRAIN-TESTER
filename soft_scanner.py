from machine import Pin, SoftI2C
import time

# Define the pins for SCL and SDA. 
# These can be any available GPIO pins, specific names (e.g., 'P5_0') 
# will depend on your specific board (e.g., ESP32, Raspberry Pi Pico).
SDA_PIN = 0
SCL_PIN = 1



# Initialize the SoftI2C bus
# It is important to remember that I2C requires external pull-up resistors 
# on both SCL and SDA lines.
i2c = SoftI2C(scl=Pin(SCL_PIN), sda=Pin(SDA_PIN), freq=100000)

print(f"I2C initialized on SCL GPIO {SCL_PIN}, SDA GPIO {SDA_PIN}")

# Scan for I2C devices on the bus
devices = i2c.scan()

if devices:
    print(f"Found {len(devices)} I2C devices:")
    for device_addr in devices:
        print(f"  Device address: 0x{device_addr:02X}")
        
        # Example: Write 3 bytes to the device
        # Replace 0x3a with your device's address and b'123' with your data
        try:
            i2c.writeto(device_addr, b'123')
            print(f"  Wrote '123' to device 0x{device_addr:02X}")
        except OSError:
            print(f"  Could not write to device 0x{device_addr:02X}")

        # Example: Read 4 bytes from the device
        # Replace 0x3a with your device's address
        try:
            data = i2c.readfrom(device_addr, 4)
            print(f"  Read {len(data)} bytes from device 0x{device_addr:02X}: {data}")
            continue
        except OSError:
             print(f"  Could not read from device 0x{device_addr:02X}")

else:
    print("No I2C devices found.")
    

i2c = SoftI2C(scl=Pin(3), sda=Pin(2), freq=100000)
# Scan for I2C devices on the bus
devices = i2c.scan()
print(f"scanning bus 0")
if devices:
    print(f"Found {len(devices)} I2C devices:")
    for device_addr in devices:
        print(f"  Device address: 0x{device_addr:02X}")
        
else:
    print("No I2C devices found in 0 bus.")