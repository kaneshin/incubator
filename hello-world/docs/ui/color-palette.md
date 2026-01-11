# Color Palette Specification

## Overview

The hello-world CLI uses a minimal, single-color design approach with bright cyan as the primary accent color. This document specifies the exact color codes and their usage.

## Primary Color

### Bright Cyan
```
Name:        Bright Cyan
Hex:         #00FFFF (approximate - terminal-dependent)
RGB:         0, 255, 255
ANSI Code:   \033[1;36m
ANSI SGR:    1;36 (bold + cyan)
Purpose:     Box drawing characters and borders
```

**Properties:**
- **Bold/Bright**: Yes (ANSI code 1)
- **Foreground**: Cyan (ANSI code 36)
- **Background**: None (transparent/default)

**Terminal Rendering:**
The actual color displayed depends on the user's terminal theme. The ANSI code `1;36` requests "bright cyan," but terminals may render this as:
- Pure cyan (#00FFFF)
- Teal-ish cyan (#00D0D0)
- Custom theme color

**Rationale:**
- Cyan is pleasant and not overly aggressive
- High visibility against both dark and light backgrounds
- Distinct from error messages (red) and warnings (yellow)
- Professional appearance

## Color Reset

### Reset to Default
```
ANSI Code:   \033[0m
ANSI SGR:    0
Purpose:     Reset all formatting to terminal default
```

**Usage:**
Applied after each colored element to ensure subsequent terminal output isn't affected.

## Text Color

### Default Foreground
```
Name:        Terminal Default
Definition:  User's configured terminal foreground color
ANSI Code:   (none - inherits terminal default)
Purpose:     "Hello World!" message text
```

**Rationale:**
- Respects user's terminal theme preferences
- Ensures readability (users choose themes they can read)
- Avoids forcing color choices on users

## Background Colors

### No Background Override
```
Background:  Terminal default (not modified)
```

**Rationale:**
- Users choose terminal backgrounds for comfort
- Forcing backgrounds can break readability
- Reduces complexity

## ANSI Escape Code Reference

### Full Sequence Breakdown

**Starting a colored section:**
```bash
\033[1;36m
│││││││└─ m = end of escape sequence
││││││└── 36 = cyan foreground color
│││││└─── ; = parameter separator
││││└──── 1 = bold/bright attribute
│││└───── [ = start of CSI (Control Sequence Introducer)
││└────── 033 = ESC character (octal)
│└─────── \ = escape character in bash
```

**Ending a colored section:**
```bash
\033[0m
│││││└─ m = end of escape sequence
││││└── 0 = reset all attributes
│││└─── [ = start of CSI
││└──── 033 = ESC character
│└───── \ = escape character in bash
```

## Color Application Pattern

### Implementation in hello-world script

```bash
#!/usr/bin/env bash

# Define colors
CYAN='\033[1;36m'
RESET='\033[0m'

# Apply colors to box
echo -e "${CYAN}┌─────────────────┐${RESET}"
echo -e "${CYAN}│${RESET}  Hello World!   ${CYAN}│${RESET}"
echo -e "${CYAN}└─────────────────┘${RESET}"
```

**Pattern:**
1. Start cyan color for border character
2. Reset to default for text content
3. Start cyan again for closing border character
4. Reset at end of line

**Visual Result:**
```
[CYAN]┌─────────────────┐[RESET]
[CYAN]│[RESET]  Hello World!   [CYAN]│[RESET]
[CYAN]└─────────────────┘[RESET]
```

## Alternative Color Options (Not Implemented)

Following YAGNI, these are documented but not implemented:

### Option: Green Theme
```
ANSI Code: \033[1;32m
Use Case:  Success/positive messages
```

### Option: Blue Theme
```
ANSI Code: \033[1;34m
Use Case:  Information messages
```

### Option: Magenta Theme
```
ANSI Code: \033[1;35m
Use Case:  Creative/artistic presentation
```

### Option: Rainbow/Multi-color
```
Multiple ANSI codes for each line
Use Case:  Festive or celebratory versions
```

**Decision:** Stick with cyan-only for simplicity and consistency.

## Testing Color Rendering

### Manual Testing Commands

```bash
# Test cyan color directly
echo -e "\033[1;36mBright Cyan Text\033[0m"

# Test in different terminal emulators
# Run in: Terminal.app, iTerm2, VS Code, etc.
./hello-world

# Test plain output (should have NO color codes)
./hello-world | cat | od -c
```

### Expected Output Patterns

**Colored (TTY):**
```
ESC[1;36m┌─────────────────┐ESC[0m
ESC[1;36m│ESC[0m  Hello World!   ESC[1;36m│ESC[0m
ESC[1;36m└─────────────────┘ESC[0m
```

**Plain (non-TTY):**
```
Hello World
```
(No escape codes present)

## Accessibility Considerations

### Color Contrast
- Cyan on dark backgrounds: High contrast (good)
- Cyan on light backgrounds: Medium-high contrast (acceptable)
- Not relied upon for meaning (structure is evident from box)

### Color Blindness
- **Protanopia** (red-blind): Cyan visible
- **Deuteranopia** (green-blind): Cyan visible
- **Tritanopia** (blue-blind): Cyan may appear greenish but still visible
- **Monochromacy**: Box structure evident without color

### Terminal Theme Compatibility

Tested with popular terminal themes:
- ✅ **Solarized Dark**: Cyan renders well
- ✅ **Solarized Light**: Cyan renders well
- ✅ **Monokai**: Cyan renders well
- ✅ **Dracula**: Cyan renders well
- ✅ **One Dark**: Cyan renders well
- ✅ **GitHub Light**: Cyan renders well

## 256-Color and True Color Support

### Current Implementation
Uses 16-color ANSI (basic ANSI codes)

**Rationale:**
- Universal compatibility with all terminals
- Simple implementation
- Sufficient for the use case

### Future Considerations (YAGNI)

**256-color mode:**
```bash
# Not implemented
CYAN_256='\033[38;5;51m'  # Cyan from 256-color palette
```

**24-bit True Color:**
```bash
# Not implemented
CYAN_RGB='\033[38;2;0;255;255m'  # RGB true color
```

**Decision:** Basic ANSI colors are sufficient. True color adds complexity without meaningful benefit for this tool.

## Color in Non-Interactive Mode

### Principle: No Color When Piped

```bash
# Detection code
if [ -t 1 ]; then
  # Terminal: use colors
else
  # Pipe/redirect: NO colors
fi
```

**Why:**
- Plain text is easier to parse
- Avoids escape codes in logs/files
- Prevents issues with tools that don't support ANSI

**Testing:**
```bash
# These should produce plain text (no colors):
./hello-world | cat
./hello-world > output.txt
./hello-world | grep "Hello"
```

## Summary

**Current Color Usage:**
- **Primary**: Bright Cyan (ANSI 1;36m)
- **Text**: Terminal default
- **Background**: Terminal default
- **Reset**: ANSI 0m after each colored section

**Design Benefits:**
- Simple and clean
- High compatibility
- Respects user preferences
- Accessible to all users
