#!/bin/bash
# Regenerate stats.json from current repo directory contents.
# Run from repo root or via: bash scripts/generate-stats.sh

set -euo pipefail
cd "$(dirname "$0")/.."

RULES=$(find rules/ -maxdepth 1 -name '*.md' 2>/dev/null | wc -l)
SKILLS=$(find skills/ -maxdepth 1 -name '*.md' 2>/dev/null | wc -l)
RATIONALE=$(find rationale/ -name '*.md' 2>/dev/null | wc -l)
CHANGELOGS=$(find docs/变更记录/ -maxdepth 1 -name '*.md' 2>/dev/null | wc -l)
PLANS=$(find docs/superpowers/plans/ -maxdepth 1 -name '*.md' 2>/dev/null | wc -l)
SPECS=$(find docs/superpowers/specs/ -maxdepth 1 -name '*.md' 2>/dev/null | wc -l)

cat > stats.json <<JSON
{
  "rules": $RULES,
  "skills": $SKILLS,
  "rationale": $RATIONALE,
  "changelogs": $CHANGELOGS,
  "plans": $PLANS,
  "specs": $SPECS
}
JSON

echo "stats.json updated:"
cat stats.json
