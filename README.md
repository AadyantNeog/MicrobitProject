# Microbit Projects

This repository contains two projects developed for the **BBC Micro:bit v2** — one in **Python** and another in **ARM Assembly**.  
Both projects demonstrate interactive control using Micro:bit’s onboard features such as the **LED matrix**, **buttons**, and **accelerometer**.

---

## 🕹️ Project 1: Interactive Two-Mode Game (Python)

### Objective
To explore Micro:bit’s functionalities by building an interactive two-mode game that uses button inputs, the accelerometer, and the LED display.

### Game Modes
1. **Two-Player Grid Game (Tic-Tac-Toe Inspired)**
   - Activated via **Button A**  
   - 5x5 grid; players move a cursor using tilt controls  
   - Player 1 → Button A, Player 2 → Button B  
   - Win condition: 3 aligned marks (row, column, or diagonal)

2. **Target Catching Reflex Game**
   - Activated via **Button B**  
   - 30-second timer  
   - Tilt controls to move cursor  
   - Catch randomly appearing targets with **Button A**

### Challenges Solved
- **Motion sensitivity:** Smoothed accelerometer data using scaling factors  
- **Button debouncing:** Added conditional checks and sleep delays  
- **Grid boundaries:** Restricted cursor movement between 0–4 on both axes  

### Files
- `microbit_game.py` – Source code  
- `microbit_game.hex` – Compiled binary  
- `microbit_game_demo.mp4` – Demo video  

---

## 💡 Project 2: LED Cursor Navigation (ARM Assembly)

### Objective
To implement an ARM assembly program allowing users to control an LED pixel using **Button A** and **Button B**.

### Implementation
- **Button A (P0.14):** Move cursor left  
- **Button B (P0.23):** Move cursor right  
- **LED Matrix:** Displays cursor position using GPIO manipulation

### Key Learnings
- GPIO configuration and control  
- Bitwise operations for hardware manipulation  

### Files
- `microbit_light_movement.s` – Assembly source code  
- `microbit_game.hex` – Compiled binary  
- `microbit_light_movement_demo.mp4` – Demo video  

---


