from machine import I2C, Pin
import time

# --- 1. Global Constants (The Data) ---

# I2C setup
ADDRESS = 0x40
i2c = I2C(0, scl=Pin(1), sda=Pin(0), freq=100000)

# Register Addresses
CONFIG_REG = 0x00
BUS_REG    = 0x02
POWER_REG  = 0x03
CURRENT_REG= 0x04
CAL_REG    = 0x05

# Calibration Data (The State)
CURRENT_LSB = 0.0001 # Amps per bit (100 uA/bit)
CAL_VALUE_DEC = 512  # Decimal value for Cal Register
CAL_VALUE_HEX = 0x0200 # Hex value to write (MSB: 0x02, LSB: 0x00)

# Derived LSBs
BUS_V_LSB = 0.00125  # Fixed: 1.25 mV/bit
POWER_LSB = CURRENT_LSB * 25 # Derived: 0.0025 W/bit

# --- 2. Helper Functions ---

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
    current_amps = signed_current_value * CURRENT_LSB # Uses global CURRENT_LSB
    
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

# --- 4. Main Program Flow ---

# **Initialization (Runs once)**
print("Initializing INA226...")
# 1. Write Calibration Register (0x05)
write_reg(CAL_REG, CAL_VALUE_HEX)
time.sleep_ms(10) 
# 2. Write Configuration Register (0x00)
write_reg(CONFIG_REG, 0x4127) # 0x4127 is the Configuration setting

# **Measurement Loop (Runs forever)**
print("Starting measurement loop...")
while True:
    data = get_measurements()
    
    print("-" * 30)
    print(f"Current:  {data['current_A']:.4f} A")
    print(f"Voltage:  {data['voltage_V']:.3f} V")
    print(f"Power:    {data['power_W']:.3f} W")
    
    time.sleep(1)
