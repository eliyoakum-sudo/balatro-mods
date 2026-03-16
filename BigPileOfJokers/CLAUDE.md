# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a Balatro mod project. Balatro is a card game, and this appears to be a modding framework for it. The mod structure follows Balatro's modding conventions.

## Project Structure
```
BalatoModding/
├── main.lua          # Main mod entry point (currently empty)
└── assets/           # Sprite assets for the mod
    ├── 1x/          # Standard resolution sprites
    │   └── TestSprite.png
    └── 2x/          # High resolution sprites (2x scale)
        └── TestSprite.png
```

## Key Files
- `main.lua`: The main entry point for the mod. This is where all mod logic should be implemented.
- `assets/`: Directory containing sprite assets at different resolutions (1x and 2x)

## Development Notes
- This mod is installed in the Balatro game directory at `/Users/philharrison/Applications/Balatro.app/Contents/Mods/`
- Balatro mods typically use Lua for scripting
- Assets should be provided in both 1x and 2x resolutions for different display scales
- The mod appears to be in initial development stage with an empty main.lua file

## Common Tasks
Since this is a Balatro mod, typical development involves:
- Adding new cards, jokers, or game mechanics via Lua scripting in main.lua
- Creating sprite assets for new game elements
- Testing the mod by running Balatro with the mod installed