#!/bin/bash
set -e

if git diff --name-only "$GITHUB_BASE_REF" "$GITHUB_HEAD_REF" | xargs grep -En '\bconsole\.log\b'; then
  echo "ERROR: Console.log statements found. Please remove them before merging the pull request."
  exit 1
else
  echo "No console.log statements found. Proceeding with the pull request."
fi
