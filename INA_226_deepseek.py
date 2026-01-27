from machine import I2C, Pin
import time
address = 0x40
config = 0x00
shuntreg = 0x01
busreg   = 0x02
powerreg  = 0x03
currentreg= 0x04
calreg    = 0x05
maskreg   = 0x06
alertreg  = 0x07

shunt = 0.1ohm
BUS_V_LSB = 0.00125  # Fixed: 1.25 mV/bit
POWER_LSB = CURRENT_LSB * 25 # Derived: 0.0025 W/bit

#Calculating the current_LSB
#current_LSB = max_expected_I / (2^15)
#current_LSB = 3.6 A / (2^15)
#current_LSB = 0.0001098632813 = 0.00011 = 0.0001 -> 100uA/bit

#Calculating the calibration register
#Cal_value = 0.00512 / (current_LSB * Rshunt)
#Cal_value = 0.00512 / (0.0001 * 0.1)
#Cal_value = 512 = 0x200

#Calculating the power_LSB
#power_LSB = 25 * current_LSB
#power_LSB = 25 * 0.0001 = 0.0025 -> 2.5mW/bit


#Default values
#cal_value = 512
#current_lsb = 0.0001
#power_lsb = 0.0025
#Rshunt = 0.1
#Averaging mode: 1 sample
#Bus voltage conversion time: 1.1ms
#Shunt voltage conversion time: 1.1ms
#Operating mode: Shunt and Bus voltage, continuous




i2c = machine.I2C(0, scl=Pin(1), sda=Pin(0), freq=100000)
buf=bytearray([0x05,0x02,0x00])
I2C.writeto(address,buf,stop=True)
   
buf=bytearray([0x00,0x41,0x27])
I2C.writeto(address,buf,stop=True)

def write_reg(register ,reg_data)
    msb=(reg_data>>8) & 0xff
    lsb= reg_data & 0xff
    buf=bytearray([register,msb,lsb])
    I2C.writeto(address,buf,stop=True)
    
def read_reg(register)
    I2C.writeto(address,bytearray([register]),stop=False)
    data = I2C.readfrom(ADDRESS, 2)
    return (data[0] << 8) | data[1]
    
def convert_signed(raw_value):
    """Converts a 16-bit unsigned reading into a signed integer (Two's Complement)."""
    SIGNED_MAX_16_BIT = 32767      # 0x0000 to 0x7fff  is range of positive
    TOTAL_16_BIT_RANGE = 65536	   # max range of numbers 0xffff
    
    if raw_value > SIGNED_MAX_16_BIT:        # msb becomes 1 and number is negative
        return -(TOTAL_16_BIT_RANGE - raw_value)	# deduct from max and return with negative sign
    else:
        return raw_value    

def calibration_write(shunt,max_amp,lsb_step):
    current_lsb = (max_amp/32768)
    cal_value =round((0.00512/(current_lsb * shunt)))
    write_reg(calreg,cal_val)
    
    

# Assuming your microcontroller's I2C object is initialized as 'i2c'
# and the INA231's I2C address is 0x40 (the default).

import machine
import time
# from machine import I2C # Uncomment this line if running in a real environment

# --- 1. CONFIGURATION CONSTANTS (Pre-Calculated Values) ---
INA231_ADDRESS = 0x40

# INA231 Register Map
REG_CONFIG = 0x00
REG_CAL = 0x05
REG_CURRENT = 0x04

# --- CALIBRATION CONSTANTS ---
# 75mV/75A Shunt (R_SHUNT = 0.001 Ohms)
R_SHUNT = 0.001

# HIGH RANGE (81.9A Max, 2.5 mA/bit LSB)
CAL_HIGH_RANGE = 2048   # 0x0800
LSB_HIGH_RANGE = 0.0025 # Amperes/bit

# LOW RANGE (32.7A Max, 1.0 mA/bit LSB)
CAL_LOW_RANGE = 5120    # 0x1400
LSB_LOW_RANGE = 0.001   # Amperes/bit

# --- SWITCHING LOGIC CONSTANTS (Hysteresis) ---
# Switch to HIGH range when current exceeds this (Prevents overflow)
HIGH_THRESHOLD_A = 21.0
# Switch to LOW range when current drops below this (Maximizes accuracy)
LOW_THRESHOLD_A = 19.0

# Initial state (Start in HIGH range for safety during power-up/cranking)
current_lsb = LSB_HIGH_RANGE

# --- 2. I2C COMMUNICATION FUNCTIONS ---

def write_reg(register, reg_data):
    """Writes a 16-bit value (reg_data) to a 8-bit register address."""
    msb = (reg_data >> 8) & 0xFF
    lsb = reg_data & 0xFF
    # I2C.writeto(INA231_ADDRESS, bytes([register, msb, lsb]))
    print(f"I2C WRITE: Reg=0x{register:02X}, Value={reg_data} (0x{reg_data:04X})")

def read_reg(register):
    """Reads a 16-bit value from a 8-bit register address."""
     i2c.writeto(INA231_ADDRESS, bytes([register]))
     data = i2c.readfrom(INA231_ADDRESS, 2)
     return (data[0] << 8) | data[1]
    
    
# --- 3. INA231 SETUP & CALIBRATION ---

def init_ina231():
    """Initializes the INA231 Configuration Register and sets the starting CAL."""
    
    # CONFIG Register value (example configuration)
    # 0x4000: BSHUNT (Shunt Voltage Range) = 1 (163.84mV range) -> CRITICAL FOR 80A!
    # 0x0400: Average Mode = 128 samples (Noise reduction for low current)
    # 0x000F: Bus/Shunt/Conversion Time = 8.24ms
    CONFIG_VALUE = 0x440F 
    
    # 1. Write Configuration Register (sets the 163.84mV range and averaging)
    write_reg(REG_CONFIG, CONFIG_VALUE)
    
    # 2. Write Initial Calibration (Start safe in HIGH range)
    write_reg(REG_CAL, CAL_HIGH_RANGE)
    
    print("\nINA231 Initialized in HIGH Range (2.5 mA/bit).")

# --- 4. MEASUREMENT & SWITCHING LOGIC ---

def read_current():
    """Reads the Current Register and applies the current LSB."""
    raw_current = read_reg(REG_CURRENT)
    
    # Apply two's complement if negative (assuming 16-bit signed)
    if raw_current & 0x8000:
        raw_current -= 0x10000 

    # Global 'current_lsb' variable holds the active LSB
    current_A = raw_current * current_lsb
    return current_A, raw_current

def monitor_and_switch(current_A):
    """Checks thresholds and switches the CAL register if necessary."""
    global current_lsb # We modify the global LSB variable
    
    # Check if we need to switch TO the LOW range
    if current_lsb == LSB_HIGH_RANGE and current_A < LOW_THRESHOLD_A:
        write_reg(REG_CAL, CAL_LOW_RANGE)
        current_lsb = LSB_LOW_RANGE
        print(f"\n*** SWITCHED TO LOW RANGE ({current_lsb*1000} mA/bit) ***\n")
        
    # Check if we need to switch TO the HIGH range (to prevent overflow)
    elif current_lsb == LSB_LOW_RANGE and current_A > HIGH_THRESHOLD_A:
        write_reg(REG_CAL, CAL_HIGH_RANGE)
        current_lsb = LSB_HIGH_RANGE
        print(f"\n*** SWITCHED TO HIGH RANGE ({current_lsb*1000} mA/bit) ***\n")


# --- 5. MAIN LOOP (Simulation) ---

if __name__ == '__main__':
    # Initialize the chip (sets CONFIG and starts in HIGH range)
    init_ina231()
    
    # Simulate a current drop over time
    # This loop demonstrates the core logic
    simulated_currents = [
        80.0, 30.0, 22.0,  # High current events
        20.5, 19.5, 15.0,  # Range switching area (crossing 21A/19A)
        0.028, 0.025, 0.010 # Parasitic Drain
    ]
    
    for i, sim_current in enumerate(simulated_currents):
        # NOTE: In a real environment, read_current() gets the value from the chip
        # Here, we fake the raw reading that would result from the chip's *current* LSB
        
        # FAKE the raw value the chip would return:
        raw_reading = round(sim_current / current_lsb)
        
        # FAKE the actual current calculation for the simulation:
        current_A = raw_reading * current_lsb
        
        print("-" * 30)
        print(f"SIMULATION {i+1}: Input={sim_current:.3f} A")
        print(f"Active LSB: {current_lsb*1000} mA/bit")
        print(f"Measured Current: {current_A*1000:.3f} mA")
        
        # Run the switching logic
        monitor_and_switch(current_A)
        
        time.sleep_ms(100)
