#!/usr/bin/env bats

# Test setup - define path to the script under test
SCRIPT_PATH="${BATS_TEST_DIRNAME}/../hello-world"

@test "script executes successfully" {
  run "${SCRIPT_PATH}"
  [ "$status" -eq 0 ]
}

@test "output contains Hello World" {
  run "${SCRIPT_PATH}"
  [[ "$output" =~ "Hello World" ]]
}

@test "output contains box drawing when TTY detected" {
  # Force TTY-like behavior by using script command to run in a pseudo-terminal
  run script -q /dev/null "${SCRIPT_PATH}"
  # Check for box drawing characters
  [[ "$output" =~ "┌" ]]
  [[ "$output" =~ "│" ]]
  [[ "$output" =~ "└" ]]
}

@test "output contains ANSI colors when TTY detected" {
  # Force TTY-like behavior
  run script -q /dev/null "${SCRIPT_PATH}"
  # Check for ANSI escape codes - look for specific cyan color code or any escape sequence
  # Using grep to check for escape sequences in a more robust way
  echo "$output" | grep -q $'\033\['
  [ "$?" -eq 0 ]
}

@test "output is plain text when piped (non-TTY)" {
  # Run without TTY (normal bats run context is non-TTY)
  run "${SCRIPT_PATH}"
  # Should NOT contain box drawing characters
  [[ ! "$output" =~ "┌" ]]
  [[ ! "$output" =~ "│" ]]
  # Should NOT contain ANSI escape codes
  ! echo "$output" | grep -q $'\033\['
  # Should contain plain text
  [[ "$output" == "Hello World" ]]
}
