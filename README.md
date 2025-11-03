# 🧠 State Machine System (Godot 4)

Learning and experimenting with finite state machines for character AI using **signals** and **Area3D-based detection**.

## 🎯 Current Focus
- Understanding `State` inheritance and transitions  
- Using transition signals for switching between states dynamically  
- Leveraging `Area3D` for player detection and range-based behavior changes  
- Smooth movement and rotation using `lerp`, `lerp_angle`, and `atan2`  
- Organizing reusable logic across multiple AI states

## 📁 States Implemented
- `ske_idle.gd` → Idle + random wandering behavior  
- `ske_chase.gd` → Smoothly chase the player when in detection range  

## 🧩 Next Steps
- `ske_attack.gd` → Attack player after chasing  
- `ske_death.gd` → Handle enemy death animations and cleanup
- Enemy spawning system for level population  
- Health and damage system for AI  
- Fine-tune **Area3D** collision shapes for multiple detection ranges  
- Improve transition system using **signal-based control flow**
