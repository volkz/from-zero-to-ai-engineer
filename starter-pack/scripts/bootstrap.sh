#!/usr/bin/env bash
# bootstrap.sh — copies the starter pack into an existing repo
# Run from: bash /path/to/from-zero-to-ai-engineer/starter-pack/scripts/bootstrap.sh
# Run inside your target project directory.

set -euo pipefail

STARTER="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${PWD}"

echo "Starter pack: $STARTER"
echo "Target repo:  $TARGET"
echo ""

confirm() {
  read -r -p "$1 [y/N] " response
  case "$response" in
    [yY][eE][sS]|[yY]) return 0 ;;
    *) return 1 ;;
  esac
}

# AGENTS.md
if [[ -f "$TARGET/AGENTS.md" ]]; then
  echo "AGENTS.md already exists — skipping (edit it manually)."
else
  cp "$STARTER/AGENTS.md" "$TARGET/AGENTS.md"
  echo "Copied AGENTS.md"
fi

# .cursorignore
if [[ -f "$TARGET/.cursorignore" ]]; then
  echo ".cursorignore already exists — appending starter entries..."
  echo "" >> "$TARGET/.cursorignore"
  echo "# Added by from-zero-to-ai-engineer starter pack" >> "$TARGET/.cursorignore"
  grep -v '^#' "$STARTER/.cursorignore" | grep -v '^$' >> "$TARGET/.cursorignore"
else
  cp "$STARTER/.cursorignore" "$TARGET/.cursorignore"
  echo "Copied .cursorignore"
fi

# Cursor rules
mkdir -p "$TARGET/.cursor/rules"
if [[ -f "$TARGET/.cursor/rules/repo-laws.mdc" ]]; then
  echo ".cursor/rules/repo-laws.mdc already exists — skipping."
else
  cp "$STARTER/.cursor/rules/repo-laws.mdc" "$TARGET/.cursor/rules/repo-laws.mdc"
  echo "Copied .cursor/rules/repo-laws.mdc"
fi

# Claude Code skills
mkdir -p "$TARGET/.claude/skills"
for skill_dir in "$STARTER/.claude/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  if [[ -d "$TARGET/.claude/skills/$skill_name" ]]; then
    echo ".claude/skills/$skill_name already exists — skipping."
  else
    cp -r "$skill_dir" "$TARGET/.claude/skills/$skill_name"
    echo "Copied .claude/skills/$skill_name"
  fi
done

# Claude Code commands
mkdir -p "$TARGET/.claude/commands"
if [[ -f "$TARGET/.claude/commands/plan.md" ]]; then
  echo ".claude/commands/plan.md already exists — skipping."
else
  cp "$STARTER/.claude/commands/plan.md" "$TARGET/.claude/commands/plan.md"
  echo "Copied .claude/commands/plan.md"
fi

# CI workflow
mkdir -p "$TARGET/.github/workflows"
if [[ -f "$TARGET/.github/workflows/lint-ai-config.yml" ]]; then
  echo ".github/workflows/lint-ai-config.yml already exists — skipping."
else
  cp "$STARTER/.github/workflows/lint-ai-config.yml" "$TARGET/.github/workflows/lint-ai-config.yml"
  echo "Copied .github/workflows/lint-ai-config.yml"
fi

echo ""
echo "Done. Next steps:"
echo "  1. Open AGENTS.md and fill in the [FILL IN] sections."
echo "  2. Run: npx agents-md-lint AGENTS.md"
echo "  3. Commit everything with CODEOWNERS protection."
echo "  4. Smoke test: ask your AI 'What are the exact commands to run tests in this project?'"
