---
name: setup-global
description: Write a global fallback config to ~/.claude/agent-skills/. New repos inherit it automatically — only create repo-level docs/agents/ when you need to override something. Run once per machine.
disable-model-invocation: true
---

# Setup Global Defaults

Create a global fallback config that all repos inherit. Repos only need `docs/agents/` for overrides.

## Process

### 1. Read the templates

Read the template files from `templates/agents/`:

- `issue-tracker-github.md` — GitHub issue tracker conventions
- `triage-labels.md` — standard canonical label mapping
- `domain.md` — default single-context layout + inheritance rules

### 2. Write to global location

Create `~/.claude/agent-skills/` if it doesn't exist. Then write:

- `~/.claude/agent-skills/issue-tracker.md` — copy from the GitHub template (covers 95% of repos)
- `~/.claude/agent-skills/triage-labels.md` — standard canonical labels
- `~/.claude/agent-skills/domain.md` — default single-context layout

**If `~/.claude/agent-skills/` already exists**, warn the user before overwriting any files. Show a diff-like summary of what would change, and ask for confirmation. Never silently overwrite global config that may have been customized.

### 3. Update repo configs to be minimal

For repos that match the global defaults, the `## Agent skills` block in CLAUDE.md can be minimal:

```markdown
## Agent skills

Using global defaults (`~/.claude/agent-skills/`). No repo-specific overrides.
```

For repos that differ (different issue tracker, custom labels, multi-context), run `/setup-auto` or `/setup-matt-pocock-skills` as usual — the repo config takes precedence.

### 4. Tell the user

Explain the inheritance model:

```
~/.claude/agent-skills/     ← global fallback
    ├── issue-tracker.md
    ├── triage-labels.md
    └── domain.md

<repo>/docs/agents/          ← repo override (takes precedence)
    ├── issue-tracker.md      (only if different from global)
    ├── triage-labels.md      (only if different from global)
    └── domain.md             (only if different from global)
```

Skills read repo config first. If a file is missing at the repo level, they fall back to the global file. A repo with zero `docs/agents/` files inherits everything from global.
