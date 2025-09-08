# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a 2D platformer game built with **Godot 4.4** using GDScript. The project demonstrates platformer mechanics including player movement, jumping, gravity, respawn functionality, moving platforms, coin collection, and camera following systems.

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
│   └── Main.tscn    # Main game scene with background, platforms, player, and collectibles
├── scripts/         # GDScript source files
│   ├── main.gd      # Main scene controller with camera and signal management
│   ├── player.gd    # Player character controller with group membership
│   ├── platform.gd  # Moving platform controller with export variables
│   └── coin.gd      # Collectible coin with signal emission
├── project.godot    # Godot project configuration
└── icon.svg        # Project icon
```

### Scene Hierarchy
The main scene (`Main.tscn`) contains:
- **Camera2D**: Follows player with smoothing enabled
- **Background**: ColorRect for sky-blue background (expanded area)
- **SpawnPoint**: Visual marker for player respawn location
- **Player**: CharacterBody2D with movement and physics (member of "player" group)
- **Platforms**: Container node organizing all platform types
  - **Platform**: Static ground platform (StaticBody2D)
  - **Platform_2**: Additional static platform
  - **MovingPlatform**: Horizontal moving platform (AnimatableBody2D)
    - **Coin**: Collectible Area2D attached to moving platform

### Key Systems

#### Player Movement (`player.gd`)
- **CharacterBody2D-based**: Uses Godot 4's new CharacterBody2D for physics
- **Constants**: SPEED (300.0), JUMP_VELOCITY (-400.0)
- **Physics**: Gravity from ProjectSettings, ground detection with `is_on_floor()`
- **Input**: Arrow keys/WASD for movement, space/enter for jumping
- **Group Membership**: Automatically joins "player" group for identification
- **Respawn System**: Resets to spawn_position if player falls below y=700

#### Moving Platforms (`platform.gd`)
- **AnimatableBody2D-based**: Uses AnimatableBody2D for kinematic platform movement
- **Export Variables**: speed, distance, and horizontal direction configurable in editor
- **Oscillating Movement**: Moves back and forth between start position and target distance
- **Direction System**: Uses direction multiplier (-1/1) for smooth reversing

#### Coin Collection (`coin.gd`)
- **Area2D-based**: Uses Area2D for trigger-based collection detection
- **Signal System**: Emits "collected" signal when player enters area
- **Group Detection**: Checks if entering body is in "player" group
- **Auto-cleanup**: Uses queue_free() to remove coin after collection

#### Camera System (`main.gd`)
- **@onready References**: Uses @onready to get camera and player node references
- **Following Camera**: Camera position updates every frame to match player position
- **Position Smoothing**: Camera2D has position_smoothing_enabled for smooth following
- **Signal Connections**: Connects to coin collection signals for game state management

#### Input Mapping
- Uses Godot's default input map:
  - `ui_left`/`ui_right`: Horizontal movement
  - `ui_accept`: Jump (typically space or enter)

### Scene Management
- **Main Scene**: Set in project.godot as `res://scenes/Main.tscn`
- **Script Attachment**: Scenes link to scripts via UID references
- **Resource Paths**: Use `res://` prefix for all internal resources
- **Node Organization**: Uses container nodes (e.g., "Platforms") for logical grouping
- **Parent-Child Relationships**: Coin attached to MovingPlatform inherits movement

## Development Notes

### GDScript Specifics
- **Node Extension**: Scripts extend specific node types (Node2D, CharacterBody2D, AnimatableBody2D, Area2D)
- **Lifecycle Methods**: `_ready()` for initialization, `_physics_process(delta)` for physics, `_process(delta)` for frame updates
- **@onready Decorator**: `@onready var node = $NodePath` for node references after scene tree is ready
- **@export Decorator**: `@export var variable` makes variables configurable in Godot Editor
- **Signal System**: `signal signal_name` declares signals, `emit_signal()` sends them, `connect()` listens
- **Group System**: `add_to_group()` and `is_in_group()` for entity categorization and detection
- **Movement**: Use `move_and_slide()` for CharacterBody2D, direct position modification for AnimatableBody2D
- **Input**: `Input.get_axis()` for smooth directional input, `Input.is_action_just_pressed()` for discrete actions

### Physics Configuration
- Uses project's default gravity setting: `ProjectSettings.get_setting("physics/2d/default_gravity")`
- Player spawn position: Vector2(1214.57, 312.459) (dynamically set from initial position)
- Respawn trigger: y > 700
- Moving platform parameters: speed (200.0), distance (300.0), horizontal movement
- Camera smoothing: position_smoothing_enabled on Camera2D node
- Collision layers: Player uses CharacterBody2D, platforms use StaticBody2D/AnimatableBody2D, coins use Area2D

### File Organization
- Scene files (.tscn) are binary and require Godot Editor to modify
- Scripts (.gd) are plain text and can be edited externally
- UID system links resources and prevents broken references

## Platform-Specific Notes
- **Windows**: Godot may be installed via Steam, official installer, or package managers
- **Project Location**: Avoid spaces in path names for best compatibility
- **File Extensions**: .tscn (scenes), .gd (scripts), .godot (project config)
