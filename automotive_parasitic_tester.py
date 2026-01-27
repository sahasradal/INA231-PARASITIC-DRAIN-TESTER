from machine import Pin, SoftI2C , I2C
import time

# --- ADD THE SAFETY DELAY HERE ---
print("Booting... Press Ctrl+C now to enter REPL")
time.sleep(2)  # 2-second window to interrupt
# ---------------------------------


ADDRESS = 0x40
address = 0x40
# Register Addresses
CONFIG_REG = 0x00
BUS_REG    = 0x02
POWER_REG  = 0x03
CURRENT_REG= 0x04
CAL_REG    = 0x05

# Calibration Data (The State)
CURRENT_LSB = 0.001 # Amps per bit (2.5 mA/bit)
CAL_VALUE_DEC = 2048  # Decimal value for Cal Register,5120,0x1400 for .001A lsb
CAL_VALUE_HEX = 0x1570# Hex value to write (MSB: 0x08, LSB: 0x00)
# Derived LSBs
BUS_V_LSB = 0.00125  # Fixed: 1.25 mV/bit
POWER_LSB = CURRENT_LSB * 25 # Derived: 0.0025 W/bit
########################
R_SHUNT = 0.001
# HIGH RANGE (81.9A Max, 2.5 mA/bit LSB)
CAL_HIGH_RANGE = 2048   # 0x0800
LSB_HIGH_RANGE = 0.0025 # Amperes/bit
# LOW RANGE (32.7A Max, 1.0 mA/bit LSB)
CAL_LOW_RANGE = 5120    # 0x1400
LSB_LOW_RANGE = 0.001   # Amperes/bit
offset=0
########################
# 1602 LCD defines
# Default I2C pins for RP2040 (GPIO0 and GPIO1)
I2C_ADDR = 0x27  # Common address for PCF8574 backpack (might be 0x3F)
I2C_NUM = 1      # I2C0
SDA_PIN = 2      # GPIO2 , I2C1 SDA
SCL_PIN = 3      # GPIO3 , I2C1 SCL

# LCD constants
LCD_WIDTH = 16   # Characters per line

# Command flags
LCD_CLEARDISPLAY = 0x01
LCD_RETURNHOME = 0x02
LCD_ENTRYMODESET = 0x04
LCD_DISPLAYCONTROL = 0x08
LCD_CURSORSHIFT = 0x10
LCD_FUNCTIONSET = 0x20
LCD_SETCGRAMADDR = 0x40
LCD_SETDDRAMADDR = 0x80

# Flags for display entry mode
LCD_ENTRYRIGHT = 0x00
LCD_ENTRYLEFT = 0x02
LCD_ENTRYSHIFTINCREMENT = 0x01
LCD_ENTRYSHIFTDECREMENT = 0x00

# Flags for display on/off control
LCD_DISPLAYON = 0x04
LCD_DISPLAYOFF = 0x00
LCD_CURSORON = 0x02
LCD_CURSOROFF = 0x00
LCD_BLINKON = 0x01
LCD_BLINKOFF = 0x00

# Flags for display/cursor shift
LCD_DISPLAYMOVE = 0x08
LCD_CURSORMOVE = 0x00
LCD_MOVERIGHT = 0x04
LCD_MOVELEFT = 0x00

# Flags for function set
LCD_4BITMODE = 0x00
LCD_2LINE = 0x08
LCD_1LINE = 0x00
LCD_5x10DOTS = 0x04
LCD_5x8DOTS = 0x00

# Flags for backlight control
LCD_BACKLIGHT = 0x08
LCD_NOBACKLIGHT = 0x00

En = 0b00000100  # Enable bit
Rw = 0b00000010  # Read/Write bit
Rs = 0b00000001  # Register select bit
#######################################################
class I2cLcd:
    def __init__(self, i2c_num, sda_pin, scl_pin, i2c_addr, lcd_rows, lcd_cols):
        self.i2c = I2C(i2c_num, sda=Pin(sda_pin), scl=Pin(scl_pin), freq=100000)
        self.addr = i2c_addr
        self.rows = lcd_rows
        self.cols = lcd_cols
        self.backlight = LCD_BACKLIGHT
        
        # Initialize display
        self.write_cmd(0x03)
        self.write_cmd(0x03)
        self.write_cmd(0x03)
        self.write_cmd(0x02)
        
        self.write_cmd(LCD_FUNCTIONSET | LCD_2LINE | LCD_5x8DOTS | LCD_4BITMODE)
        self.write_cmd(LCD_DISPLAYCONTROL | LCD_DISPLAYON)
        self.write_cmd(LCD_CLEARDISPLAY)
        self.write_cmd(LCD_ENTRYMODESET | LCD_ENTRYLEFT)
        time.sleep_ms(200)
    
    def write_cmd(self, cmd):
        self.send(cmd, 0)
    
    def write_data(self, data):
        self.send(data, Rs)
    
    def send(self, data, mode):
        high_nib = data & 0xF0
        low_nib = (data << 4) & 0xF0
        self.write_byte(high_nib | mode)
        self.write_byte(low_nib | mode)
    
    def write_byte(self, byte):
        self.i2c.writeto(self.addr, bytes([byte | self.backlight | En]))
        time.sleep_us(1)
        self.i2c.writeto(self.addr, bytes([byte | self.backlight & ~En]))
        time.sleep_us(50)
    
    def clear(self):
        self.write_cmd(LCD_CLEARDISPLAY)
        time.sleep_ms(2)
    
    def home(self):
        self.write_cmd(LCD_RETURNHOME)
        time.sleep_ms(2)
    
    def set_cursor(self, col, row):
        row_offsets = [0x00, 0x40, 0x14, 0x54]
        if row > self.rows:
            row = self.rows - 1
        self.write_cmd(LCD_SETDDRAMADDR | (col + row_offsets[row]))
    
    def print(self, text):
        for char in text:
            self.write_data(ord(char))
    
    def backlight_on(self):
        self.backlight = LCD_BACKLIGHT
        self.i2c.writeto(self.addr, bytes([self.backlight]))
    
    def backlight_off(self):
        self.backlight = LCD_NOBACKLIGHT
        self.i2c.writeto(self.addr, bytes([self.backlight]))

#initialise LCD
lcd = I2cLcd(I2C_NUM, SDA_PIN, SCL_PIN, I2C_ADDR, 2, 16)
lcd.clear()
lcd.set_cursor(0, 0)
lcd.print("parasitic tester")
lcd.set_cursor(0, 1)
lcd.print("INA231 , Python")
time.sleep(2)
lcd.clear()
################################################################
# 1. Use SoftI2C for better compatibility
#i2c = SoftI2C(scl=Pin(1), sda=Pin(0), freq=10000) # Lower freq for testing
i2c = I2C(1, scl=Pin(3), sda=Pin(2), freq=100000)

def write_reg(register, data_hex):
    """Writes a 16-bit value to a register."""
    msb = (data_hex >> 8) & 0xFF
    lsb = data_hex & 0xFF
    buf = bytearray([register, msb, lsb])
    i2c.writeto(ADDRESS, buf, True)

def read_reg(register):
    """Reads a 16-bit raw value from a register."""
    # 1. Set the register pointer
    i2c.writeto(ADDRESS, bytearray([register]), False)
    # 2. Read 2 bytes
    data = i2c.readfrom(ADDRESS, 2)
    # 3. Combine bytes into a 16-bit integer
    return (data[0] << 8) | data[1]

def convert_signed(raw_value):
    """Converts a 16-bit unsigned reading into a signed integer (Two's Complement)."""
    SIGNED_MAX_16_BIT = 32767
    TOTAL_16_BIT_RANGE = 65536
    
    if raw_value > SIGNED_MAX_16_BIT:
        return -(TOTAL_16_BIT_RANGE - raw_value)
    else:
        return raw_value

# --- 3. Core Measurement Function ---

def get_measurements():
    """Reads and calculates current, voltage, and power using global constants."""
    # Read Current Register
    raw_current = read_reg(CURRENT_REG)
    signed_current_value = convert_signed(raw_current)
    current_amps = (signed_current_value * CURRENT_LSB)-offset # Uses global CURRENT_LSB
    
    # Read Bus Voltage Register
    raw_voltage = read_reg(BUS_REG)
    voltage_volts = raw_voltage * BUS_V_LSB # Uses global BUS_V_LSB

    # Read Power Register
    raw_power = read_reg(POWER_REG)
    power_watts = raw_power * POWER_LSB # Uses global POWER_LSB

    return {
        'current_A': current_amps,
        'voltage_V': voltage_volts,
        'power_W': power_watts
    }


def test_ina():
    print("Scanning...")
    if address not in i2c.scan():
        print("Device not found!")
        return

    try:
        # 2. Try a single, simple write to Configuration (reset)
        print("Sending Reset...")
        i2c.writeto_mem(address, 0x00, b'\x80\x00')
        time.sleep(0.2)
        # 3. Try to read the ID register (0xFE) to confirm communication
        # Default for INA226 should be 0x5449 ('TI')
        manufact_id = i2c.readfrom_mem(address, 0xFE, 2)
        print("Manufacturer ID:", manufact_id.hex())
        # 4. Final configuration write
        i2c.writeto_mem(address, 0x05, b'\x02\x00')
        print("Success!")
    except OSError as e:
        print("Failed with error:", e)

test_ina()

print("Initializing INA231...")
# 1. Write Calibration Register (0x05)
write_reg(CAL_REG, CAL_VALUE_HEX)
time.sleep_ms(10) 
# 2. Write Configuration Register (0x00)
write_reg(CONFIG_REG, 0x4C25) # 0x4127 is the Configuration setting,0x4527 16 sample
# **Measurement Loop (Runs forever)**
print("offset loop")
i=60
while i > 0:
    raw_current = read_reg(CURRENT_REG)
    signed_current_value = convert_signed(raw_current)
    current_amps = (signed_current_value * CURRENT_LSB) # Uses global CURRENT_L
    offset+= current_amps
    i=i-1
    time.sleep(1)
    line1 = "wait: {:} seconds ".format(i)
    lcd.set_cursor(0, 0)
    lcd.print(f"{line1:<16}")
    print(i)
print(offset)
offset=offset/60
print(offset,"avg")
print("Starting measurement loop...")
lcd.clear()
while True:
    try:
        
        data = get_measurements()
    
        print("-" * 30)
        print(f"Current:  {data['current_A']:.3f} A")
        print(f"Voltage:  {data['voltage_V']:.3f} V")
        print(f"Power:    {data['power_W']:.3f} W")
    
    
        # Format strings to exactly 16 characters to overwrite old data
        #line1 = "Volt:  {:6.3f} V ".format(data['voltage_V'])
        line2 = "Curr:  {:6.3f} A ".format(data['current_A'])
        
        #lcd.set_cursor(0, 0)
        #lcd.print(f"{line1:<16}") # Ensure it doesn't exceed 16 chars
        
        lcd.set_cursor(0, 1)
        lcd.print(f"{line2:<16}")
    except Exception as e:
        print("Measure/LCD Error:", e)

    time.sleep(0.5)


