# Setup Global Defaults

Create a global fallback config that all repos inherit. Repos only need `docs/agents/` for overrides.

## Process

### 1. Read the templates

The source templates live in `templates/agents/` relative to this skill repo. Read them.

### 2. Write to global location

Create `~/.claude/agent-skills/` and write:

- `~/.claude/agent-skills/issue-tracker.md` — GitHub conventions (covers 95% of repos)
- `~/.claude/agent-skills/triage-labels.md` — standard canonical labels
- `~/.claude/agent-skills/domain.md` — default single-context layout

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
