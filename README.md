# Recursive Fibonacci with Stack Frames (CEG 3310 — Lab 5)

> **Goal:** Implement `FIB(n)` recursively in LC‑3 using **proper stack frames**, handling base and general cases with multiple active call frames.

Derived from Wright State University **CEG 3310** Lab 5.

## 🎯 Requirements
- Implement `FIB(n)` with:
  - Base cases: `FIB(0)=0`, `FIB(1)=1`
  - General case: `FIB(n)=FIB(n−1)+FIB(n−2)`
- Use **stack discipline**: prologue/epilogue, saved registers, return value
- Support a reasonable input range (e.g., `0 ≤ n ≤ 9` per lab guidance)
- Provide a simple **driver** that reads `n`, calls `FIB`, and displays result

## 🧰 Tools
- LC‑3 simulator (PennSim/lc3tools)
- TRAP routines for console I/O

## ▶️ How to Run
1. Assemble `lab05_fib.asm`
2. Load in LC‑3 simulator, set PC to `MAIN`
3. Input `n` when prompted; observe result

**Example**
```
n = 7
FIB(7) = 13
```

## 🧱 Repo Structure
```
src/
  lab05_fib.asm
docs/
  stack-frames-fib.png   # visualizing nested calls
  recursion-notes.md     # call tree and register saves
README.md
LICENSE
```

## 🔧 Implementation Notes
- **Prologue**: push old FP, set FP=SP, save regs, allocate locals (e.g., temp for `n−1`/`n−2`)
- **Recursive calls**: push arguments in order; retrieve child results
- **Epilogue**: place return value in agreed register (e.g., `R0`), restore & return
- Consider tail‑call limitations—this implementation is **not** tail‑recursive

## ✅ Testing
- Known values: `FIB(0)=0, FIB(1)=1, FIB(2)=1, FIB(3)=2, FIB(4)=3, FIB(5)=5, FIB(6)=8, FIB(7)=13, FIB(8)=21`
- Boundary: smallest/largest allowed `n`
- Negative input handling (reject or clamp per lab rules)

## 📚 Academic Integrity
Includes only **original assembly** and diagrams I created from my solution. Lab PDF remains private per course policy.
