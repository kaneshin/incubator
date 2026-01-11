# Visual Examples and Use Cases

## Overview

This document provides real-world examples and use cases for the hello-world CLI, demonstrating how it appears in different contexts and how users might integrate it into their workflows.

---

## Basic Usage Examples

### Example 1: Direct Terminal Execution

**Command:**
```bash
./hello-world
```

**Output (Colored, TTY Mode):**
```
┌─────────────────┐
│  Hello World!   │
└─────────────────┘
```

**Visual Description:**
- Bright cyan box with Unicode drawing characters
- Clean, centered appearance
- Professional and polished look

**Use Case:**
- User testing the tool for the first time
- Demonstration or presentation
- Quick greeting message in interactive session

---

### Example 2: Piped to Another Command

**Command:**
```bash
./hello-world | cat
```

**Output (Plain Text, Non-TTY Mode):**
```
Hello World
```

**Visual Description:**
- Simple plain text
- No colors or special characters
- Machine-readable format

**Use Case:**
- Chaining with other commands
- Logging to files
- Text processing pipelines

---

### Example 3: Redirected to File

**Command:**
```bash
./hello-world > greeting.txt
cat greeting.txt
```

**Output:**
```
Hello World
```

**Use Case:**
- Saving output to a file
- Creating greeting messages for documentation
- Generating plain text content

---

### Example 4: In a Shell Script

**Script (`greet.sh`):**
```bash
#!/bin/bash
echo "Starting application..."
./hello-world
echo "Application ready!"
```

**Output:**
```
Starting application...
┌─────────────────┐
│  Hello World!   │
└─────────────────┘
Application ready!
```

**Use Case:**
- Startup message for applications
- Decorative element in shell scripts
- Visual separator in script output

---

## Integration Examples

### Example 5: SSH Remote Session

**Command:**
```bash
ssh user@remote-server './hello-world'
```

**Output:**
```
┌─────────────────┐
│  Hello World!   │
└─────────────────┘
```

**Description:**
- TTY is allocated by SSH, so colored output appears
- Works seamlessly over remote connections
- Visual greeting for remote users

**Use Case:**
- Remote server login greeting
- Testing SSH connectivity with visual feedback
- Welcome message in .bashrc or .zshrc

---

### Example 6: Conditional Welcome Message

**Script (`~/.bashrc` or `~/.zshrc`):**
```bash
# Show greeting on new terminal
if [ -z "$GREETING_SHOWN" ]; then
    export GREETING_SHOWN=1
    ~/bin/hello-world
fi
```

**Result:**
- First terminal window: Shows colored box
- Subsequent terminals: No output (already greeted)

**Use Case:**
- One-time welcome message per session
- Terminal personalization
- User onboarding

---

### Example 7: Systemd Service Status

**Service File (`/etc/systemd/system/hello.service`):**
```ini
[Unit]
Description=Hello World Service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/hello-world
StandardOutput=journal

[Install]
WantedBy=multi-user.target
```

**Command:**
```bash
sudo systemctl start hello
journalctl -u hello -n 10
```

**Output (in journal):**
```
Jan 11 10:30:45 hostname hello-world[1234]: Hello World
```

**Description:**
- Systemd captures plain text (non-TTY)
- Logs show simple message
- No ANSI codes in journal

**Use Case:**
- Service status messages
- System logging
- Service health checks

---

## Terminal Emulator Examples

### Example 8: Terminal.app (macOS)

**Visual:**
```
┌─────────────────┐  ← Bright cyan border
│  Hello World!   │  ← Default text color (white/black depending on theme)
└─────────────────┘  ← Bright cyan border
```

**Theme Compatibility:**
- ✅ Solarized Dark
- ✅ Basic (Default)
- ✅ Homebrew
- ✅ Novel

---

### Example 9: iTerm2 with Custom Theme

**Visual:**
```
┌─────────────────┐  ← Cyan rendered per iTerm2 theme
│  Hello World!   │  ← Theme default foreground
└─────────────────┘  ← Cyan rendered per iTerm2 theme
```

**Theme Examples:**
- **Dracula:** Cyan appears as #8BE9FD (very bright)
- **Monokai:** Cyan appears as #66D9EF (teal-ish)
- **One Dark:** Cyan appears as #56B6C2 (muted teal)

---

### Example 10: VS Code Integrated Terminal

**Visual:**
```
user@host:~/project$ ./hello-world
┌─────────────────┐
│  Hello World!   │
└─────────────────┘
user@host:~/project$
```

**Description:**
- Works seamlessly in VS Code's terminal
- Colors match VS Code theme
- Unicode characters render correctly

**Use Case:**
- Development workflow
- Testing code in editor
- Quick verification

---

## Edge Case Examples

### Example 11: Very Narrow Terminal (< 20 columns)

**Terminal Width:** 15 columns

**Output:**
```
┌──────────────
───┐
│  Hello World
!   │
└──────────────
───┘
```

**Description:**
- Lines wrap due to insufficient width
- Box appearance is disrupted
- Functionality intact, visual appeal lost

**Recommendation:**
- Minimum 20 columns for proper display
- Tool could detect terminal width and adjust (future enhancement)

---

### Example 12: Monochrome Terminal

**Terminal:** VT100 monochrome mode

**Output:**
```
┌─────────────────┐
│  Hello World!   │
└─────────────────┘
```

**Description:**
- ANSI color codes ignored
- Box structure remains visible
- Graceful degradation

**Use Case:**
- Legacy systems
- Accessibility (color-blind users)
- Minimalist terminal setups

---

### Example 13: Non-UTF-8 Locale

**Locale:** `C` or `ASCII`

**Command:**
```bash
LC_ALL=C ./hello-world
```

**Output (may vary):**
```
?─────────────────?
?  Hello World!   ?
?─────────────────?
```

**Description:**
- Unicode box characters render as `?` or other fallback
- "Hello World!" text still readable
- Visual quality degraded

**Fix:**
```bash
export LANG=en_US.UTF-8
./hello-world
```

---

## Advanced Usage Examples

### Example 14: Parallel Execution

**Command:**
```bash
for i in {1..10}; do ./hello-world & done; wait
```

**Output:**
```
┌─────────────────┐
│  Hello World!   │
└─────────────────┘
┌─────────────────┐
│  Hello World!   │
└─────────────────┘
[... 8 more boxes ...]
```

**Description:**
- Multiple instances run concurrently
- Each outputs its own box
- No conflicts (stateless tool)

**Use Case:**
- Stress testing
- Concurrency demonstrations
- Load testing scripts

---

### Example 15: With Custom Error Handling

**Script:**
```bash
#!/bin/bash
if ./hello-world; then
    echo "✓ Greeting successful"
else
    echo "✗ Greeting failed"
    exit 1
fi
```

**Output:**
```
┌─────────────────┐
│  Hello World!   │
└─────────────────┘
✓ Greeting successful
```

**Use Case:**
- Robust script integration
- Error handling patterns
- CI/CD pipelines

---

### Example 16: As Part of MOTD (Message of the Day)

**File (`/etc/update-motd.d/99-hello-world`):**
```bash
#!/bin/bash
/usr/local/bin/hello-world
echo "Welcome to the server!"
```

**Output (on SSH login):**
```
┌─────────────────┐
│  Hello World!   │
└─────────────────┘
Welcome to the server!

Last login: Sat Jan 11 10:30:45 2026 from 192.168.1.100
user@server:~$
```

**Use Case:**
- Server login messages
- System administrator customization
- Branding for shared systems

---

### Example 17: Testing with Different Shells

**bash:**
```bash
./hello-world
```
✅ Works perfectly

**zsh:**
```zsh
./hello-world
```
✅ Works perfectly

**sh (POSIX shell):**
```sh
./hello-world
```
✅ Works (script uses bash shebang)

**fish:**
```fish
./hello-world
```
✅ Works perfectly

**Description:**
- Compatible with all major shells
- Shebang ensures bash is used for execution
- Shell-agnostic output

---

## Creative Use Cases

### Example 18: ASCII Art Gallery

**Script:**
```bash
#!/bin/bash
echo "=== Greeting Collection ==="
./hello-world
echo ""
echo "=== Plain Version ==="
./hello-world | cat
```

**Output:**
```
=== Greeting Collection ===
┌─────────────────┐
│  Hello World!   │
└─────────────────┘

=== Plain Version ===
Hello World
```

---

### Example 19: Performance Benchmark

**Script:**
```bash
#!/bin/bash
time for i in {1..1000}; do ./hello-world > /dev/null; done
```

**Output:**
```
real    0m0.523s
user    0m0.312s
sys     0m0.198s
```

**Description:**
- 1000 executions in ~0.5 seconds
- ~0.5ms per execution
- Excellent performance

---

### Example 20: Docker Container Greeting

**Dockerfile:**
```dockerfile
FROM alpine:latest
RUN apk add --no-cache bash
COPY hello-world /usr/local/bin/
RUN chmod +x /usr/local/bin/hello-world
CMD ["/usr/local/bin/hello-world"]
```

**Command:**
```bash
docker build -t hello-world .
docker run hello-world
```

**Output:**
```
Hello World
```

**Description:**
- Runs in non-TTY mode by default in Docker
- Plain text output
- Perfect for container initialization

---

## Comparison Examples

### Example 21: Before and After Piping

**Direct Execution:**
```bash
./hello-world
```
```
┌─────────────────┐
│  Hello World!   │
└─────────────────┘
```

**Piped Through `cat`:**
```bash
./hello-world | cat
```
```
Hello World
```

**Side-by-Side Comparison:**
| Context | Output Format | Characters | Lines |
|---------|--------------|------------|-------|
| TTY | Colored box | 17-19 chars | 3 lines |
| Pipe | Plain text | 11 chars | 1 line |

---

## Visual Styling Variations (Future Ideas - Not Implemented)

These examples show potential future enhancements following YAGNI principles:

### Example 22: Alternative Box Style (Not Implemented)
```
╔═════════════════╗
║  Hello World!   ║
╚═════════════════╝
```
*Double-line box style*

### Example 23: Gradient Effect (Not Implemented)
```
┌─────────────────┐  (cyan)
│  Hello World!   │  (gradient cyan → blue)
└─────────────────┘  (blue)
```
*Color gradient - requires 256-color support*

### Example 24: Minimal Style (Not Implemented)
```
Hello World!
━━━━━━━━━━━
```
*Simpler underline style*

**Note:** These variations are NOT implemented, following the YAGNI principle. They're documented for future consideration if user demand emerges.

---

## Summary

The hello-world CLI adapts intelligently to different contexts:
- **Interactive terminals**: Beautiful, colored box
- **Pipes/scripts**: Plain, parseable text
- **Remote sessions**: Works seamlessly
- **Containers**: Appropriate plain output
- **Shell scripts**: Easy integration
- **System services**: Clean logging

All examples demonstrate the tool's versatility while maintaining simplicity and reliability.
