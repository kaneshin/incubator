# hello-world

## Overview

A simple, zero-dependency command-line tool that displays "Hello World" with beautiful terminal formatting. Built using pure bash for universal compatibility across Unix-like systems (macOS, Linux). The tool intelligently detects whether output is to a terminal (TTY) or being piped, and adjusts its output accordingly.

## Architecture

**Single Script Design:**
- Main executable: `hello-world` (bash script)
- Test suite: `test/hello-world.bats` (bats-core)
- TTY detection for adaptive output formatting
- No external runtime dependencies

**Key Components:**
1. **TTY Detection Logic** - Uses `[ -t 1 ]` to check if stdout is a terminal
2. **Formatted Output** - ANSI escape codes for colors, Unicode for box drawing
3. **Plain Output Fallback** - Simple text output for pipes and redirects
4. **Test Suite** - Comprehensive bats tests covering all scenarios

## Implementation Plan

### Phase 1: Foundation ✅
- [x] Project setup
- [x] Create test directory structure
- [x] Install bats-core testing framework

### Phase 2: Core Implementation (TDD Cycles) ✅
- [x] **TDD Cycle 1**: Write failing test for basic "Hello World" output
- [x] **TDD Cycle 1**: Implement minimal script to pass basic test (RED → GREEN)
- [x] **TDD Cycle 2**: Write failing test for formatted output (colors + box)
- [x] **TDD Cycle 2**: Implement ANSI colors and Unicode box drawing (RED → GREEN)
- [x] **TDD Cycle 3**: Write test for non-TTY behavior (piped output)
- [x] **TDD Cycle 3**: Verify TTY detection works correctly
- [x] **Refactor Phase**: Review code for duplication (none found - already optimal)

### Phase 3: Documentation & Verification ✅
- [x] Create comprehensive README.md with usage and installation instructions
- [x] Verify all tests pass (5/5 tests passing)
- [x] Document UI design patterns in docs/ui/
- [x] Final verification - end-to-end testing

## Technical Stack

- **Language**: Bash (#!/usr/bin/env bash)
- **Testing Framework**: bats-core v1.13.0
- **Formatting**:
  - ANSI escape codes for terminal colors
  - Unicode box-drawing characters (┌ ─ ┐ │ └ ┘)
- **Target Platforms**: macOS, Linux, any Unix-like system with bash

## Dependencies

**Runtime Dependencies:**
- bash (pre-installed on all Unix-like systems)

**Development Dependencies:**
- bats-core (for running tests)
  - Install via: `brew install bats-core` (macOS)
  - Or via npm: `npm install -g bats`

**Zero runtime dependencies** - the script runs anywhere bash is available.

## Implementation Details

### Files Created
1. **`hello-world`** (477 bytes, 16 lines)
   - Main executable with shebang
   - TTY detection logic
   - Conditional formatting

2. **`test/hello-world.bats`** (1334 bytes)
   - 5 comprehensive test cases
   - TTY and non-TTY scenario coverage

3. **`README.md`** (2596 bytes)
   - Usage instructions
   - Installation guide
   - Development setup

4. **`docs/ui/`** (this update)
   - UI design specifications
   - Terminal output patterns
   - Color and formatting standards

### Output Modes

**Terminal Mode (TTY detected):**
```
┌─────────────────┐
│  Hello World!   │
└─────────────────┘
```
- Bright cyan color (ANSI code: `\033[1;36m`)
- Unicode box-drawing characters
- Visually appealing presentation

**Pipe/Redirect Mode (non-TTY):**
```
Hello World
```
- Plain text output
- No colors or special characters
- Compatible with scripts and pipelines

## Design Principles Applied

### KISS (Keep It Simple, Stupid)
- Single script, 16 lines of code
- No unnecessary complexity
- Clear, readable implementation

### YAGNI (You Aren't Gonna Need It)
- Only implemented requested features
- No command-line flags or options
- No configuration files
- Focused on core requirement: display "Hello World"

### TDD (Test-Driven Development)
- All tests written BEFORE implementation
- Strict RED → GREEN → REFACTOR cycle
- 100% test coverage of functionality
- 5 tests covering:
  1. Script execution success
  2. Output content verification
  3. Box drawing in TTY mode
  4. ANSI colors in TTY mode
  5. Plain text in non-TTY mode

## Notes

### Why Bash Instead of Zig
Originally planned to use Zig, but switched to bash because:
- Zig requires installation - barrier to entry for users
- Bash is universally available on Unix systems
- Zero deployment friction
- Simpler for a "Hello World" tool

### Production-Ready Features
- Proper error handling
- Exit code management (0 for success)
- Works in both interactive and scripted environments
- Comprehensive test coverage
- Well-documented

### Future Considerations (Not Implementing - YAGNI)
- Command-line flags (--plain, --color, --no-box)
- Custom messages beyond "Hello World"
- Multiple output styles or themes
- Configuration file support
- Localization/internationalization

These features are intentionally NOT implemented following YAGNI principles. They can be added later if actual user demand emerges.
