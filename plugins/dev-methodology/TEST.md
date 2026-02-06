# Testing dev-methodology Plugin

## Setup

Start Claude Code with this plugin:

```bash
cd /Users/kaneshin/src/github.com/kaneshin/incubator
cc --plugin-dir ./plugins/dev-methodology
```

Or if you want to test from the plugin directory itself:

```bash
cd /Users/kaneshin/src/github.com/kaneshin/incubator/plugins/dev-methodology
cc --plugin-dir .
```

## Test Cases

### Test 1: TDD Workflow Skill

**Trigger Phrase:** "Let's implement a new feature using TDD"

**Expected Result:**
- Skill should activate automatically
- You should see guidance about Red → Green → Refactor cycle
- Should mention writing failing test first
- Should reference test patterns and refactoring catalog

**Alternative Triggers to Test:**
- "I need to write a test for this function"
- "Let's use test-driven development"
- "Write a failing test first"

### Test 2: Tidy First Skill

**Trigger Phrase:** "I need to refactor this code before adding a feature"

**Expected Result:**
- Skill should activate automatically
- Should explain separating structural from behavioral changes
- Should mention running tests before/after refactoring
- Should reference commit message format (Refactor: prefix)

**Alternative Triggers to Test:**
- "Let's clean up this code"
- "I want to extract this method"
- "Rename these variables"
- "Restructure this module"

### Test 3: UI Development Workflow Skill

**Trigger Phrase:** "Help me build a login form component"

**Expected Result:**
- Skill should activate automatically
- Should mention design-driven workflow
- Should reference Playwright for screenshots
- Should mention implementing in Remix/React

**Alternative Triggers to Test:**
- "Create a React component for this design"
- "Implement this Figma design"
- "Build a Remix route for this page"

### Test 4: Commit Discipline Skill

**Trigger Phrase:** "I'm ready to commit these changes"

**Expected Result:**
- Skill should activate automatically
- Should mention pre-commit checklist (tests, warnings, etc.)
- Should explain commit message format
- Should reference structural vs behavioral commits

**Alternative Triggers to Test:**
- "Let's commit this code"
- "Help me create a git commit"
- "Ready to save these changes"

## Verification Checklist

After starting Claude Code with the plugin:

- [ ] Plugin loads without errors
- [ ] All 4 skills are available
- [ ] Skills activate on appropriate trigger phrases
- [ ] Skill content is displayed correctly
- [ ] Cross-references between skills work
- [ ] README displays plugin information

## Debug Mode

If you want to see plugin loading details:

```bash
cc --plugin-dir ./plugins/dev-methodology --debug
```

This will show:
- Plugin discovery and loading
- Skill registration
- Any errors or warnings

## Expected Output

When you start with the plugin, you should see something like:

```
Loading plugin: dev-methodology
Found 4 skills:
  - TDD Workflow
  - Tidy First
  - UI Development Workflow
  - Commit Discipline
Plugin loaded successfully
```

## Common Issues

**Issue:** Skills don't activate
**Solution:**
- Check that SKILL.md files have valid YAML frontmatter
- Verify trigger phrases in descriptions match what you're saying
- Try `--debug` mode to see loading details

**Issue:** Plugin not found
**Solution:**
- Verify path is correct: `./plugins/dev-methodology`
- Check that `.claude-plugin/plugin.json` exists
- Try absolute path instead of relative

## Integration Testing

Test how skills work together:

1. **TDD + Tidy First:**
   - Say: "Let's implement a new feature, but first I need to refactor this messy code"
   - Should activate Tidy First, then guide through TDD

2. **TDD + Commit:**
   - Say: "I just wrote passing tests, ready to commit"
   - Should activate Commit Discipline

3. **UI + TDD:**
   - Say: "Build a login form component with tests"
   - Should activate both UI Development and TDD Workflow

4. **All together:**
   - Say: "Implement a dashboard UI using TDD, refactor as needed, then commit"
   - Should reference multiple skills appropriately
