#!/bin/bash
set -e

# Fetch the list of changed files in the pull request
changed_files=$(git show --name-only "$GITHUB_SHA")

# Check for console.log statements in changed files
if echo "$changed_files" | grep -E '\.js$' | xargs grep -En '\bconsole\.log\b'; then
  echo "ERROR: Console.log statements found. Please remove them before merging the pull request."
  exit 1
else
  echo "No console.log statements found. Proceeding with the pull request."
fi
