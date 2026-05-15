# Templates — Source of Truth

The `templates/agents/` directory is the **source of truth** for agent config templates used by `/setup-auto`.

## Relationship with setup-matt-pocock-skills

Files in `skills/engineering/setup-matt-pocock-skills/` serve the **custom interview** setup flow. Files in `templates/agents/` serve the **auto-setup** flow. They must stay in sync.

When you update a template:

1. Update `templates/agents/` first (source of truth)
2. Then update the matching file in `skills/engineering/setup-matt-pocock-skills/`
3. Both the auto and interview setup paths must produce consistent output

## Template inventory

| Template | Used by | Purpose |
|----------|---------|---------|
| `templates/agents/issue-tracker-github.md` | `/setup-auto` | GitHub issue tracker conventions |
| `templates/agents/issue-tracker-gitlab.md` | `/setup-auto` | GitLab issue tracker conventions |
| `templates/agents/issue-tracker-local.md` | `/setup-auto` | Local markdown issue tracker conventions |
| `templates/agents/triage-labels.md` | `/setup-auto` | Canonical triage label mapping |
| `templates/agents/domain.md` | `/setup-auto` | Domain doc layout + inheritance rules |

## Keeping setup-matt-pocock-skills in sync

| Template | Equivalent in setup-matt-pocock-skills/ |
|----------|----------------------------------------|
| `templates/agents/issue-tracker-github.md` | `setup-matt-pocock-skills/issue-tracker-github.md` |
| `templates/agents/issue-tracker-gitlab.md` | `setup-matt-pocock-skills/issue-tracker-gitlab.md` |
| `templates/agents/issue-tracker-local.md` | `setup-matt-pocock-skills/issue-tracker-local.md` |
| `templates/agents/triage-labels.md` | `setup-matt-pocock-skills/triage-labels.md` |
| `templates/agents/domain.md` | `setup-matt-pocock-skills/domain.md` |
