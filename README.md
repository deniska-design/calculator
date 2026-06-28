Pure x86 Assembly Console Calculator

A bare-metal, low-level 32-bit x86 Assembly calculator designed for Linux environments. The project executes mathematical operations directly through Linux kernel system calls without linking against any standard C libraries.

---

Features:

100% Pure Assembly: Written entirely from scratch in x86 Assembly language. No external wrappers, no high-level standard libraries—just pure CPU instructions and direct kernel interrupts.
Custom Custom I/O & Math Parsing Engine: Since the project operates without `printf` or `scanf`, it features bespoke, hand-crafted routines written to process raw bytes:
`conv_in_digit_num`: Custom string-to-integer (`atoi`) conversion parser that reads ASCII input from the terminal and translates it into numerical data.
`conv_in_line`: Custom integer-to-string (`itoa`) formatting routine that converts numerical computation results back into displayable ASCII strings.
Direct Kernel Communication: Interacts directly with the Linux kernel using software interrupts (`int 0x80`) via customized macros (`SYS_READ`, `SYS_WRITE`, `SYS_EXIT`).

---

Technical Limitations & Capabilities:

Input Data Range: Optimized to parse and process integers up to 2 digits (e.g., `0` to `99`).
Output Processing Accurately calculates and formats output strings up to 3 digits Beyond this threshold, numbers may trigger an architectural overflow or truncation due to the structural boundaries of the custom printing buffers.

---

Installation & Setup:

1. Clone the Repository
```
git clone https://github.com/deniska-design/calculator.git
```
```
cd calculator
```

2. Execution
   
```
./my_program
```

---

Usage

<img width="868" height="502" alt="image" src="https://github.com/user-attachments/assets/90b4990c-57a4-43d0-ac78-128f1cdfebd3" />


---

License
This project is open-source. Anyone is completely free to download, modify, use, and distribute this software for personal or educational purposes.
