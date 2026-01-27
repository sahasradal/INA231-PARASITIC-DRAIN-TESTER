#riscv32-unknown-elf-as -g CH32V003_1602LCD_2.S -o CH32V003_1602LCD_2.o
#riscv32-unknown-elf-ld -T CH32V003.ld -Map=final.map CH32V003_1602LCD_2.O
#riscv32-unknown-elf-objcopy -O ihex a.out CH32V003_1602LCD_2.hex




.equ SRAM_start, 0x20000000
.equ SRAM_end, 0x20000800
.equ STACK, 0x20000800
.equ TIM2_BASE, 0x40000000
.equ W_WDG_BASE, 0x40002C00
.equ I_WDG_BASE, 0x40003000
.equ I2C_BASE, 0x40005400
.equ PWR_BASE, 0x40007000
.equ AFIO_BASE, 0x40010000
.equ EXTI_BASE, 0x40010400
.equ PORTA_BASE, 0x40010800
.equ PORTC_BASE, 0x40011000
.equ PORTD_BASE, 0x40011400
.equ ADC_BASE, 0x40012400
.equ TIM1_BASE, 0x40012C00
.equ SPI_BASE, 0x40013000
.equ USART_BASE, 0x40013800
.equ DMA_BASE, 0x40020000
.equ RCC_BASE, 0x40021000
.equ FLASH_INTERFACE_BASE, 0x40022000
.equ EXTENDED_MEM_BASE, 0x40023800
.equ CORE_PRIVATE_BASE, 0xE0000000
.equ FLASH_BASE, 0x08000000
.equ R32_PWR_CTLR, 0x40007000 	#Power control register
.equ R32_PWR_CSR, 0x40007004 	#Power control/status register
.equ R32_PWR_AWUCSR, 0x40007008 	#Auto-wakeup control/status register
.equ R32_PWR_AWUWR, 0x4000700C		#Auto-wakeup window comparison value register
.equ R32_PWR_AWUPSC, 0x40007010 	#Auto-wakeup crossover factor register
.equ R32_RCC_CTLR, 0x40021000 		#Clock control register 0x0000xx83
.equ R32_RCC_CFGR0, 0x40021004 		#Clock configuration register 0 0x00000000
.equ R32_RCC_INTR, 0x40021008 		#Clock interrupt register 0x00000000
.equ R32_RCC_APB2PRSTR, 0x4002100C 	#APB2 peripheral reset register 0x00000000
.equ R32_RCC_APB1PRSTR, 0x40021010 	# APB1 peripheral reset register 0x00000000
.equ R32_RCC_AHBPCENR, 0x40021014 	#AHB peripheral clock enable register 0x00000014
.equ R32_RCC_APB2PCENR, 0x40021018 	#APB2 peripheral clock enable register 0x00000000
.equ R32_RCC_APB1PCENR, 0x4002101C 	#APB1 peripheral clock enable register 0x00000000
.equ R32_RCC_RSTSCKR, 0x40021024   	#Control/status register

.equ R16_IWDG_CTLR, 0x40003000 		#Control register 0x0000
.equ R16_IWDG_PSCR, 0x40003004		#Prescaler register 0x0000
.equ R16_IWDG_RLDR, 0x40003008 		#Reload register 0x0FFF
.equ R16_IWDG_STATR, 0x4000300C 	#Status register

.equ R16_WWDG_CTLR, 0x40002C00 		#Control register 0x007F
.equ R16_WWDG_CFGR, 0x40002C04 		#Configuration Register 0x007F
.equ R16_WWDG_STATR, 0x40002C08 	#Status Register

.equ R32_EXTI_INTENR, 0x40010400 	#Interrupt enable register 0x00000000
.equ R32_EXTI_EVENR,  0x40010404 	#Event enable register 0x00000000
.equ R32_EXTI_RTENR, 0x40010408 	#Rising edge trigger enable register 0x00000000
.equ R32_EXTI_FTENR, 0x4001040C 	#Falling edge trigger enable register 0x00000000
.equ R32_EXTI_SWIEVR, 0x40010410 	#Soft interrupt event register 0x00000000
.equ R32_EXTI_INTFR, 0x40010414 	#Interrupt flag register

.equ R32_PFIC_ISR1, 0xE000E000 		#PFIC interrupt enable status register 1
.equ R32_PFIC_ISR2, 0xE000E004 		#PFIC interrupt enable status register 2 
.equ R32_PFIC_IPR1, 0xE000E020 		#PFIC interrupt pending status register 1 
.equ R32_PFIC_IPR2, 0xE000E024 		#PFIC interrupt pending status register 2 
.equ R32_PFIC_ITHRESDR, 0xE000E040 	#PFIC interrupt priority threshold configuration register
.equ R32_PFIC_CFGR, 0xE000E048 		#PFIC interrupt configuration register
.equ R32_PFIC_GISR, 0xE000E04C 		#PFIC interrupt global status register 
.equ R32_PFIC_VTFIDR, 0xE000E050 	#PFIC VTF interrupt ID configuration register
.equ R32_PFIC_VTFADDRR0, 0xE000E060 	#PFIC VTF interrupt 0 offset address register
.equ R32_PFIC_VTFADDRR1, 0xE000E064 	#PFIC VTF interrupt 1 offset address register
.equ R32_PFIC_IENR1, 0xE000E100		#PFIC interrupt enable setting register 1 
.equ R32_PFIC_IENR2, 0xE000E104 	#PFIC interrupt enable setting register 2 
.equ R32_PFIC_IRER1, 0xE000E180 	#PFIC interrupt enable clear register 1 
.equ R32_PFIC_IRER2, 0xE000E184 	#PFIC interrupt enable clear register 2 
.equ R32_PFIC_IPSR1, 0xE000E200 	#PFIC interrupt pending setting register 1 
.equ R32_PFIC_IPSR2, 0xE000E204 	#PFIC interrupt pending setting register 2 
.equ R32_PFIC_IPRR1, 0xE000E280 	#PFIC interrupt hang clear register 1 
.equ R32_PFIC_IPRR2, 0xE000E284 	#PFIC interrupt hang clear register 2 
.equ R32_PFIC_IACTR1, 0xE000E300 	#PFIC interrupt activation status register1
.equ R32_PFIC_IACTR2, 0xE000E304 	#PFIC interrupt activation status register2
.equ R32_PFIC_IPRIOR1, 0xE000E400 	#PFIC interrupt priority configuration register
.equ R32_PFIC_IPRIOR2, 0xE000E401 	#PFIC interrupt priority configuration register
.equ R32_PFIC_SCTLR, 0xE000ED10 	#PFIC system control register

.equ INTSYSCR, 0x804 			#Interrupt System Control Register
.equ MTVEC, 0x305 			#Exception Entry Base Address Register
.equ DBGMCU_CR, 0x7C0  			#Debug MCU Configuration Register (CSR)
 
.equ R32_STK_CTLR, 0xE000F000 		#System count control register 
.equ R32_STK_SR, 0xE000F004 		#System count status register 
.equ R32_STK_CNTR, 0xE000F008		# System counter low register 
.equ R32_STK_CMPR, 0xE000F010 		#Counting comparison low register


.equ R32_GPIOA_CFGLR, 0x40010800 	#PA port configuration register low 0x44444444
.equ R32_GPIOC_CFGLR, 0x40011000 	#PC port configuration register low 0x44444444
.equ R32_GPIOD_CFGLR, 0x40011400 	#PD port configuration register low 0x44444444
.equ R32_GPIOA_INDR, 0x40010808 	#PA port input data register 0x0000XXXX
.equ R32_GPIOC_INDR, 0x40011008 	#PC port input data register 0x0000XXXX
.equ R32_GPIOD_INDR, 0x40011408 	#PD port input data register 0x0000XXXX
.equ R32_GPIOA_OUTDR, 0x4001080C 	#PA port output data register 0x00000000
.equ R32_GPIOC_OUTDR, 0x4001100C 	#PC port output data register 0x00000000
.equ R32_GPIOD_OUTDR, 0x4001140C 	#PD port output data register 0x00000000
.equ R32_GPIOA_BSHR, 0x40010810 	#PA port set/reset register 0x00000000
.equ R32_GPIOC_BSHR, 0x40011010 	#PC port set/reset register 0x00000000
.equ R32_GPIOD_BSHR, 0x40011410 	#PD port set/reset register 0x00000000
.equ R32_GPIOA_BCR, 0x40010814 		#PA port reset register 0x00000000
.equ R32_GPIOC_BCR, 0x40011014 		#PC port reset register
.equ R32_GPIOD_BCR, 0x40011414 		#PD port reset register 0x00000000
.equ R32_GPIOA_LCKR, 0x40010818 	#PA port configuration lock register 0x00000000
.equ R32_GPIOC_LCKR, 0x40011018 	#PC port configuration lock register 0x00000000
.equ R32_GPIOD_LCKR, 0x40011418 	#PD port configuration lock register 
.equ R32_AFIO_PCFR1, 0x40010004		#AFIO Remap Register 1
.equ R32_AFIO_EXTICR, 0x40010008 	#External interrupt configuration register 1

.equ R32_DMA_INTFR, 0x40020000 		#DMA interrupt status register 0x00000000
.equ R32_DMA_INTFCR, 0x40020004 	#DMA interrupt flag clear register 0x00000000
.equ R32_DMA_CFGR1, 0x40020008 		#DMA channel 1 configuration register 0x00000000
.equ R32_DMA_CNTR1, 0x4002000C 		#DMA channel 1 number of data register
.equ R32_DMA_PADDR1, 0x40020010 	#DMA channel 1 peripheral address register 0x00000000
.equ R32_DMA_MADDR1, 0x40020014 	#DMA channel 1 memory address register 0x00000000
.equ R32_DMA_CFGR2, 0x4002001C 		#DMA channel 2 configuration register 0x00000000
.equ R32_DMA_CNTR2, 0x40020020 		#DMA channel 2 number of data register 0x00000000
.equ R32_DMA_PADDR2, 0x40020024 	#DMA channel 2 peripheral address register 0x00000000
.equ R32_DMA_MADDR2, 0x40020028 	#DMA channel 2 memory address register 0x00000000
.equ R32_DMA_CFGR3, 0x40020030 		#DMA channel 3 configuration register 0x00000000
.equ R32_DMA_CNTR3, 0x40020034 		#DMA channel 3 number of data register 0x00000000
.equ R32_DMA_PADDR3, 0x40020038 	#DMA channel 3 peripheral address register 0x00000000
.equ R32_DMA_MADDR3, 0x4002003C 	#DMA channel 3 memory address register 0x00000000
.equ R32_DMA_CFGR4, 0x40020044 		#DMA channel 4 configuration register 0x00000000
.equ R32_DMA_CNTR4, 0x40020048 		#DMA channel 4 number of data register 0x00000000
.equ R32_DMA_PADDR4, 0x4002004C 	#DMA channel 4 peripheral address register 0x00000000
.equ R32_DMA_MADDR4, 0x40020050 	#DMA channel 4 memory address register 0x00000000
.equ R32_DMA_CFGR5, 0x40020058		#DMA channel 5 configuration register 0x00000000
.equ R32_DMA_CNTR5, 0x4002005C 		#DMA channel 5 number of data register 0x00000000
.equ R32_DMA_PADDR5, 0x40020060 	#DMA channel 5 peripheral address register 0x00000000
.equ R32_DMA_MADDR5, 0x40020064 	#DMA channel 5 memory address register 0x00000000
.equ R32_DMA_CFGR6, 0x4002006C 		#DMA channel 6 configuration register 0x00000000
.equ R32_DMA_CNTR6, 0x40020070 		#DMA channel 6 number of data register 0x00000000
.equ R32_DMA_PADDR6, 0x40020074 	#DMA channel 6 peripheral address register 0x00000000
.equ R32_DMA_MADDR6, 0x40020078 	#DMA channel 6 memory address register 0x00000000
.equ R32_DMA_CFGR7, 0x40020080 		#DMA channel 7 configuration register 0x00000000
.equ R32_DMA_CNTR7, 0x40020084 		#DMA channel 7 number of data register 0x00000000
.equ R32_DMA_PADDR7, 0x40020088 	#DMA channel 7 peripheral address register 0x00000000
.equ R32_DMA_MADDR7, 0x4002008C 	#DMA channel 7 memory address register


.equ R32_ADC_STATR, 0x40012400 		#ADC status register 0x00000000
.equ R32_ADC_CTLR1, 0x40012404 		#ADC control register 1 0x00000000
.equ R32_ADC_CTLR2, 0x40012408 		#ADC control register 2 0x00000000
.equ R32_ADC_SAMPTR1, 0x4001240C 	#ADC sample time register 1 0x00000000
.equ R32_ADC_SAMPTR2, 0x40012410 	#ADC sample time register 2 0x00000000
.equ R32_ADC_IOFR1, 0x40012414 		#ADC injected channel data offset register 1 0x00000000
.equ R32_ADC_IOFR2, 0x40012418 		#ADC injected channel data offset register 2 0x00000000
.equ R32_ADC_IOFR3, 0x4001241C 		#ADC injected channel data offset register 3 0x00000000
.equ R32_ADC_IOFR4, 0x40012420 		#ADC injected channel data offset register 4 0x00000000
.equ R32_ADC_WDHTR, 0x40012424 		#ADC watchdog high threshold register 0x00000000
.equ R32_ADC_WDLTR, 0x40012428 		#ADC watchdog low threshold register 0x00000000
.equ R32_ADC_RSQR1, 0x4001242C 		#ADC regular sequence register 1 0x00000000
.equ R32_ADC_RSQR2, 0x40012430 		#ADC regular sequence register 2 0x00000000
.equ R32_ADC_RSQR3, 0x40012434 		#ADC regular sequence register 3 0x00000000
.equ R32_ADC_ISQR, 0x40012438 		#ADC injected sequence register 0x00000000
.equ R32_ADC_IDATAR1, 0x4001243C 	#ADC injected data register 1 0x00000000
.equ R32_ADC_IDATAR2, 0x40012440 	#ADC injected data register 2 0x00000000
.equ R32_ADC_IDATAR3, 0x40012444 	#ADC injected data register 3 0x00000000
.equ R32_ADC_IDATAR4, 0x40012448 	#ADC injected data register 4 0x00000000
.equ R32_ADC_RDATAR, 0x4001244C 	#ADC regular data register 0x00000000
.equ R32_ADC_DLYR, 0x40012450 		#ADC delayed data register


.equ R16_TIM1_CTLR1, 0x40012C00 	#Control register 1 0x0000
.equ R16_TIM1_CTLR2, 0x40012C04 	#Control register 2 0x0000
.equ R16_TIM1_SMCFGR, 0x40012C08 	#Slave mode control register 0x0000
.equ R16_TIM1_DMAINTENR, 0x40012C0C 	#DMA/interrupt enable register 0x0000
.equ R16_TIM1_INTFR, 0x40012C10 	#Interrupt status register 0x0000
.equ R16_TIM1_SWEVGR, 0x40012C14 	#Event generation register 0x0000
.equ R16_TIM1_CHCTLR1, 0x40012C18 	#Compare/capture control register 1 0x0000
.equ R16_TIM1_CHCTLR2, 0x40012C1C 	#Compare/capture control register 2 0x0000
.equ R16_TIM1_CCER, 0x40012C20 		#Compare/capture enable register 0x0000
.equ R16_TIM1_CNT, 0x40012C24 		#Counters 0x0000
.equ R16_TIM1_PSC, 0x40012C28 		#Counting clock prescaler 0x0000
.equ R16_TIM1_ATRLR, 0x40012C2C 	#Auto-reload value register 0x0000
.equ R16_TIM1_RPTCR, 0x40012C30 	#Recurring count value register 0x0000
.equ R16_TIM1_CH1CVR, 0x40012C34 	#Compare/capture register 1 0x0000
.equ R16_TIM1_CH2CVR, 0x40012C38 	#Compare/capture register 2 0x0000
.equ R16_TIM1_CH3CVR, 0x40012C3C 	#Compare/capture register 3 0x0000
.equ R16_TIM1_CH4CVR, 0x40012C40 	#Compare/capture register 4 0x0000
.equ R16_TIM1_BDTR, 0x40012C44 		#Brake and deadband registers 0x0000
.equ R16_TIM1_DMACFGR, 0x40012C48 	#DMA control register 0x0000
.equ R16_TIM1_DMAADR, 0x40012C4C 	#DMA address register for continuous mode


.equ R16_TIM2_CTLR1, 0x40000000 	#TIM2 control register1 0x0000
.equ R16_TIM2_CTLR2, 0x40000004 	#TIM2 control register2 0x0000
.equ R16_TIM2_SMCFGR, 0x40000008 	#TIM2 Slave mode control register 0x0000
.equ R16_TIM2_DMAINTENR, 0x4000000C 	#TIM2 DMA/interrupt enable register
.equ R16_TIM2_INTFR, 0x40000010 	#TIM2 interrupt status register 0x0000
.equ R16_TIM2_SWEVGR, 0x40000014 	#TIM2 event generation register 0x0000
.equ R16_TIM2_CHCTLR1, 0x40000018 	#TIM2 compare/capture control register1 0x0000
.equ R16_TIM2_CHCTLR2, 0x4000001C 	#TIM2 compare/capture control register2 0x0000
.equ R16_TIM2_CCER, 0x40000020 		#TIM2 compare/capture enable register 0x0000
.equ R16_TIM2_CNT, 0x40000024 		#TIM2 counter 0x0000
.equ R16_TIM2_PSC, 0x40000028 		#TIM2 count clock prescaler 0x0000
.equ R16_TIM2_ATRLR, 0x4000002C 	#TIM2 auto-reload register 0x0000
.equ R16_TIM2_CH1CVR, 0x40000034 	#TIM2 compare/capture register1 0x0000
.equ R16_TIM2_CH2CVR, 0x40000038 	#TIM2 compare/capture register2 0x0000
.equ R16_TIM2_CH3CVR, 0x4000003C 	#TIM2 compare/capture register3 0x0000
.equ R16_TIM2_CH4CVR, 0x40000040 	#TIM2 compare/capture register4 0x0000
.equ R16_TIM2_DMACFGR, 0x40000048 	#TIM2 DMA control register 0x0000
.equ R16_TIM2_DMAADR, 0x4000004C 	#TIM2 DMA address register in continuous mode
  

.equ R32_USART_STATR, 0x40013800 	#UASRT status register 0x000000C0
.equ R32_USART_DATAR, 0x40013804 	#UASRT data register 0x000000XX
.equ R32_USART_BRR, 0x40013808 		#UASRT baud rate register 0x00000000
.equ R32_USART_CTLR1, 0x4001380C 	#UASRT control register 1 0x00000000
.equ R32_USART_CTLR2, 0x40013810 	#UASRT control register 2 0x00000000
.equ R32_USART_CTLR3, 0x40013814 	#UASRT control register 3 0x00000000
.equ R32_USART_GPR, 0x40013818 		#UASRT protection time and prescaler register


.equ R16_I2C_CTLR1, 0x40005400 		#I2C control register 1 0x0000
.equ R16_I2C_CTLR2, 0x40005404 		#I2C control register 2 0x0000
.equ R16_I2C_OADDR1, 0x40005408 	#I2C address register 1 0x0000
.equ R16_I2C_OADDR2, 0x4000540C 	#I2C address register 2 0x0000
.equ R16_I2C_DATAR,  0x40005410 	#I2C data register 0x0000
.equ R16_I2C_STAR1,  0x40005414 	#I2C status register 1 0x0000
.equ R16_I2C_STAR2,  0x40005418 	#I2C status register 2 0x0000
.equ R16_I2C_CKCFGR, 0x4000541C 	#I2C clock register

.equ R16_SPI_CTLR1, 0x40013000 		#SPI Control register1 0x0000
.equ R16_SPI_CTLR2, 0x40013004 		#SPI Control register2 0x0000
.equ R16_SPI_STATR, 0x40013008 		#SPI Status register 0x0002
.equ R16_SPI_DATAR, 0x4001300C 		#SPI Data register 0x0000
.equ R16_SPI_CRCR,  0x40013010 		#SPI Polynomial register 0x0007
.equ R16_SPI_RCRCR, 0x40013014 		#SPI Receive CRC register 0x0000
.equ R16_SPI_TCRCR, 0x40013018 		#SPI Transmit CRC register 0x0000
.equ R16_SPI_HSCR,  0x40013024 		#SPI High-speed control register

.equ R16_ESIG_FLACAP, 0x1FFFF7E0 	#Flash capacity register 0xXXXX
.equ R32_ESIG_UNIID1, 0x1FFFF7E8 	#UID register 1 0xXXXXXXXX
.equ R32_ESIG_UNIID2, 0x1FFFF7EC 	#UID register 2 0xXXXXXXXX
.equ R32_ESIG_UNIID3,  0x1FFFF7F0 	#UID register 3 

.equ R32_FLASH_ACTLR, 0x40022000 	#Control register
.equ R32_FLASH_KEYR,  0x40022004 	#FPEC key register X
.equ R32_FLASH_OBKEYR, 0x40022008 	#OBKEY register X
.equ R32_FLASH_STATR, 0x4002200C 	#Status register 0x00008000
.equ R32_FLASH_CTLR,  0x40022010 	#Configuration register 0x00008080
.equ R32_FLASH_ADDR, 0x40022014 	#Address register X
.equ R32_FLASH_OBR,  0x4002201C 	#Select word register 0x03FFFFFE
.equ R32_FLASH_WPR,  0x40022020 	#Write protection register 0xFFFFFFF
.equ R32_FLASH_MODEKEYR,  0x40022024 	#Extended key register X
.equ R32_FLASH_BOOT_MODEKEYR,  0x40022028 #Unlock BOOT key register

.equ R32_EXTEN_CTR, 0x40023800 		#Configure extended control registers

.equ PFIC_KEY1, 0xFA050000
.equ PFIC_KEY2, 0xBCAF0000
.equ PFIC_KEY3, 0xBEEF0000
.equ mstatus, 	0x300
.equ mtvec, 	0x305
.equ intsyscr, 	0x804
.equ mepc, 	0x341

.equ  SYSTICK_SR_CNTIF, 	(1<<0)
.equ  SYSTICK_CTLR_STE , 	(1<<0)
.equ  SYSTICK_CTLR_STIE, 	(1<<1)
.equ  SYSTICK_CTLR_STCLK, 	(1<<2)
.equ  SYSTICK_CTLR_STRE,  	(1<<3)
.equ  SYSTICK_CTLR_SWIE, 	(1<<31)

.equ data_command1 , 0x09		#0b00001001# data control nibble ,led on P3, EN 0 on P2, R/W 0 (write) in P1 , RS 1 (0 instruction, 1 data) = 1001  =0x09
.equ data_command2 , 0x0d               #0b00001101# data control nibble , 1101  = 0x0D   - EN goes hi=1
.equ data_command3 , 0xF9               #0b00001001# data control nibble , 1011  = 0x0B   - EN goes low=0
.equ inst_command1 , 0x08	        #0b00001000# instruction control nibble ,  led on en-lo,Rw-0,rs =0   = 1000   = 0x08
.equ inst_command2 , 0x0C               #0b00001100# instruction control nibble ,  led on,EN hi , rs/RW 0    = 1100   = 0x0C
.equ inst_command3 , 0xF8               #0b00001011# instruction control nibble  , led on, EN lo ,rs/rw 0    = 1000   = 0x08
.equ LCDWAD , 0x4E 

######################################### SRAM  VARIABLES
fclk 		= 24000000   		# 24Mhz RCO internal , AHB =8Mhz by default
state 		= 0x2000000C 		# located in SRAM
result11 	= 0x20000010 		# 0x20000010 to 0x20000018 is used for storing result in decimal format
result22 	= 0x20000014
fraction 	= 0x20000018
fraction2  	= 0x2000001C
result_lo 	= 0x20000020
result_hi 	= 0x20000024
modulo 		= 0x20000028
scratch 	= 0x2000002C
result1 	= 0x20000030
result2 	= 0x20000034
dividend 	= 0x20000038 
divisor 	= 0x2000003C
scratchpad 	= 0x20000040
buffer		= 0x20000044
mem 		= 0x20000048





# 
# pin PC1  used for SDA
# pin PC2  used for SCL

.macro push val
  addi sp, sp, -4
  sw \val, 0(sp)
.endm

.macro pop val
  lw \val, 0(sp)
  addi sp, sp, 4
.endm

.macro pos x, y
  li x6,\y
  li x7,\x
  call posi
.endm

.macro string address
  addi sp,sp,-4
  sw a2,0(sp)
  la a2,\address
  call string_reader
  lw a2,0(sp)
  addi sp,sp,4
.endm

.macro debug reg
 addi sp, sp, -8      # Adjust stack pointer
 sw   ra, 4(sp)       # Save Return Address
 sw   a5, 0(sp)       # Save a0 (argument register)
 mv   a5, \reg
 call debugger  
 lw   a5, 0(sp)
 lw   ra, 4(sp)
 addi sp, sp, 8
.endm

.align 4
.text
.global start
start:
sp_init:
    	la sp, STACK			# initialize stack pointer
		
#Enable GPIO clocks & AFIO in APB2 clock register
        
    	la x10,R32_RCC_APB2PCENR 	# load address of APB2PCENR register to x10 ,for enabling GPIO A,D,C peripherals
	lw x11,0(x10) 			# load contents from peripheral register R32_RCC_APB2PCENR pointed by x10
	li x7,((1<<2)|(1<<4)|(1<<5)|(1<<0)|(1<<11)|(1<<14)) # 1<<IOPA_EN,1<<IOPC_EN,1<<IOPD_EN,1<<USART_EN,1<<TIM1_EN,1<<AFIOEN, enable port A,C,D and AFIO functions
	or x11,x11,x7 			# or values 
	sw x11,0(x10) 			# store modified enable values in R32_RCC_APB2PCENR

#Enable I2C clock in  APB1 register
    
    	la x10,R32_RCC_APB1PCENR 	# load address of APB1PCENR register to x10 ,for enabling I2C peripheral
	lw x11,0(x10) 			# load contents from peripheral register R32_RCC_APB1PCENR pointed by x10
	li x7,(1<<21) 			# 1<<I2C1_EN, = 1<<21 for I2C functions
	or x11,x11,x7 			# or values 
	sw x11,0(x10) 
###########
 
#configure GPIO PortC as multiplex open drain output for I2C
	la x10,R32_GPIOC_CFGLR 		# load pointer x10 with address of R32_GPIOC_CFGLR , I2C SDA & SCL is on portC PC1,PC2
	lw x11,0(x10) 			# load contents from register pointed by x10
	li x7,~((0xf<<4)|(0xf<<8)) 	# clear pc1,pc2,pc3. we need to setup PC1 & PC2 for I2C and pc3 for DFplayer switching
	and x11,x11,x7 			# clear  mode and cnf bits for selected pin C1,C2
	li x7,((13<<4)|(13<<8)) 	# PC1 = multiplex open drain output 10mhz ,PC2= multiplex open drain output 10mhz, 0b1101, PC3 pushpull out
	or x11,x11,x7 			# OR value to register
	sw x11,0(x10) 			# store in R32_GPIOD_CFGLR
######################
#configure GPIO D 5,6 for UART
	la x10,R32_GPIOD_CFGLR		# load pointer x10 with address of R32_GPIOD_CFGLR , GPIO configuration register
	lw x11,0(x10)			# load contents from register pointed by x10
	li x7,~((0xf<<20)|(0xf<<24))	# clear pd5,pd6. we need to setup PD5 & PD6 for usart tx and rx and pd4 for ETR
	and x11,x11,x7			# clear pd5,pd6 mode and cnf bits for selected pin D4,D5,D6
	li x7,((0x8<<24)|(0xB<<20))	# pd6 = input with PU/PD,pd5= multiplex pushpull output 50mhz,pd4 as floating input
	or x11,x11,x7			# OR value to register
	sw x11,0(x10)			# store in R32_GPIOD_CFGLR

######################

#configure GPIO PortD as pullup input for UART on PD6
	la x10,R32_GPIOD_OUTDR		# output register D, enable 1 in ODR for pUllup with input in pullup/down MODE
	lw x11,0(x10)			# we need 6 as pullup 
	li x7,(1<<6)			# write 1 in GPIOD_OUTDR to enable pull up resistor while GPIOD  RX pin 6 also pull up
	or x11,x11,x7
	sw x11,0(x10)

############
#configure USART baud
	la x10,R32_USART_BRR		# USART BAUD setting
	lw x11,0(x10)			# copy R32_USART_BRR to x11
	li x7,((52<<4)|(1<<0))		# 52.1 in BRR =9600
	or x11,x11,x7			# or registers
	sw x11,0(x10)			# store in R32_USART_BRR

#setup UART control and enable	
	la x10,R32_USART_CTLR1		# load x10 with R32_USART_CTLR1 address
	lw x11,0(x10)			# load to x11 contents
	li x7,(1<<13)|(1<<3)|(1<<2)	# enable USART UE, TX,RX bits		# UE 
	or x11,x11,x7
	sw x11,0(x10)			# store back new values



############
#I2C0 configuration 
	la x10,R32_RCC_APB1PRSTR 	# set pointer to clock control  peripheral reset register 
	lw x11,0(x10) 			# load contents to x11
	li x7,(1<<21) 			# shift 1 to 21st bit position
	or x11,x11,x7 			# OR with x11
	sw x11,0(x10) 			# set bit 21 of R32_RCC_APB1PRSTR to reset I2C peripheral
	not x7,x7 			# invert values in x7
	and x11,x11,x7 			# and x11 to write a 0 in 21st bit
	sw x11,0(x10) 			# store 0 in 21st bit to restart i2c engine

	la x10,R16_I2C_CTLR2 		# set clock in control 2 register
    	lh x11,0(x10) 			# copy contents of R16_I2C_CTLR2 to x11
	li x7,0xffffffc0 		# clear frequency bits 0-5 with bit mask 0xffffffc0
	and x11,x11,x7 			# AND will clear bit 0-5
    	li x7,(8<<0) 			# 8Mhz I2C clock .default 24Mhz HSI/3 =8Mhz APB clock
    	or x11,x11,x7 			# store APB clock frequency in bit 0-5
	sh x11,0(x10) 			# store back in R16_I2C_CTLR2
    	la x10,R16_I2C_CKCFGR 		# set pointer to I2C clockregister
    	lh x11,0(x10) 			# copy values to x11 from above register
	li x7,0xfffff000 		# clear CCR bits 0-11 with bitmask 0xfffff000
	and x11,x11,x7 			# ANDing clears bit 0-11 in x11 register
	li x7,(40<<0) 			# CCR = t(rscl)+t(wsclh)/tpclk1 = 1000+4000/125 =40 , or (8000000/2*100000)=40 , PCLK/2*100Khz =CCR
    	or x11,x11,x7 			# store calculated CCR (data sheet)in x11 by OR
	sh x11,0(x10) 			# store back in peripheral register
	la x10,R16_I2C_CTLR1 		# set pointer to I2C control register 1
	lh x11,0(x10) 			# copy contents
	li x7,(1<<0) 			# 1<<PE = 1<<0 enable bit is bit0,1<<10 is ack enable bit
	or x11,x11,x7 			# OR enable bit to x11
	sh x11,0(x10) 			# store half word in control register 1
	la x10,R16_I2C_CTLR1 		# set pointer to I2C control register 1
	lh x11,0(x10) 			# copy contents
	li x7,(1<<10) 			# 1<<10 is ack enable bit
	or x11,x11,x7 			# OR ACK enable bit to x11
	sh x11,0(x10) 			# store half word in control register 1
#################################
	call I2C_START
	li x15,LCDWAD
	call SEND_ADDRESS
	call LCD_INIT
	call delay1S
	li x15,'y'
	call DATA_WRITE

li x15,'a'
call DATA_WRITE
li x15,'B'
call DATA_WRITE
li x15,'C'
call DATA_WRITE
li x15,'D'
call DATA_WRITE

	call delay1S
	pos 0,0
	string message1
	call delay1S
	call cleardisplay
	call I2C_STOP
	call delay1ms

#j xxx
	call I2C_START
	li x15,0x80 
	call SEND_ADDRESS
	li x15,0x00
	call I2C_WRITE
	call I2C_START
	li x15,0x81
	li t0,2
	la t1,buffer
	call MULTI_READ
xxx:
	
	call I2C_START
	li x15,LCDWAD
	call SEND_ADDRESS
	pos 0,0



	la t1,buffer
	lbu t0,1(t1)
	srli t2,t0,4
	li a3,10
	blt t2,a3,IS_NUM1
	addi t2,t2,55
	mv x15,t2
	call DATA_WRITE
	j A
IS_NUM1:

	addi t2,t2,48
	mv x15,t2
	call DATA_WRITE
	

A:
	lbu t0,1(t1)
	andi t2,t0,0x0f
	li a3,10
	blt t2,a3,IS_NUM2
	addi t2,t2,55
	mv x15,t2
	call DATA_WRITE
	j A1
IS_NUM2:
	addi t2,t2,48
	mv x15,t2
	call DATA_WRITE

A1:

	lbu t0,0(t1)
	srli t2,t0,4
	li a3,10
	blt t2,a3,IS_NUM3
	addi t2,t2,55
	mv x15,t2
	call DATA_WRITE
	j A2
IS_NUM3:
	addi t2,t2,48
	mv x15,t2
	call DATA_WRITE

A2:
	lbu t0,0(t1)
	andi t2,t0,0x0f
	li a3,10
	blt t2,a3,IS_NUM4
	addi t2,t2,55
	mv x15,t2
	call DATA_WRITE
	j here
IS_NUM4:
	addi t2,t2,48
	mv x15,t2
	call DATA_WRITE






here:
	j here
















#######################################################################################
#LCD ROUTINES -------------for writing commands and data  ,use x15 to supply argument
#######################################################################################
COMMAND_WRITE:
		addi sp,sp,-8
		sw ra,0(sp)
		sw a0,4(sp)
                la a0,scratch
		sb x15,0(a0)
		andi x15,x15,0xf0
		ori x15,x15,inst_command1
		call I2C_WRITE
		call delay10us
		call delay10us
		ori x15,x15,inst_command2
		call I2C_WRITE
		call delay10us
		call delay10us
		andi x15,x15,inst_command3
		call I2C_WRITE
		call delay10us
		call delay10us
                la a0,scratch
		lb x15,0(a0)
		andi x15,x15,0x0f
		slli x15,x15,4
		ori x15,x15,inst_command1
		call I2C_WRITE
		call delay10us
		call delay10us
		ori x15,x15,inst_command2
		call I2C_WRITE
		call delay10us
		call delay10us
		andi x15,x15,inst_command3
		call I2C_WRITE
		call delay10us
		call delay10us	
		lw a0,4(sp)
		lw ra,0(sp)
		addi sp,sp,8	
		ret


DATA_WRITE:
		addi sp,sp,-8
		sw ra,0(sp)
		sw a0,4(sp)
                la a0,scratch
		sw x15,0(a0)
		andi x15,x15,0xf0
		ori x15,x15,data_command1
		call I2C_WRITE
		call delay10us
		call delay10us
		ori x15,x15,data_command2
		call I2C_WRITE
		call delay10us
		call delay10us
		andi x15,x15,data_command3
		call I2C_WRITE
		call delay10us
		call delay10us
                la a0,scratch
		lw x15,0(a0)
		andi x15,x15,0x0f
		slli x15,x15,4
		ori x15,x15,data_command1
		call I2C_WRITE
		call delay10us
		call delay10us
		ori x15,x15,data_command2
		call I2C_WRITE
		call delay10us
		call delay10us
		andi x15,x15,data_command3
		call I2C_WRITE
		call delay10us
		call delay10us
		lw a0,4(sp)
		lw ra,0(sp)
		addi sp,sp,8	
		ret		
		
#################################################################################
#hitachi LCD1602 initialization subroutine 4bit mode
#################################################################################
LCD_INIT:
		addi sp,sp,-8
		sw ra,0(sp)
		sw x15,4(sp)
		call delay50ms
		li x15,0x3c
		call I2C_WRITE
		call delay10us
		call delay10us
		li x15,0x38
		call I2C_WRITE
		call delay50ms					

		li x15,0x3c
		call I2C_WRITE
		call delay10us
		call delay10us
		li x15,0x38
		call I2C_WRITE
		call delay50ms	

		li x15,0x3c
		call I2C_WRITE
		call delay10us
		call delay10us
		li x15,0x38
		call I2C_WRITE
		call delay50ms	

		li x15,0x2c
		call I2C_WRITE
		call delay10us
		call delay10us
		li x15,0x28
		call I2C_WRITE
		call delay50ms	

		li x15,0x28
		call COMMAND_WRITE
		call delay10us
		call delay10us
	
		li x15,0x0c
		call COMMAND_WRITE
		call delay10us
		call delay10us

		li x15,0x06
		call COMMAND_WRITE
		call delay10us
		call delay10us

		li x15,0x01
		call COMMAND_WRITE
		call delay10us
		call delay10us


		lw x15,4(sp)
		lw ra,0(sp)
		addi sp,sp,8
		ret
#################################################################################################
#subroutine for LCD cursor positioning , part of MACRO pos . call macro pos 0,0-16 or pos 1,0-16.y=x6,x=x7
#################################################################################################

posi:
		addi sp,sp,-4			# adjust stack pointer
		sw ra,0(sp)			# push RA
		beqz x6,line1			# check the first parameter of macro is 0 or a higher number,if zero go to label first line
		li x6,0xc0			# if not zero the input is for 2nd line. load 0xC0 in r16 which is address of 2nd line first position DDRAM
		add x6,x6,x7			# add with horizontal postion on 2nd line to get the correct DDRAM address
		mv x15,x6			# copy new LCD DDRAM address to I2C data supply register x15
		call COMMAND_WRITE		# send via I2C
		call delay10us
		call delay10us
		lw ra,0(sp)			# pop RA
		addi sp,sp,4			# adjust stack pointer
		ret				# return to caller
line1:
		li x6,0x80			# if Y = 0 which means 1st line of LCD load address of 1st line 1st position DDRAM =0x80
		add x6,x6,x7			# add 0x80 to X position saved in r6 to get the start postion on 1st line
		mv x15,x6			# copy new LCD DDRAM address to X15 , argument for I2C in x15
		call COMMAND_WRITE		# send via I2C
		call delay10us
		call delay10us
		lw ra,0(sp)			# pop RA
		addi sp,sp,4			# adjust stack pointer
		ret				# return to caller		

#################################################################################
#subroutine for sending strings to LCD part of MACRO  string
# reads a string with address loaded in a2,    la a2, my_string , uses x15 for I2C
####################################################################################
string_reader:
	addi sp,sp,-8
	sw ra,0(sp)
	sw x15,4(sp)
sr_loop:
    	lb a5, 0(a2)             	# Load the current byte (character) into a1
    	beq a5, zero, end_loop   	# If character is null (0), exit the loop
	call DATA_WRITE			# send via I2C
	call delay10us
	call delay10us
	addi a2,a2,1			# advance message address byte by byte
	j sr_loop             		# Repeat the loop
end_loop:
	lw x15,4(sp)
	lw ra,0(sp)
	addi sp,sp,8
    	ret				# Exit the program
#################################################################################
#subroutine to clear LCD screen 
######################################################################################
cleardisplay:
		addi sp,sp,-8
		sw ra,0(sp)
		sw x15,4(sp)
		li x15,0x01
		call COMMAND_WRITE
		call delay10us
		call delay10us
		li x15,0x02
		call COMMAND_WRITE
		call delay10us
		call delay10us
		call delay1ms
		lw x15,4(sp)
		lw ra,0(sp)
		addi sp,sp,8
		ret

####----I2C--FUNCTIONS-----------------------------------------------------------------------------
I2C_BUSY:
	addi sp,sp,-12
	sw ra,0(sp)
	sw x10,4(sp)
	sw x11,8(sp)
IB:
	la x10, R16_I2C_STAR2 		# set pointer x10 to I2C status register 2, busy bit resides there
	lh x11,0(x10) 			# copy to x11 I2C_STAR2 register contents
	andi x11,x11,(1<<1) 		# and x11 with 1<<I2CBUSY
	bnez x11,IB 			# if not 0 loop till I2CBUSY bit becomes 0

	lw x11,8(sp)
	lw x10,4(sp)
	lw ra,0(sp)
	addi sp,sp,12
	ret 
#####################

I2C_START: 				# send start condition on I2C bus
	addi sp,sp,-20
	sw ra,0(sp)
	sw x12,4(sp)
	sw x11,8(sp)
	sw x10,12(sp)
	sw x7,16(sp)

	la x10,R16_I2C_CTLR1 		# start bit is in i2c cotrol register bit 8
	lh x11,0(x10) 			# copy contents of control register
	ori x11,x11,((1<<10) | (1<<8)) 	# set start bit8 and ack enable bit10
	sh x11,0(x10) 			# store in I2C_CTL0 register
check_master_mode_bit: 			# below code checks start bit is set , master mode bit is set and bus busy bit is set, reading STAR1 & STAR2 clears start bit
	la x10, R16_I2C_STAR1 		# set pointer to status register1
	lh x11,0(x10) 			# read contents to x11
	la x10, R16_I2C_STAR2 		# set pointer to status register2
	lh x12,0(x10) 			# read contents to x12
	slli x12,x12,16 		# shift x12 16 position to add x11 and x12 to accomodate all status bits in 1 register (x11)
	or x11,x11,x12 			# OR both registers , both STAR1 & STAR2 in X11
	li x7,0x00030001 		# BUSY, MSL and SB status bits
	and x11,x11,x7 			# ANDing yeilds the above 3 status bits
	bne x11,x7,check_master_mode_bit # if all 3 bits not sets wait in a loop

	lw x7,16(sp)
	lw x10,12(sp)
	lw x11,8(sp)
	lw x12,4(sp)
	lw ra,0(sp)
	addi sp,sp,20
	ret
#####################################

I2C_WRITE:
	addi sp,sp,-12
	sw ra,0(sp)
	sw x10,4(sp)
	sw x11,8(sp)
IW:
	la x10,R16_I2C_STAR1 		# i2c_status1 register
	lh x11,0(x10) 			# read and copy contents
	andi x11,x11,(1<<7) 		# and contents of x11 with TxE bit7 , if set transmission buffer empty
	beqz x11,IW 			# wait till TBE is set (loop if a3 is 0)
	la x10,R16_I2C_DATAR 		# set pointer to I2C data register
	sb x15,0(x10) 			# store data loaded in x15 to I2C data register

# 3. NEW: Wait for BTF (Byte Transfer Finished) 
# This ensures the bits are physically on the bus before we do anything else.
IW_WaitBTF:
    	la x10,R16_I2C_STAR1
    	lh x11,0(x10)
    	andi x11,x11,(1<<2)        # Bit 2 is usually BTF (Byte Transfer Finished)
    	beqz x11,IW_WaitBTF

	lw x11,8(sp)
	lw x10,4(sp)
	lw ra,0(sp)
	addi sp,sp,12
	ret # return to caller
####################################

CLEAR_ACK: 				# subroutine to clear ACKEN bit in I2C_CTLR1 register
	addi sp,sp,-12
	sw ra,0(sp)
	sw x10,4(sp)
	sw x11,8(sp)

	la x10,R16_I2C_CTLR1
	lh x11,0(x10) 			# copy to x11 contents of I2C_CTL0 rgister
	andi x11,x11,~(1<<10) 		# and with 0 shifted to ACK bit10
	sh x11,0(x10) 			# write back to register

	lw x11,8(sp)
	lw x10,4(sp)
	lw ra,0(sp)
	addi sp,sp,12
	ret 				# return to caller
####################################

I2C_TX_COMPLETE: 			# subroutine checks weather I2C transmission is complete
	addi sp,sp,-12
	sw ra,0(sp)
	sw x10,4(sp)
	sw x11,8(sp)
TX:
	la x10,R16_I2C_STAR1
	lh x11,0(x10)
	andi x11,x11,(1<<7) 		# check TBE(7) is set 
	beqz x11,TX 			# if not wait by looping to label I2C_TX_COMPLETE 

	lw x11,8(sp)
	lw x10,4(sp)
	lw ra,0(sp)
	addi sp,sp,12
	ret 				# return to caller
#####################################

I2C_STOP: 				# subroutine to stop I2C transmission
	addi sp,sp,-12
	sw ra,0(sp)
	sw x10,4(sp)
	sw x11,8(sp)

	la x10,R16_I2C_CTLR1
	lh x11,0(x10)
	ori x11,x11,(1<<9) 		# set STOP bit9 in I2C_CTRL1 register
	sh x11,0(x10)

	lw x11,8(sp)
	lw x10,4(sp)
	lw ra,0(sp)
	addi sp,sp,12
	ret # return to caller
#####################################

SEND_ADDRESS: # sends address , address to be loaded in x15
	addi sp,sp,-20
	sw ra,0(sp)
	sw x10,4(sp)
	sw x11,8(sp)
	sw x12,12(sp)
	sw x7,16(sp)

	la x10,R16_I2C_DATAR 		# set pointer to data register
	sb x15,0(x10) 			# store byte in x15 to I2C data register
address_transmit:
	la x10, R16_I2C_STAR1 		# reading STAR1 followed by STAR2 clears the address bit
	lh x11,0(x10)
	la x10, R16_I2C_STAR2 		# reading STAR1 followed by STAR2 clears the address bit
	lh x12,0(x10)
	slli x12,x12,16 		# shift STAR2 by 16 bits LHS
	or x11,x11,x12 			# STAR1 & STAR2 now in x11, top16 bits STAR2 , lower 15 bits STAR1 
	li x7,0x00070082 		# BUSY, MSL, ADDR, TXE and TRA status
	and x11,x11,x7 			# and with above bit mask to see whether these bits are set in status register
	bne x11,x7,address_transmit 	# sit in tight loop until above bits are set in both status register

	lw x7,16(sp)
	lw x12,12(sp)
	lw x11,8(sp)
	lw x10,4(sp)
	lw ra,0(sp)
	addi sp,sp,20
	ret
########################################

check_i2c_status:
	addi sp,sp,-16
	sw ra,0(sp)
	sw x10,4(sp)
	sw x11,8(sp)
	sw x12,12(sp)

	la x10, R16_I2C_STAR1 		# set pointer x10 to R16_I2C_STAR1 , status register 1
	lh x11,0(x10) 			# copy contents to x11
	la x10, R16_I2C_STAR2 		# set pointer to R16_I2C_STAR2
	lh x12,0(x10) 			# copy contents to x12
	slli x12,x12,16 		# shift x12 16 position to left and OR it with x11 to hold both register values in 1 32 bit register
	or x11,x11,x12 			# status register 1 = 0-15 bits and status register2 = 16-32 bit
	la x10,buffer 			# point x10 to SRAM buffer , address 0x20000004
	sw x11,0(x10) 			# store status data in sram for future use

	lw x12,12(sp)
	lw x11,8(sp)
	lw x10,4(sp)
	lw ra,0(sp)
	addi sp,sp,16
	ret
#################################################################
#############################################
check_btf:
	addi sp,sp,-12
	sw ra,0(sp)
	sw x10,4(sp)
	sw x11,8(sp)
BTF:
	la x10,R16_I2C_STAR1
	lw x11,0(x10)
	andi x11,x11,(1<<2)
	beqz x11,BTF

	lw x11,8(sp)
	lw x10,4(sp)
	lw ra,0(sp)
	addi sp,sp,12
	ret
#############################################################
# I2C read routines , call with address in x15
#############################################################
I2C_READ_ONE:   			# (subroutine for single byte reception)
	addi sp,sp,-20
	sw ra,0(sp)
	sw x10,4(sp)
	sw x11,8(sp)
	sw t1,12(sp)
	sw x12,16(sp)

	la t1,buffer 			# load address of memory location with label buffer
radd_transmit1: 			# this code block below checks whether address bit is set when address is transmitted successfully
	la x10,R16_I2C_STAR1 		# set x10 pointer to I2C status register 1
	lh x11,0(x10) 			# copy contents to x11
	la x10,R16_I2C_STAR2 		# set x10 pointer to I2C status register 2 
	lh x12,0(x10) 			# copy contents to x12
	slli x12,x12,16 		# shift half woord in x12 16 bits left (top half)
	or x11,x11,x12 			# OR left aligned X12 with right aligned x11, both status register bits now in x11
	li x7,0x00030002 		# load bit mask to test BUSY, MSL, ADDR, status for Mster receiver mode
	and x11,x11,x7 			# AND bit mask with x11 (status register contents)
	bne x11,x7,radd_transmit1 	# if 0x00030002 is set address transmission success. else sit in tight loop till address tx is complete
	la x10,R16_I2C_STAR1 		# dummy read R16_I2C_STAR1 followed by R16_I2C_STAR2 to clear ADDR bit in I2C_STAR1 register
	lh x11,0(x10) 			# dummy read
	la x10,R16_I2C_STAR2 		# dummy read R16_I2C_STAR1 followed by R16_I2C_STAR2 to clear ADDR bit in I2C_STAR1 register
	lh x11,0(x10) 			# dummy read
	call CLEAR_ACK 			# call subroutine to clear ACK bit (EVT6_1)
	call I2C_STOP 			# call subroutine to set STOP bit (EVT6_1)
R1:
	la x10,R16_I2C_STAR1 		# copy contents of I2C_STAT0 register to x11
	lw x11,0(x10)
	andi x11,x11,(1<<6) 		# and x11 with RxNE bit6 mask (receive buffer not empty)
	beqz x11,R1 			# if a3 is 0 wait by looping to R1 label until RBNE is set
	la x10,R16_I2C_DATAR 		# set pointer to I2C data register
	lb x15,0(x10) 			# copy contents of I2C data register to x15
	sb x15, 0(t1) 			# store byte in x15 to memory location buffer pointed by t0 register offset 0

	lw x12,16(sp)
	lw t1,12(sp)
	lw x11,8(sp)
	lw x10,4(sp)
	lw ra,0(sp)
	addi sp,sp,20
	ret # return to caller

###############

###############################################################################
# subroutine to read 2 or more bytes , load read address in x15 and call
# load t1 with location address to store received data
# load t0 with number of bytes to be received
# load t2 (7) with 2 indicates last 2 bytes to be received
################################################################################
MULTI_READ: 
	addi sp,sp,-28
	sw ra,0(sp)
	sw x10,4(sp)
	sw x11,8(sp)
	sw t1,12(sp)
	sw t2,16(sp)
	sw t0,20(sp)
	sw x12,24(sp)

	la x10,R16_I2C_DATAR 		# set pointer to I2C data register
	sb x15,0(x10) 			# store byte in x15 to I2C data register to be transmitted to slave
radd_transmit: 				# this code block below checks whether address bit is set when address is transmitted successfully
	la x10,R16_I2C_STAR1 		# set x10 pointer to I2C status register 1
	lh x11,0(x10) 			# copy contents to x11
	la x10,R16_I2C_STAR2 		# set x10 pointer to I2C status register 2 
	lh x12,0(x10) 			# copy contents to x12
	slli x12,x12,16 		# shift half woord in x12 16 bits left (top half)
	or x11,x11,x12 			# OR left aligned X12 with right aligned x11, both status register bits now in x11
	li x7,0x00030002 		# load bit mask to test BUSY, MSL, ADDR, status for Mster receiver mode
	and x11,x11,x7 			# AND bit mask with x11 (status register contents)
	bne x11,x7,radd_transmit 	# if 0x00030002 is set address transmission success. else sit in tight loop till address tx is complete
	la x10,R16_I2C_STAR1 		# dummy read R16_I2C_STAR1 followed by R16_I2C_STAR2 to clear ADDR bit in I2C_STAR1 register
	lh x11,0(x10) 			# read
	la x10,R16_I2C_STAR2 		# dummy read R16_I2C_STAR1 followed by R16_I2C_STAR2 to clear ADDR bit in I2C_STAR1 register
	lh x11,0(x10) 			# read

	# la t1,buffer 			# load address of memory location with label buffer
	# li t0,6 			# t0 is loaded with number of bytes received
	li x7,2 			# load t2 with compare value 2 (last 2 bytes count of message to be received)
	bleu t0,x7,BBYTES2 		# branch to label BYTES2 if t0 is equal or lower than t2 (t2 = 2) , if condition meets we have reached last 2 bytes 
R11:
	la x10,R16_I2C_STAR1 		# copy contents of I2C_STAT1 register to x11
	lw x11,0(x10) 			# copy to x11 contents I2C_STAT1
	andi x11,x11,(1<<6) 		# and x11 with RxNE bit6 mask (receive buffer not empty)
	beqz x11,R11 			# wait till RxNE is set ( data arrived in data register)

	la x10,R16_I2C_DATAR 		# set pointer to I2C data register
	lb x15,0(x10) 			# copy contents of I2C data register to x15
	sb x15,0(t1) 			# store received byte in x15 to address pointed by t1 register (buffer here)
	addi t1,t1,1 			# increase buffer address + 1
	addi t0,t0,-1 			# decrease counter of received bytes
	bleu t0,x7,BBYTES2 		# branch to label BYTES2 if t0 is equal or lower than t2 (t2 = 2) , if condition meets we have reached last 2 bytes 
	j R11 				# if not reached last 2 bytes jump back to R2 to receive bytes
BBYTES2: 				# reach here if the read has reached last 2 bytes of the message
	la x10,R16_I2C_STAR1 		# status register1
	lh x11,0(x10) 			# copy to x11 I2C_STAT0 register
	andi x11,x11,(1<<6) 		# check RxNE bit6 is set by anding x11
	beqz x11,BBYTES2 		# wait till RxNE is set by looping
	la x10,R16_I2C_DATAR 		# set pointer to I2C data register
	lb x15,0(x10) 			# copy contents of I2C data register to x15
	sb x15,0(t1) 			# store 2nd last byte in x15 to memory location buffer
	addi t1,t1,1 			# increase buffer address + 1
	call CLEAR_ACK 			# clear ACK bit so that master will send NAK to stop slave from sending data after next byte
	call I2C_STOP 			# set STOP bit to terminate I2C operation after next byte (last one)
BBYTES1: # last byte
	la x10,R16_I2C_STAR1 		# set pointer x10 to I2C status register1
	lh x11,0(x10) 			# copy contents to x11
	andi x11,x11,(1<<6) 		# check RxNE bit6 is set by anding x11
	beqz x11,BBYTES1 		# sit in tight loop till RxNE sets
	la x10,R16_I2C_DATAR 		# set pointer to I2C data register
	lb x15,0(x10) 			# copy last byte transmitted from slave to I2C data register to x15
	sb x15,0(t1) 			# store byte in x15 to memory location buffer pointed by t0

	lw x12,24(sp)
	lw t0,20(sp)
	lw t2,16(sp)
	lw t1,12(sp)
	lw x11,8(sp)
	lw x10,4(sp)
	lw ra,0(sp)
	addi sp,sp,28
	ret

################################################################################

#==========================================
delay10S: 
	addi sp,sp,-8 			# push RA
	sw ra,0(sp) 			# push RA
	sw t1,4(sp)
	li t1,20100101 			# load an arbitarary value 20000000 to t1 register 
loop10S:
	addi t1,t1,-1 			# subtract 1 from t1
	bne t1,zero,loop10S 		# if t1 not equal to 0 branch to label loop
	lw t1,4(sp)
	lw ra,0(sp) 			# POP RA
	addi sp,sp,8 			# pop RA
	ret 

delay1S: 
	addi sp,sp,-8 			# push RA
	sw ra,0(sp) 			# push RA
	sw t1,4(sp)
	li t1,2010010 			# load an arbitarary value 20000000 to t1 register 
loop1s:
	addi t1,t1,-1 			# subtract 1 from t1
	bne t1,zero,loop1s 		# if t1 not equal to 0 branch to label loop
	lw t1,4(sp)
	lw ra,0(sp) 			# POP RA
	addi sp,sp,8 			# pop RA
	ret 

delay1ms:
	addi sp,sp,-8 			# push RA
	sw ra,0(sp) 			# push RA
	sw t1,4(sp) 
	li t1,2010 			# load an arbitarary value 20000000 to t1 register 
loop1ms:
	addi t1,t1,-1 			# subtract 1 from t1
	bne t1,zero,loop1ms 		# if t1 not equal to 0 branch to label loop
	lw t1,4(sp)
	lw ra,0(sp) 			# POP RA
	addi sp,sp,8 			# pop RA 
	ret 

delay10ms:
	addi sp,sp,-8 			# push RA
	sw ra,0(sp) 			# push RA
	sw t1,4(sp) 
	li t1,20100 			# load an arbitarary value 20000000 to t1 register 
loop10ms:
	addi t1,t1,-1 			# subtract 1 from t1
	bne t1,zero,loop10ms 		# if t1 not equal to 0 branch to label loop
	lw t1,4(sp)
	lw ra,0(sp) 			# POP RA
	addi sp,sp,8 			# pop RA
	ret

delay50ms:
	addi sp,sp,-8 			# push RA
	sw ra,0(sp) 			# push RA
	sw t1,4(sp) 
	li t1,100500 			# load an arbitrary value 20000000 to t1 register 
loop50ms:
	addi t1,t1,-1 			# subtract 1 from t1
	bne t1,zero,loop50ms 		# if t1 not equal to 0 branch to label loop
	lw t1,4(sp)
	lw ra,0(sp) 			# POP RA
	addi sp,sp,8 			# pop RA
	ret 

delay10us:
	addi sp,sp,-8 			# push RA
	sw ra,0(sp) 			# push RA
	sw t1,4(sp) 
	li t1,105			# load an arbitrary value 20000000 to t1 register 
loop10us:
	addi t1,t1,-1 			# subtract 1 from t1
	bne t1,zero,loop10us 		# if t1 not equal to 0 branch to label loop
	lw t1,4(sp)
	lw ra,0(sp) 			# POP RA
	addi sp,sp,8 			# pop RA
	ret 

#####################################################################
#load byte in x8 for UART and call USART_TX to transmit a byte
#####################################################################	
	
USART_TX:
	addi sp,sp,-16			# add space in stack
	sw ra,0(sp)			# push ra
	sw x7,4(sp)			# push x7
	sw x10,8(sp)			# push x10
	sw x11,12(sp)			# push x11

	li x10,R32_USART_STATR		# load address of usart status register
	lw x11,0(x10)			# load contents of status register in x11
	andi x11,x11,(1<<7)		# mask out 7th bit, transmit buffer empty flag
	beqz x11,USART_TX		# if 0 transmit buffer full, wait until bit is set
	#li x8,0x30
	mv x7,x8			# move byte in x8 to x7
	li x10,R32_USART_DATAR		# x10 has the address of data register
	sb x7,0(x10)			#store byte in x7 to data register
TC_check:
	li x10,R32_USART_STATR		# get contents of status register again
	lw x11,0(x10)
	andi x11,x11,(1<<6)		# check transmit complete bit
	beqz x11,TC_check		# wait if bit is 0 , when transmit complete = 1
		
	lw x11,12(sp)			# pop x11
	lw x10,8(sp)			# pop x10
	lw x7,4(sp)			# pop x7
	lw ra,0(sp)			# pop ra
	addi sp,sp,16			# set SP back 16 bytes
	ret				# return to caller

########################################################
###############################################################################################
# debugging register, call macro debug . eg debug a0 , prints value in a0 to lcd in hexadecimal
################################################################################################
debugger:
	addi sp,sp,-8
	sw ra,0(sp)
	sw t0,4(sp)
	srli t0,a5,24		# byte3 , shift right 24 bits and isolate byte3		
	call HEX		# call routine to convert byte to hexadecimal ascii
	srli t0,a5,16		# byte2 , shift right 16 bits to isolate top 2 bytes (byte3 and byte2)
	andi t0,t0,0xff		# and with bit mask 0x000000ff to extract byte2
	call HEX		# call routine to convert byte to hexadecimal ascii
	srli t0,a5,8		# byte1 ,shift right to isolate top 3 bytes byte3,byte2 and byte1
	andi t0,t0,0xff		# and with bit mask 0x000000ff to extract byte1		
	call HEX		# call routine to convert byte to hexadecimal ascii
	mv t0,a5		# copy full word from a5 to t0
	andi t0,t0,0xff		# byte0 , and with bit mask 0x000000ff to extract byte0
	call HEX		# call routine to convert byte to hexadecimal ascii
	lw t0,4(sp)
	lw ra,0(sp)
	addi sp,sp,8
    	ret				# Exit the program

HEX:
	addi sp,sp,-8
	sw ra,0(sp)
	sw t2,4(sp)

	srli t2,t0,4
	call convert_to_hex	# call routine to convert number in ascii represented hexadecimal
	andi t2,t0,0x0f
	call convert_to_hex	# call routine to convert number in ascii represented hexadecimal

	lw t2,4(sp)
	lw ra,0(sp)
	addi sp,sp,8
	ret

convert_to_hex:
	addi sp,sp,-12
	sw ra,0(sp)
	sw t1,4(sp)
	sw a5,8(sp)

	li t1,10		# load t1 with comparison value 10
	blt t2,t1,IS_NUM	# if value in t2 is less than 10 it is a number 0-9, else it is alphabet A-F
	addi t2,t2,55		# add 55 with number to get ascii of the alphabet
	mv a5,t2		# copy ascii enabled byte to a5 register for printing on LCD
	call DATA_WRITE		# call routine to write data to LCD
	j A			# jump to A for exiting
IS_NUM:
	addi t2,t2,48		# add 48 to value in t2 to get ASCII representation of number
	mv a5,t2		# copy ascii enabled byte to a5 register for printing on LCD
	call DATA_WRITE		# call routine to write data to LCD
A:
	lw a5,8(sp)
	lw t1,4(sp)
	lw ra,0(sp)
	addi sp,sp,12
	ret

#################################################
.align 4
.section .rodata
.global message

message1: .asciz " testing I2C slave "
message2: .asciz " b 4 weighing "
message3: .asciz " weight "
message4: .asciz " zeroing "
message5: .asciz " place weight 5gm "
message6: .asciz " place weight 10gm "


