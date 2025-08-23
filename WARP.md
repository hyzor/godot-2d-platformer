# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a 2D platformer game built with **Godot 4.4** using GDScript. The project demonstrates basic platformer mechanics including player movement, jumping, gravity, and respawn functionality.

## Essential Commands

### Running the Game
- **Open in Godot Editor**: `godot --editor .` (if Godot is in PATH) or open project.godot in Godot Editor
- **Run Project**: `godot --headless .` or use F5 in Godot Editor
- **Export Project**: Use Project → Export from Godot Editor

### Development Workflow
- **Edit Scenes**: Open .tscn files in Godot Editor (binary format, not directly editable)
- **Edit Scripts**: GDScript files (.gd) can be edited in any text editor or Godot's built-in editor
- **Debug**: Use Godot Editor's debugger or add `print()` statements in GDScript

## Code Architecture

### Project Structure
```
├── scenes/           # Scene files (.tscn) - binary format
│   └── Main.tscn    # Main game scene with background, platform, and player
├── scripts/         # GDScript source files
│   ├── main.gd      # Main scene controller
│   └── player.gd    # Player character controller
├── project.godot    # Godot project configuration
└── icon.svg        # Project icon
```

### Scene Hierarchy
The main scene (`Main.tscn`) contains:
- **Background**: ColorRect for sky-blue background
- **Platform**: StaticBody2D with collision for ground platform
- **Player**: CharacterBody2D with movement and physics

### Key Systems

#### Player Movement (`player.gd`)
- **CharacterBody2D-based**: Uses Godot 4's new CharacterBody2D for physics
- **Constants**: SPEED (300.0), JUMP_VELOCITY (-400.0)
- **Physics**: Gravity from ProjectSettings, ground detection with `is_on_floor()`
- **Input**: Arrow keys/WASD for movement, space/enter for jumping
- **Respawn System**: Resets to spawn_position if player falls below y=700

#### Input Mapping
- Uses Godot's default input map:
  - `ui_left`/`ui_right`: Horizontal movement
  - `ui_accept`: Jump (typically space or enter)

### Scene Management
- **Main Scene**: Set in project.godot as `res://scenes/Main.tscn`
- **Script Attachment**: Scenes link to scripts via UID references
- **Resource Paths**: Use `res://` prefix for all internal resources

## Development Notes

### GDScript Specifics
- **Node Extension**: Scripts extend specific node types (Node2D, CharacterBody2D)
- **Lifecycle Methods**: `_ready()` for initialization, `_physics_process(delta)` for physics
- **Movement**: Use `move_and_slide()` for CharacterBody2D physics
- **Input**: `Input.get_axis()` for smooth directional input, `Input.is_action_just_pressed()` for discrete actions

### Physics Configuration
- Uses project's default gravity setting: `ProjectSettings.get_setting("physics/2d/default_gravity")`
- Player spawn position: Vector2(576, 400)
- Respawn trigger: y > 700

### File Organization
- Scene files (.tscn) are binary and require Godot Editor to modify
- Scripts (.gd) are plain text and can be edited externally
- UID system links resources and prevents broken references

## Platform-Specific Notes
- **Windows**: Godot may be installed via Steam, official installer, or package managers
- **Project Location**: Avoid spaces in path names for best compatibility
- **File Extensions**: .tscn (scenes), .gd (scripts), .godot (project config)
