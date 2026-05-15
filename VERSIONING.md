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

If you've heavily modified a skill that also changed upstream, merge the upstream changes selectively:

```bash
git fetch upstream
git checkout upstream/main -- skills/engineering/<skill-name>/
# Review the diff, re-apply your customizations
git diff --cached
git commit -m "Sync <skill-name> from upstream, re-apply customizations"
```

## Which skills you own

Skills you've created or significantly modified (your customizations take priority):

| Skill | Status | Notes |
|-------|--------|-------|
| `/setup-auto` | Custom | Your creation — no upstream equivalent |
| `/setup-global` | Custom | Your creation — no upstream equivalent |
| `/grill-with-docs` | Modified | ADR criteria relaxed (3-tier instead of all-or-nothing) |
| `/tdd` | Modified | Added unit test strategy alongside integration tests |
| `templates/` | Custom | Template config for auto-setup |

Everything else tracks upstream directly. If Matt rewrites a skill you haven't touched, just merge it.
