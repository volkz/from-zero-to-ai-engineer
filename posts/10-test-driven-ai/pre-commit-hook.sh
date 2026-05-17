#!/bin/sh
# Pre-commit hook: reject commits that add or modify CONTRACT envelopes with STATUS: FAIL
# or that modify source files without a companion CONTRACT envelope.
#
# Install: cp pre-commit-hook.sh .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit
# Requires: grep, git

set -e

STAGED=$(git diff --cached --name-only)

# Check 1: no CONTRACT envelope with STATUS: FAIL may be committed
for file in $STAGED; do
  if echo "$file" | grep -q "contract-envelope.yaml"; then
    if git show ":$file" | grep -q "^STATUS: FAIL"; then
      echo "ERROR: $file has STATUS: FAIL — fix the failing tests before committing."
      exit 1
    fi
  fi
done

# Check 2: warn (not block) if source files changed without a companion CONTRACT
SOURCE_CHANGED=$(echo "$STAGED" | grep -E "\.(ts|js|py)$" | grep -v "spec\|test\|__tests__" || true)
CONTRACT_STAGED=$(echo "$STAGED" | grep "contract-envelope.yaml" || true)

if [ -n "$SOURCE_CHANGED" ] && [ -z "$CONTRACT_STAGED" ]; then
  echo "WARNING: source files changed without a CONTRACT envelope."
  echo "Consider adding a contract-envelope.yaml to document what was verified."
  echo "Changed files:"
  echo "$SOURCE_CHANGED"
  # Warning only — does not block commit. Change 'echo' to 'exit 1' to enforce.
fi

exit 0
