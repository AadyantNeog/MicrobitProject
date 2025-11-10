    .syntax unified
    .cpu cortex-m0
    .thumb

    .equ BUTTON_A_PIN, 17              @ Pin for button A
    .equ BUTTON_B_PIN, 26              @ Pin for button B
    
    .equ GPIO_IN, 0x504               @ GPIO input register
    
    @ Display matrix addresses
    .equ DISPLAY_BASE, 0x40000000     @ Placeholder - actual address depends on micro:bit hardware
    .equ DISPLAY_CLEAR, 0x40000100    @ Placeholder for display clear function
    .equ DISPLAY_SET_PIXEL, 0x40000200 @ Placeholder for set pixel function
    
    .equ SLEEP_MS_FUNC, 0x40001000    @ Placeholder for sleep function

    .section .data
x:  .byte 0                           @ x coordinate
y:  .byte 2                           @ y coordinate (middle row)

    .section .text
    .global _start
    
_start:
    @ Initialize variables
    movs r0, #0
    strb r0, [x]                      @ x = 0
    
    movs r0, #2
    strb r0, [y]                      @ y = 2
    
    @ Clear display
    bl clear_display
    
    @ Draw initial pixel
    ldrb r0, [x]                      @ Load x value
    ldrb r1, [y]                      @ Load y value
    movs r2, #9                       @ Brightness value
    bl set_pixel

main_loop:
    @ Check if button A was pressed
    bl read_button_a
    cmp r0, #1
    bne check_button_b
    
    @ Move left
    ldrb r0, [x]
    subs r0, #1                       @ x = x - 1
    cmp r0, #0
    bge store_x_a                     @ If x >= 0, skip next instruction
    movs r0, #0                       @ x = 0 (clamp)
    
store_x_a:
    strb r0, [x]                      @ Store new x value
    bl clear_display
    ldrb r0, [x]
    ldrb r1, [y]
    movs r2, #9
    bl set_pixel
    
check_button_b:
    @ Check if button B was pressed
    bl read_button_b
    cmp r0, #1
    bne sleep_loop
    
    @ Move right
    ldrb r0, [x]
    adds r0, #1                       @ x = x + 1
    cmp r0, #4
    ble store_x_b                     @ If x <= 4, skip next instruction
    movs r0, #4                       @ x = 4 (clamp)
    
store_x_b:
    strb r0, [x]                      @ Store new x value
    bl clear_display
    ldrb r0, [x]
    ldrb r1, [y]
    movs r2, #9
    bl set_pixel
    
sleep_loop:
    movs r0, #20                      @ 20ms
    bl sleep_ms
    
    b main_loop                       @ Loop forever

@ Function to read button A state
read_button_a:
    ldr r0, =GPIO_IN
    ldr r1, [r0]
    movs r0, #BUTTON_A_PIN
    lsrs r1, r0                       @ Shift to get the pin bit
    ands r1, #1                       @ Mask to get just that bit
    eors r0, r1, #1                   @ Invert (buttons are active low)
    bx lr

@ Function to read button B state
read_button_b:
    ldr r0, =GPIO_IN
    ldr r1, [r0]
    movs r0, #BUTTON_B_PIN
    lsrs r1, r0                       @ Shift to get the pin bit
    ands r1, #1                       @ Mask to get just that bit
    eors r0, r1, #1                   @ Invert (buttons are active low)
    bx lr

@ Function to clear the display
clear_display:
    ldr r0, =DISPLAY_CLEAR
    blx r0                           @ Call the clear display function
    bx lr

@ Function to set a pixel
set_pixel:
    @ r0 = x, r1 = y, r2 = brightness
    ldr r3, =DISPLAY_SET_PIXEL
    blx r3                           @ Call the set pixel function
    bx lr

@ Function to sleep for ms
sleep_ms:
    @ r0 = milliseconds
    ldr r1, =SLEEP_MS_FUNC
    blx r1                           @ Call the sleep function
    bx lr
