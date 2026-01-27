from machine import Pin, I2C
import time

# Default I2C pins for RP2040 (GPIO0 and GPIO1)
I2C_ADDR = 0x27  # Common address for PCF8574 backpack (might be 0x3F)
I2C_NUM = 1      # I2C0
SDA_PIN = 2      # GPIO0
SCL_PIN = 3      # GPIO1

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

# Usage example
try:
    lcd = I2cLcd(I2C_NUM, SDA_PIN, SCL_PIN, I2C_ADDR, 2, 16)
    lcd.backlight_off()
    time.sleep(1)
    lcd.backlight_on()
    lcd.clear()
    lcd.set_cursor(0, 0)
    lcd.print("Hello, World!")
    lcd.set_cursor(0, 1)
    lcd.print("MicroPython")
    
except Exception as e:
    print("Error initializing LCD:", e)