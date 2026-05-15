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

Create `docs/agents/` if it doesn't exist, then write:

- `docs/agents/issue-tracker.md` — the detected tracker's conventions
- `docs/agents/triage-labels.md` — default label mapping
- `docs/agents/domain.md` — default single-context layout

The source templates live in `templates/agents/` relative to this skill repo. Copy and adapt them — don't write from scratch.

### 4. Update CLAUDE.md or AGENTS.md

Pick the file to edit using the same rules as `/setup-matt-pocock-skills`:

- If `CLAUDE.md` exists, edit it.
- Else if `AGENTS.md` exists, edit it.
- If neither exists, create `CLAUDE.md`.

Add (or update) an `## Agent skills` block:

```markdown
## Agent skills

### Issue tracker

[GitHub / GitLab / Local markdown]. See `docs/agents/issue-tracker.md`.

### Triage labels

Standard canonical labels (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). See `docs/agents/triage-labels.md`.

### Domain docs

Single-context (one `CONTEXT.md` + `docs/adr/` at repo root). See `docs/agents/domain.md`.
```

### 5. Done

Report what was configured. Remind the user:
- To create labels in their issue tracker if they don't exist yet
- That all config can be customized by editing `docs/agents/*.md`
- Run `/setup-matt-pocock-skills` instead if they need a different issue tracker, custom labels, or multi-context layout
