        .section            .isr_vector

        .equ    _stack_size, 0x400
        .equ    _stack,_ebss + _stack_size

        .word     _stack                      // Stack
        .word     reset_handler               // Reset Handler
        .word     nmi_handler                 // NMI Handler
        .word     hard_fault_handler          // Hard Fault Handler
        .word     mem_manage_handler          // MPU Fault Handler
        .word     bus_fault_handler           // Bus Fault Handler
        .word     usage_fault_handler         // Usage Fault Handler
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     sv_call_handler             // SVCall Handler
        .word     debug_monitor_handler       // Debug Monitor Handler
        .word     0                           // Reserved
        .word     pend_sv_handler             // PendSV Handler
        .word     sys_tick_handler            // SysTick Handler
        .word     gpio_porta_handler          // GPIO Port A
        .word     gpio_portb_handler          // GPIO Port B
        .word     gpio_portc_handler          // GPIO Port C
        .word     gpio_portd_handler          // GPIO Port D
        .word     gpio_porte_handler          // GPIO Port E
        .word     uart0_handler               // UART0 Rx and Tx
        .word     uart1_handler               // UART1 Rx and Tx
        .word     ssi0_handler                // SSI0 Rx and Tx
        .word     i2c0_handler                // I2C0 Master and Slave
        .word     pwm0_fault_handler          // PWM 0 Fault
        .word     pwm0_generator0_handler     // PWM 0 Generator 0
        .word     pwm0_generator1_handler     // PWM 0 Generator 1
        .word     pwm0_generator2_handler     // PWM 0 Generator 2
        .word     quadrature0_handler         // Quadrature Encoder 0
        .word     adc0_seq0_handler           // ADC0 Sequence 0
        .word     adc0_seq1_handler           // ADC0 Sequence 1
        .word     adc0_seq2_handler           // ADC0 Sequence 2
        .word     adc0_seq3_handler           // ADC0 Sequence 3
        .word     wdt_handler                 // Watchdog
        .word     timer0a_handler             // Timer 0 subtimer A
        .word     timer0b_handler             // Timer 0 subtimer B
        .word     timer1a_handler             // Timer 1 subtimer A
        .word     timer1b_handler             // Timer 1 subtimer B
        .word     timer2a_handler             // Timer 2 subtimer A
        .word     timer2b_handler             // Timer 2 subtimer B
        .word     comp0_handler               // Analog Comp 0
        .word     comp1_handler               // Analog Comp 1
        .word     comp2_handler               // Analog Comp 2
        .word     sys_ctl_handler             // System Control
        .word     flash_ctl_handler           // Flash Control
        .word     gpio_portf_handler          // GPIO Port F
        .word     gpio_portg_handler          // GPIO Port G
        .word     gpio_porth_handler          // GPIO Port H
        .word     uart2_handler               // UART2 Rx and Tx
        .word     ssi1_handler                // SSI1 Rx and Tx
        .word     timer3a_handler             // Timer 3 subtimer A
        .word     timer3b_handler             // Timer 3 subtimer B
        .word     i2c1_handler                // I2C1 Master and Slave
        .word     quadrature1_handler         // Quadrature Encoder 1
        .word     can0_handler                // CAN0
        .word     can1_handler                // CAN1
        .word     can2_handler                // CAN2
        .word     ethernet_handler            // Ethernet
        .word     hibernate_handler           // Hibernate
        .word     usb0_handler                // USB0
        .word     pwm0_generator3_handler     // PWM 0 Generator 3
        .word     udma_handler                // uDMA Software Transfer
        .word     udma_error                  // uDMA Error
        .word     adc1_seq0_handler           // ADC1 Sequence 0
        .word     adc1_seq1_handler           // ADC1 Sequence 1
        .word     adc1_seq2_handler           // ADC1 Sequence 2
        .word     adc1_seq3_handler           // ADC1 Sequence 3
        .word     i2s0_handler                // I2S0
        .word     ext_bus_handler             // External Bus Interface 0
        .word     gpio_portj_handler          // GPIO Port J
        .word     gpio_portk_handler          // GPIO Port K
        .word     gpio_portl_handler          // GPIO Port L
        .word     ssi2_handler                // SSI2 Rx and Tx
        .word     ssi3_handler                // SSI3 Rx and Tx
        .word     uart3_handler               // UART3 Rx and Tx
        .word     uart4_handler               // UART4 Rx and Tx
        .word     uart5_handler               // UART5 Rx and Tx
        .word     uart6_handler               // UART6 Rx and Tx
        .word     uart7_handler               // UART7 Rx and Tx
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     i2c2_handler                // I2C2 Master and Slave
        .word     i2c3_handler                // I2C3 Master and Slave
        .word     timer4a_handler             // Timer 4 subtimer A
        .word     timer4b_handler             // Timer 4 subtimer B
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     0                           // Reserved
        .word     timer5a_handler             // Timer 5 subtimer A
        .word     timer5b_handler             // Timer 5 subtimer B
        .word     wide_timer0a_handler        // Wide Timer 0 subtimer A
        .word     wide_timer0b_handler        // Wide Timer 0 subtimer B
        .word     wide_timer1a_handler        // Wide Timer 1 subtimer A
        .word     wide_timer1b_handler        // Wide Timer 1 subtimer B
        .word     wide_timer2a_handler        // Wide Timer 2 subtimer A
        .word     wide_timer2b_handler        // Wide Timer 2 subtimer B
        .word     wide_timer3a_handler        // Wide Timer 3 subtimer A
        .word     wide_timer3b_handler        // Wide Timer 3 subtimer B
        .word     wide_timer4a_handler        // Wide Timer 4 subtimer A
        .word     wide_timer4b_handler        // Wide Timer 4 subtimer B
        .word     wide_timer5a_handler        // Wide Timer 5 subtimer A
        .word     wide_timer5b_handler        // Wide Timer 5 subtimer B
        .word     fpu_handler                 // FPU
        .word     peci0_handler               // PECI 0
        .word     lpc0_handler                // LPC 0
        .word     i2c4_handler                // I2C4 Master and Slave
        .word     i2c5_handler                // I2C5 Master and Slave
        .word     gpio_portm_handler          // GPIO Port M
        .word     gpio_portn_handler          // GPIO Port N
        .word     quadrature2_handler         // Quadrature Encoder 2
        .word     fan0_handler                // Fan 0
        .word     0                           // Reserved
        .word     gpio_portp_handler          // GPIO Port P (Summary or P0)
        .word     gpio_portp1_handler         // GPIO Port P1
        .word     gpio_portp2_handler         // GPIO Port P2
        .word     gpio_portp3_handler         // GPIO Port P3
        .word     gpio_portp4_handler         // GPIO Port P4
        .word     gpio_portp5_handler         // GPIO Port P5
        .word     gpio_portp6_handler         // GPIO Port P6
        .word     gpio_portp7_handler         // GPIO Port P7
        .word     gpio_portq_handler          // GPIO Port Q (Summary or Q0)
        .word     gpio_portq1_handler         // GPIO Port Q1
        .word     gpio_portq2_handler         // GPIO Port Q2
        .word     gpio_portq3_handler         // GPIO Port Q3
        .word     gpio_portq4_handler         // GPIO Port Q4
        .word     gpio_portq5_handler         // GPIO Port Q5
        .word     gpio_portq6_handler         // GPIO Port Q6
        .word     gpio_portq7_handler         // GPIO Port Q7
        .word     gpio_portr_handler          // GPIO Port R
        .word     gpio_ports_handler          // GPIO Port S
        .word     pwm1_generator0_handler     // PWM 1 Generator 0
        .word     pwm1_generator1_handler     // PWM 1 Generator 1
        .word     pwm1_generator2_handler     // PWM 1 Generator 2
        .word     pwm1_generator3_handler     // PWM 1 Generator 3
        .word     pwm1_fault_handler          // PWM 1 Fault


        .equ     nmi_handler,  _default_handler
        .equ     hard_fault_handler,  _default_handler
        .equ     mem_manage_handler,  _default_handler
        .equ     bus_fault_handler,  _default_handler
        .equ     usage_fault_handler,  _default_handler
        .equ     sv_call_handler,  _default_handler
        .equ     debug_monitor_handler,  _default_handler
        .equ     pend_sv_handler,  _default_handler
        .equ     sys_tick_handler,  _default_handler
        .equ     gpio_porta_handler,  _default_handler
        .equ     gpio_portb_handler,  _default_handler
        .equ     gpio_portc_handler,  _default_handler
        .equ     gpio_portd_handler,  _default_handler
        .equ     gpio_porte_handler,  _default_handler
        .equ     uart0_handler,  _default_handler
        .equ     uart1_handler,  _default_handler
        .equ     ssi0_handler,  _default_handler
        .equ     i2c0_handler,  _default_handler
        .equ     pwm0_fault_handler,  _default_handler
        .equ     pwm0_generator0_handler,  _default_handler
        .equ     pwm0_generator1_handler,  _default_handler
        .equ     pwm0_generator2_handler,  _default_handler
        .equ     quadrature0_handler,  _default_handler
        .equ     adc0_seq0_handler,  _default_handler
        .equ     adc0_seq1_handler,  _default_handler
        .equ     adc0_seq2_handler,  _default_handler
        .equ     adc0_seq3_handler,  _default_handler
        .equ     wdt_handler,  _default_handler
        .equ     timer0a_handler,  _default_handler
        .equ     timer0b_handler,  _default_handler
        .equ     timer1a_handler,  _default_handler
        .equ     timer1b_handler,  _default_handler
        .equ     timer2a_handler,  _default_handler
        .equ     timer2b_handler,  _default_handler
        .equ     comp0_handler,  _default_handler
        .equ     comp1_handler,  _default_handler
        .equ     comp2_handler,  _default_handler
        .equ     sys_ctl_handler,  _default_handler
        .equ     flash_ctl_handler,  _default_handler
        .equ     gpio_portf_handler,  _default_handler
        .equ     gpio_portg_handler,  _default_handler
        .equ     gpio_porth_handler,  _default_handler
        .equ     uart2_handler,  _default_handler
        .equ     ssi1_handler,  _default_handler
        .equ     timer3a_handler,  _default_handler
        .equ     timer3b_handler,  _default_handler
        .equ     i2c1_handler,  _default_handler
        .equ     quadrature1_handler,  _default_handler
        .equ     can0_handler,  _default_handler
        .equ     can1_handler,  _default_handler
        .equ     can2_handler,  _default_handler
        .equ     ethernet_handler,  _default_handler
        .equ     hibernate_handler,  _default_handler
        .equ     usb0_handler,  _default_handler
        .equ     pwm0_generator3_handler,  _default_handler
        .equ     udma_handler,  _default_handler
        .equ     udma_error,  _default_handler
        .equ     adc1_seq0_handler,  _default_handler
        .equ     adc1_seq1_handler,  _default_handler
        .equ     adc1_seq2_handler,  _default_handler
        .equ     adc1_seq3_handler,  _default_handler
        .equ     i2s0_handler,  _default_handler
        .equ     ext_bus_handler,  _default_handler
        .equ     gpio_portj_handler,  _default_handler
        .equ     gpio_portk_handler,  _default_handler
        .equ     gpio_portl_handler,  _default_handler
        .equ     ssi2_handler,  _default_handler
        .equ     ssi3_handler,  _default_handler
        .equ     uart3_handler,  _default_handler
        .equ     uart4_handler,  _default_handler
        .equ     uart5_handler,  _default_handler
        .equ     uart6_handler,  _default_handler
        .equ     uart7_handler,  _default_handler
        .equ     i2c2_handler,  _default_handler
        .equ     i2c3_handler,  _default_handler
        .equ     timer4a_handler,  _default_handler
        .equ     timer4b_handler,  _default_handler
        .equ     timer5a_handler,  _default_handler
        .equ     timer5b_handler,  _default_handler
        .equ     wide_timer0a_handler,  _default_handler
        .equ     wide_timer0b_handler,  _default_handler
        .equ     wide_timer1a_handler,  _default_handler
        .equ     wide_timer1b_handler,  _default_handler
        .equ     wide_timer2a_handler,  _default_handler
        .equ     wide_timer2b_handler,  _default_handler
        .equ     wide_timer3a_handler,  _default_handler
        .equ     wide_timer3b_handler,  _default_handler
        .equ     wide_timer4a_handler,  _default_handler
        .equ     wide_timer4b_handler,  _default_handler
        .equ     wide_timer5a_handler,  _default_handler
        .equ     wide_timer5b_handler,  _default_handler
        .equ     fpu_handler,  _default_handler
        .equ     peci0_handler,  _default_handler
        .equ     lpc0_handler,  _default_handler
        .equ     i2c4_handler,  _default_handler
        .equ     i2c5_handler,  _default_handler
        .equ     gpio_portm_handler,  _default_handler
        .equ     gpio_portn_handler,  _default_handler
        .equ     quadrature2_handler,  _default_handler
        .equ     fan0_handler,  _default_handler
        .equ     gpio_portp_handler,  _default_handler
        .equ     gpio_portp1_handler,  _default_handler
        .equ     gpio_portp2_handler,  _default_handler
        .equ     gpio_portp3_handler,  _default_handler
        .equ     gpio_portp4_handler,  _default_handler
        .equ     gpio_portp5_handler,  _default_handler
        .equ     gpio_portp6_handler,  _default_handler
        .equ     gpio_portp7_handler,  _default_handler
        .equ     gpio_portq_handler,  _default_handler
        .equ     gpio_portq1_handler,  _default_handler
        .equ     gpio_portq2_handler,  _default_handler
        .equ     gpio_portq3_handler,  _default_handler
        .equ     gpio_portq4_handler,  _default_handler
        .equ     gpio_portq5_handler,  _default_handler
        .equ     gpio_portq6_handler,  _default_handler
        .equ     gpio_portq7_handler,  _default_handler
        .equ     gpio_portr_handler,  _default_handler
        .equ     gpio_ports_handler,  _default_handler
        .equ     pwm1_generator0_handler,  _default_handler
        .equ     pwm1_generator1_handler,  _default_handler
        .equ     pwm1_generator2_handler,  _default_handler
        .equ     pwm1_generator3_handler,  _default_handler
        .equ     pwm1_fault_handler,  _default_handler
     
        .weak     nmi_handler
        .weak     hard_fault_handler
        .weak     mem_manage_handler
        .weak     bus_fault_handler
        .weak     usage_fault_handler
        .weak     sv_call_handler
        .weak     debug_monitor_handler
        .weak     pend_sv_handler
        .weak     sys_tick_handler
        .weak     gpio_porta_handler
        .weak     gpio_portb_handler
        .weak     gpio_portc_handler
        .weak     gpio_portd_handler
        .weak     gpio_porte_handler
        .weak     uart0_handler
        .weak     uart1_handler
        .weak     ssi0_handler
        .weak     i2c0_handler
        .weak     pwm0_fault_handler
        .weak     pwm0_generator0_handler
        .weak     pwm0_generator1_handler
        .weak     pwm0_generator2_handler
        .weak     quadrature0_handler
        .weak     adc0_seq0_handler
        .weak     adc0_seq1_handler
        .weak     adc0_seq2_handler
        .weak     adc0_seq3_handler
        .weak     wdt_handler
        .weak     timer0a_handler
        .weak     timer0b_handler
        .weak     timer1a_handler
        .weak     timer1b_handler
        .weak     timer2a_handler
        .weak     timer2b_handler
        .weak     comp0_handler
        .weak     comp1_handler
        .weak     comp2_handler
        .weak     sys_ctl_handler
        .weak     flash_ctl_handler
        .weak     gpio_portf_handler
        .weak     gpio_portg_handler
        .weak     gpio_porth_handler
        .weak     uart2_handler
        .weak     ssi1_handler
        .weak     timer3a_handler
        .weak     timer3b_handler
        .weak     i2c1_handler
        .weak     quadrature1_handler
        .weak     can0_handler
        .weak     can1_handler
        .weak     can2_handler
        .weak     ethernet_handler
        .weak     hibernate_handler
        .weak     usb0_handler
        .weak     pwm0_generator3_handler
        .weak     udma_handler
        .weak     udma_error
        .weak     adc1_seq0_handler
        .weak     adc1_seq1_handler
        .weak     adc1_seq2_handler
        .weak     adc1_seq3_handler
        .weak     i2s0_handler
        .weak     ext_bus_handler
        .weak     gpio_portj_handler
        .weak     gpio_portk_handler
        .weak     gpio_portl_handler
        .weak     ssi2_handler
        .weak     ssi3_handler
        .weak     uart3_handler
        .weak     uart4_handler
        .weak     uart5_handler
        .weak     uart6_handler
        .weak     uart7_handler
        .weak     i2c2_handler
        .weak     i2c3_handler
        .weak     timer4a_handler
        .weak     timer4b_handler
        .weak     timer5a_handler
        .weak     timer5b_handler
        .weak     wide_timer0a_handler
        .weak     wide_timer0b_handler
        .weak     wide_timer1a_handler
        .weak     wide_timer1b_handler
        .weak     wide_timer2a_handler
        .weak     wide_timer2b_handler
        .weak     wide_timer3a_handler
        .weak     wide_timer3b_handler
        .weak     wide_timer4a_handler
        .weak     wide_timer4b_handler
        .weak     wide_timer5a_handler
        .weak     wide_timer5b_handler
        .weak     fpu_handler
        .weak     peci0_handler
        .weak     lpc0_handler
        .weak     i2c4_handler
        .weak     i2c5_handler
        .weak     gpio_portm_handler
        .weak     gpio_portn_handler
        .weak     quadrature2_handler
        .weak     fan0_handler
        .weak     gpio_portp_handler
        .weak     gpio_portp1_handler
        .weak     gpio_portp2_handler
        .weak     gpio_portp3_handler
        .weak     gpio_portp4_handler
        .weak     gpio_portp5_handler
        .weak     gpio_portp6_handler
        .weak     gpio_portp7_handler
        .weak     gpio_portq_handler
        .weak     gpio_portq1_handler
        .weak     gpio_portq2_handler
        .weak     gpio_portq3_handler
        .weak     gpio_portq4_handler
        .weak     gpio_portq5_handler
        .weak     gpio_portq6_handler
        .weak     gpio_portq7_handler
        .weak     gpio_portr_handler
        .weak     gpio_ports_handler
        .weak     pwm1_generator0_handler
        .weak     pwm1_generator1_handler
        .weak     pwm1_generator2_handler
        .weak     pwm1_generator3_handler
        .weak     pwm1_fault_handler

        .section .text
        .align 2
        .syntax unified
        .thumb
        .global _start
        .global main
        .equ _start, reset_handler
        .weak reset_handler
        .thumb_func
reset_handler:
        // Initialize .data section memory
        LDR     R0, =_data              // data section start
        LDR     R1, =__init_array_start // source of initialized data
        LDR     R2, =_edata             // data section end
_data_loop:
        LDR     R3, [R1], #0x4
        STR     R3, [R0], #0x4
        CMP     R0, R2
        BLO     _data_loop

        // Zero out .bss section memory
        LDR     R0, =_bss               // bss section start
        MOV     R1, #0
        LDR     R2, =_ebss              // bss section end
_bss_loop:
        STR     R1, [R0], #0x4
        CMP     R0, R2
        BLO     _bss_loop

        // Enable FP
        MOVT    R0, #0xE000
        MOVW    R0, #0xED88
        LDR     R1, [R0]
        ORR     R1, #0x00F00000
        STR     R1, [R0]

        // Go to user code
        BL      main

        .thumb_func
        .weak _default_handler
_default_handler:
        B       .
        