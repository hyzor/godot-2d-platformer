# CRUSH.md

## Project Overview
This project is a 2D platformer game developed with Godot 4.4 and GDScript. It showcases core platformer functionalities such as player movement, jumping, gravity, respawning, moving platforms, coin collection, and a camera-following system.

## Build/Lint/Test Commands

### Running the Game
- **Open in Godot Editor**: `godot --editor .` (assuming Godot is in your PATH)
- **Run Project**: `godot --headless .` or press F5 in the Godot Editor.
- **Run a Specific Scene**: Use `godot --headless <path_to_scene.tscn>`

### Development Workflow
- **Linting**: GDScript does not have a formal linting tool like other languages. Best practice is to rely on Godot's built-in script editor warnings and errors.
- **Testing**: Godot does not have a built-in unit testing framework. For testing, you typically:
    - Run the game and manually verify functionality.
    - Add `print()` statements for debugging.
    - Develop scenes specifically for testing individual mechanics.

## Code Style Guidelines (GDScript)

### Imports
- Use `@onready` for node references initialized after the scene tree is ready.
- Use `preload()` or `load()` for external resources. `preload()` is generally preferred for constant resources.

### Formatting
- **Indentation**: Use tabs for indentation as per Godot's default.
- **Line Endings**: Use LF (Unix style).
- **Whitespace**:
    - Add a single space after keywords like `if`, `for`, `while`.
    - No spaces around `.` for member access.
    - Single space around operators (`=`, `+`, `-`, `*`, `/`, `==`, `!=`, etc.).

### Types
- GDScript is dynamically typed, but type hints are encouraged for clarity and error detection:
    - `var my_variable: int = 0`
    - `func my_function(param: String) -> void:`

### Naming Conventions
- **Classes (Nodes)**: PascalCase (e.g., `Player`, `MovingPlatform`).
- **Variables**: snake_case (e.g., `player_speed`, `jump_velocity`).
- **Functions**: snake_case (e.g., `_ready`, `_on_body_entered`).
- **Signals**: snake_case (e.g., `collected`).
- **Constants**: ALL_CAPS_SNAKE_CASE (e.g., `SPEED`, `JUMP_VELOCITY`).

### Error Handling
- Use `assert()` for debugging and validating assumptions during development.
- For runtime errors, GDScript typically relies on checking return values or using `if is_instance_valid(node):` before accessing nodes that might be null.
- Utilize Godot's built-in debugger for identifying and resolving issues.

## Project Structure
- `scenes/`: Contains Godot scene files (`.tscn`). These are binary and should be edited within the Godot Editor.
- `scripts/`: Contains GDScript files (`.gd`).
- `project.godot`: The main project configuration file.

## Specific Instructions for Agents
- When modifying scene files, use the Godot Editor. Do not attempt to modify `.tscn` files directly as they are binary.
- When adding new functionality, try to follow existing patterns in `player.gd`, `platform.gd`, and `coin.gd`.
- Prioritize clear, readable GDScript code.
- If a task involves visual changes or scene structure, assume it requires interaction with the Godot Editor and inform the user if direct modification is not possible via CLI tools.