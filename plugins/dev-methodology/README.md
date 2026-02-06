# Development Methodology Plugin

Skills for guiding development following TDD methodology, Tidy First approach, and clean code principles.

## Features

This plugin provides four skills that automatically activate based on your development context:

### 1. TDD Workflow
Guides you through the Red → Green → Refactor cycle for test-driven development.

**Activates when:** Implementing features, writing tests, or mentioning TDD

### 2. Tidy First
Enforces separation of structural changes (refactoring) from behavioral changes (new functionality).

**Activates when:** Refactoring, restructuring, or cleaning up code

### 3. UI Development
Guides through the design-driven UI development workflow with Playwright integration.

**Activates when:** Building UI components, implementing designs, or working with Remix routes

### 4. Commit Discipline
Ensures commits meet quality standards: all tests passing, no warnings, clear messages.

**Activates when:** Ready to commit changes

## Installation

This plugin is part of the incubator project and loads automatically from the `plugins/` directory.

## Usage

Skills activate automatically when Claude Code detects relevant context in your requests. No manual invocation needed.

## Principles

Based on:
- TDD methodology
- "Tidy First" approach to refactoring
- KISS (Keep It Simple, Stupid)
- YAGNI (You Aren't Gonna Need It)

## Version

0.1.0
