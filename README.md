# Finite State Machine System (Godot 4)

This is the **first step** in exploring AI control for characters and enemies in Godot.
The goal is to experiment with **finite state machines (FSMs)** and understand how different frameworks or systems could be used to manage AI behavior in games.

A learning implementation of a **Finite State Machine (FSM)** for character AI in **Godot 4**, built using
**signal-based state transitions** and **Area3D-driven detection**.

This project focuses on clean separation of states, readable code, and understanding how FSMs work in practice.

---

## Current Scope

### Player
- First-person style camera controller  
- Mouse-based camera rotation with clamping  
- Basic movement and jumping using `CharacterBody3D`

### Enemy AI
- Idle state with basic movement logic  
- Chase state triggered by player detection  
- State transitions handled via **signals**
- Detection implemented using **Area3D** enter/exit events

---

## States Implemented
- `State.gd` → Base state template (enter, exit, update, physics_update)  
- `ske_idle.gd` → Enemy idle behavior  
- `ske_chase.gd` → Enemy chase behavior when player is detected  

---

## State System
- States extend a common `State` base class  
- Transitions are emitted using a `transitioned` signal  
- The state machine listens and switches states dynamically  

---

## Planned Next Steps
- `ske_attack.gd` → Attack behavior after chasing  
- `ske_death.gd` → Death handling and cleanup  
- Health and damage system  
- Enemy spawning system  
- Improved detection using multiple `Area3D` ranges  
- Refactoring into a reusable FSM module or plugin  

---

## Notes
This project focuses on clean separation of states, readable code, and understanding how FSMs work in practice.
- Scene files are intentionally excluded to keep the repository **code-focused**
- This is an experimental / learning project, not a finished AI framework
