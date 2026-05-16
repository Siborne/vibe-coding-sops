# Auto-Update Stats Rule

When adding, modifying, or deleting files in any of the following directories, you MUST:

1. Run `bash scripts/generate-stats.sh` to regenerate `stats.json`
2. Update `README.md` if any counts changed

## Tracked Directories

| Directory | Tracked Content | Badge Label |
|-----------|----------------|-------------|
| `rules/` | Rule definitions | `rules` |
| `skills/` | Skill definitions | `skills` |
| `rationale/` | Rationale files (all languages) | `rationale` |
| `docs/变更记录/` | Code change logs | `changelogs` |
| `docs/superpowers/plans/` | Implementation plans | `plans` |
| `docs/superpowers/specs/` | Design specs | `specs` |

## Why

The README badges point to `stats.json` via shields.io dynamic JSON endpoint badges. If `stats.json` is not regenerated after a content change, the badge counts become stale and misleading.

## How to Apply

After every Edit/Write/Create/Delete that touches any of the tracked directories:

1. `bash scripts/generate-stats.sh`
2. Check the output — if any number changed, the README badges will reflect it automatically on next push (shields.io caches for ~5 min)
3. If a new category is added (e.g., `subagents/`), update this rule's tracked-directory table AND add a corresponding badge to README
