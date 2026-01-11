# hello-world

A simple command-line tool that displays "Hello World" with beautiful formatting.

## Features

- **Zero Dependencies**: Pure bash - runs anywhere bash is installed
- **Smart Output**: Colored box in terminals, plain text when piped
- **Lightweight**: Single script, ~16 lines of code
- **Well-Tested**: Comprehensive test suite using bats-core

## Usage

Run the command directly:

```bash
./hello-world
```

When run in a terminal, you'll see:
```
┌─────────────────┐
│  Hello World!   │
└─────────────────┘
```

When piped or redirected, output is plain text:
```bash
./hello-world | cat
# Output: Hello World
```

## Installation

### Option 1: Run from current directory

```bash
chmod +x hello-world
./hello-world
```

### Option 2: Install to system PATH

```bash
# Link to /usr/local/bin (requires sudo)
sudo ln -s "$(pwd)/hello-world" /usr/local/bin/hello-world

# Or link to ~/bin (user-local, no sudo required)
mkdir -p ~/bin
ln -s "$(pwd)/hello-world" ~/bin/hello-world

# Make sure ~/bin is in your PATH (add to ~/.bashrc or ~/.zshrc if needed)
export PATH="$HOME/bin:$PATH"
```

After installation, run from anywhere:
```bash
hello-world
```

## Development

### Running Tests

Tests use [bats-core](https://github.com/bats-core/bats-core) - install it first:

```bash
# macOS
brew install bats-core

# Or via npm
npm install -g bats
```

Run the test suite:

```bash
bats test/hello-world.bats
```

Expected output:
```
✓ script executes successfully
✓ output contains Hello World
✓ output contains box drawing when TTY detected
✓ output contains ANSI colors when TTY detected
✓ output is plain text when piped (non-TTY)
```

### Project Structure

```
hello-world/
├── hello-world           # Main executable script
├── test/
│   └── hello-world.bats  # Test suite
├── README.md             # This file
└── PLAN.md               # Implementation plan
```

## Technical Details

- **TTY Detection**: Uses `[ -t 1 ]` to check if stdout is a terminal
- **Colors**: ANSI escape codes (bright cyan: `\033[1;36m`)
- **Box Drawing**: Unicode characters (┌ ─ ┐ │ └ ┘)
- **Compatibility**: Works on macOS, Linux, and any Unix-like system with bash

## Design Principles

This project follows:
- **KISS** (Keep It Simple, Stupid): Minimal, focused implementation
- **YAGNI** (You Aren't Gonna Need It): No unnecessary features
- **TDD** (Test-Driven Development): Tests written before implementation

## License

[Specify your license here]
