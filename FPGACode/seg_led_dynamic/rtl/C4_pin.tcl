#引脚参数导入脚本
#时钟、复位
set_location_assignment PIN_E1 -to clk
set_location_assignment PIN_M15 -to rst_n

#UART
#set_location_assignment PIN_M2 -to uart_rx
#set_location_assignment PIN_G1 -to uart_tx

#LED
#set_location_assignment PIN_D16 -to led[3]
#set_location_assignment PIN_F15 -to led[2]
#set_location_assignment PIN_F16 -to led[1]
#set_location_assignment PIN_G15 -to led[0]

#独立按键
#set_location_assignment PIN_M16 -to key_in[2]
#set_location_assignment PIN_E16 -to key_in[1]
#set_location_assignment PIN_E15 -to key_in[0]

#数码管选段
set_location_assignment PIN_B7 -to dig[0]
set_location_assignment PIN_A8 -to dig[1]
set_location_assignment PIN_A6 -to dig[2]
set_location_assignment PIN_B5 -to dig[3]
set_location_assignment PIN_B6 -to dig[4]
set_location_assignment PIN_A7 -to dig[5]
set_location_assignment PIN_B8 -to dig[6]
set_location_assignment PIN_A5 -to dig[7]

#数码管片选
set_location_assignment PIN_A4 -to sel[0]
set_location_assignment PIN_B4 -to sel[1]
set_location_assignment PIN_A3 -to sel[2]
set_location_assignment PIN_B3 -to sel[3]
set_location_assignment PIN_A2 -to sel[4]
set_location_assignment PIN_B1 -to sel[5]

#蜂鸣器
#set_location_assignment PIN_J1 -to buzzer

#SDRAM
    #地址
#set_location_assignment PIN_T8    -to addr[0]  
#set_location_assignment PIN_P9    -to addr[1]
#set_location_assignment PIN_T9    -to addr[2]
#set_location_assignment PIN_R9    -to addr[3]
#set_location_assignment PIN_L16   -to addr[4]
#set_location_assignment PIN_L15   -to addr[5]
#set_location_assignment PIN_N16   -to addr[6]
#set_location_assignment PIN_N15   -to addr[7]
#set_location_assignment PIN_P16   -to addr[8]
#set_location_assignment PIN_P15   -to addr[9]
#set_location_assignment PIN_R8    -to addr[10]
#set_location_assignment PIN_R16   -to addr[11]
#set_location_assignment PIN_T15   -to addr[12]
    
    #数据
#set_location_assignment PIN_R5    -to dq[0]
#set_location_assignment PIN_T4    -to dq[1]
#set_location_assignment PIN_T3    -to dq[2]
#set_location_assignment PIN_R3    -to dq[3]
#set_location_assignment PIN_T2    -to dq[4]
#set_location_assignment PIN_R1    -to dq[5]
#set_location_assignment PIN_P2    -to dq[6]
#set_location_assignment PIN_P1    -to dq[7]
#set_location_assignment PIN_R13   -to dq[8]
#set_location_assignment PIN_T13   -to dq[9]
#set_location_assignment PIN_R12   -to dq[10]
#set_location_assignment PIN_T12   -to dq[11]
#set_location_assignment PIN_T10   -to dq[12]
#set_location_assignment PIN_R10   -to dq[13]
#set_location_assignment PIN_T11   -to dq[14]
#set_location_assignment PIN_R11   -to dq[15]

    #bank
#set_location_assignment PIN_R7   -to bank[0]
#set_location_assignment PIN_T7   -to bank[1]

    #dqm
#set_location_assignment PIN_N2    -to dqm[0]
#set_location_assignment PIN_T14   -to dqm[1]
    
    #时钟
#set_location_assignment PIN_R4    -to sdram_clk

    #控制信号
#set_location_assignment PIN_R14   -to cke
#set_location_assignment PIN_T6    -to cs_n
#set_location_assignment PIN_R6    -to ras_n
#set_location_assignment PIN_T5    -to cas_n
#set_location_assignment PIN_N1    -to we_n


#flash
#set_location_assignment PIN_H2    -to miso   
#set_location_assignment PIN_C1    -to mosi
#set_location_assignment PIN_H1    -to sclk
#set_location_assignment PIN_D2    -to cs_n

#EEPROM 
#set_location_assignment PIN_L2 -to sda
#set_location_assignment PIN_L1 -to sclk

#VGA

#摄像头




