---
name: setup-auto
description: One-shot auto-setup that scaffolds per-repo issue tracker, triage labels, and domain docs config without an interview. Run once per repo — detects your setup from git remotes and uses sensible defaults. Override any setting later by editing docs/agents/*.md directly.
disable-model-invocation: true
---

# Setup Auto

Scaffold the per-repo configuration for Matt Pocock's skills in **one shot, no interview**. Detects your issue tracker from git remotes and applies sensible defaults for everything else.

## Process

### 1. Detect

Run `git remote -v` to determine the issue tracker:

| Remote host contains | Issue tracker | CLI |
|---|---|---|
| `github.com` | GitHub | `gh` |
| `gitlab.com` or self-hosted GitLab | GitLab | `glab` |
| None of the above | Local markdown | file system |

### 2. Apply defaults

- **Triage labels**: standard canonical names (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`)
- **Domain docs**: single-context (one `CONTEXT.md` + `docs/adr/` at repo root)

### 3. Write config files

**Check for existing files first.** If `docs/agents/` already exists, list the files that would be overwritten and ask the user to confirm before proceeding. Never silently overwrite existing config.

Create `docs/agents/` if it doesn't exist, then copy and adapt the correct template based on the detected tracker:

| Detected tracker | Template to use |
|---|---|
| GitHub | `templates/agents/issue-tracker-github.md` |
| GitLab | `templates/agents/issue-tracker-gitlab.md` |
| Local markdown | `templates/agents/issue-tracker-local.md` |

Also write these two files (same for all trackers):

- `docs/agents/triage-labels.md` — from `templates/agents/triage-labels.md`
- `docs/agents/domain.md` — from `templates/agents/domain.md`

### 4. Update CLAUDE.md or AGENTS.md

Pick the file to edit:

- If `CLAUDE.md` exists, edit it.
- Else if `AGENTS.md` exists, edit it.
- If neither exists, create `CLAUDE.md`. (Auto-setup picks CLAUDE.md for you — that's the trade-off for skipping the interview. Unlike `/setup-matt-pocock-skills` which asks, this skill defaults to the most common convention.)

Add (or update) an `## Agent skills` block. **Use the actual detected tracker name** in the issue tracker line — not a list of all possibilities:

```markdown
## Agent skills

### Issue tracker

[DETECTED_TRACKER_NAME — one of: "GitHub", "GitLab", or "Local markdown"]. See `docs/agents/issue-tracker.md`.

### Triage labels

Standard canonical labels (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). See `docs/agents/triage-labels.md`.

### Domain docs

Single-context (one `CONTEXT.md` + `docs/adr/` at repo root). See `docs/agents/domain.md`.
```

Replace `[DETECTED_TRACKER_NAME]` with the actual tracker string — e.g. `GitHub.` for a GitHub repo.

### 5. Done

Report what was configured. Remind the user:
- To create labels in their issue tracker if they don't exist yet
- That all config can be customized by editing `docs/agents/*.md`
- Run `/setup-matt-pocock-skills` instead if they need a different issue tracker, custom labels, or multi-context layout
