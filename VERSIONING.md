# Keeping Skills Updated

These skills are forked from [mattpocock/skills](https://github.com/mattpocock/skills). Here's how to stay in sync.

## Check for upstream updates

```bash
# See what's changed upstream since your last sync
git fetch upstream
git log upstream/main --oneline --since="2 weeks ago"
```

Or run the check script:

```bash
bash scripts/check-upstream-updates.sh
```

This tells you which skill files have changed upstream and whether any of them conflict with your customizations.

## Merge strategy

### Simple case: no conflicts

```bash
git fetch upstream
git merge upstream/main
# Resolve any trivial conflicts, push
git push origin main
```

### Customized skills with conflicts

If you've heavily modified a skill that also changed upstream, **merge — don't replace**:

```bash
git fetch upstream
git merge upstream/main
# Resolve conflicts in customized files manually.
# Merging preserves your new files (e.g. test-strategy.md),
# unlike 'git checkout upstream/main -- <dir>/' which deletes them.
```

For a specific file, review upstream changes before merging:

```bash
git diff upstream/main -- skills/engineering/<skill-name>/SKILL.md
git merge upstream/main
# Resolve any conflicts, re-apply customizations if needed
```

Then update the sync marker and push:

```bash
git rev-parse upstream/main > .skill-sync
git push origin main
```

## Which skills you own

Skills you've created or significantly modified (your customizations take priority):

| Skill | Status | Notes |
|-------|--------|-------|
| `/setup-auto` | Custom | Your creation — no upstream equivalent |
| `/setup-global` | Custom | Your creation — no upstream equivalent |
| `/grill-with-docs` | Modified | ADR criteria relaxed (3-tier instead of all-or-nothing), ADR-FORMAT.md updated |
| `/tdd` | Modified | Added `test-strategy.md`, updated philosophy to include unit tests |
| `templates/` | Custom | Agent config templates for auto-setup |
| `scripts/` | Custom | `check-upstream-updates.sh` for version tracking |
| `VERSIONING.md` | Custom | This file |
| `TEMPLATES.md` | Custom | Template inventory and sync strategy |
| `.skill-sync` | Custom | Upstream sync marker |

Everything else tracks upstream directly. If Matt rewrites a skill you haven't touched, just merge it.
