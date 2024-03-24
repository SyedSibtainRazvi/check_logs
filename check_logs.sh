#!/bin/bash
set -e

GIT_EXECUTABLE=""
for dir in $(echo "$PATH" | tr ':' '\n'); do
    if [ -x "$dir/git" ]; then
        GIT_EXECUTABLE="$dir/git"
        break
    fi
done

if [ -z "$GIT_EXECUTABLE" ]; then
    echo "ERROR: Git executable not found. Please make sure git is installed and accessible in your PATH."
    exit 1
fi

if "$GIT_EXECUTABLE" diff --name-only "$GITHUB_BASE_REF" "$GITHUB_HEAD_REF" | xargs grep -En '\bconsole\.log\b'; then
  echo "ERROR: Console.log statements found. Please remove them before merging the pull request."
  exit 1
else
  echo "No console.log statements found. Proceeding with the pull request."
fi
