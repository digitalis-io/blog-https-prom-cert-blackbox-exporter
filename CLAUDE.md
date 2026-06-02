# blog-https-prom-cert-blackbox-exporter - CLAUDE.md

## Project Overview

Generic repository scaffolded from `blog-https-prom-cert-blackbox-exporter` with `--type other`. Use this type for repos that don't fit the standard stacks (Ansible, Terraform, Go, Python, combined): documentation collections, configuration bundles, scripts, prototypes, design assets, etc.

If the repo grows into a recognised stack, re-bootstrap with the correct `--type` and migrate the content.

## Current Status
- **Last Updated**: TBD
- **Current Phase**: Development
- **Health**: Green

## Global standards — see ~/.claude/DIGITALIS.md

Shared engineering standards live in `~/.claude/DIGITALIS.md` (installed from the `claude-skills` marketplace) and are **not** repeated here: terse communication, KnowledgeRelay/RAG sourcing for AxonOps/Digitalis/customer questions, secrets management, signed + DCO commits with brand-based identity, branding, README requirements, `CHANGELOG.md`, and the NEVER-DO list. This file covers only what is specific to `--type other` repos.

## Active Tasks
None.

## Recent Progress
- Initial scaffold from `blog-https-prom-cert-blackbox-exporter`

## Blockers & Issues
None currently.

## Architecture & Key Decisions
- **Stack**: Not specified — see project README for what this repo contains
- **Pre-commit**: standard hygiene hooks (trailing whitespace, EOF, YAML/JSON validation), `yamllint` (relaxed), `gitleaks` (secret scanning)
- **No language-specific tooling** — add it if and when the repo gains code in a specific language

## Required Claude Code plugins

Agents and slash commands live in the AxonOps shared marketplace at
`bitbucket.org/digitalisio/claude-skills`. Install once per developer using Claude Code's native plugin marketplace:

```text
/plugin marketplace add git@bitbucket.org:digitalisio/claude-skills.git
/plugin install engineering-agents@axonops-claude-skills
```

### Keeping skills current

Plugins evolve. Pull the latest catalog and update everything in one go:

```text
/plugin marketplace update axonops-claude-skills
/plugin update
```

Optional opt-in: a SessionStart hook can warn when this marketplace is behind. Paste into your personal `~/.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [{
      "matcher": "startup",
      "hooks": [{
        "type": "command",
        "command": "test -d ~/.claude/plugins/marketplaces/axonops-claude-skills && git -C ~/.claude/plugins/marketplaces/axonops-claude-skills fetch --quiet 2>/dev/null && [ \"$(git -C ~/.claude/plugins/marketplaces/axonops-claude-skills rev-list HEAD..origin/main --count 2>/dev/null || echo 0)\" -gt 0 ] && echo 'axonops-claude-skills: updates available — run /plugin marketplace update axonops-claude-skills && /plugin update'"
      }]
    }]
  }
}
```

The legacy `git clone … install.sh --plugin <name>` flow is still supported for non-Claude-Code consumers but is deprecated — it cannot track versions or report updates.

Plugins used:
- `engineering-agents` — `secrets-auditor`, `docs-quality-reviewer`, `code-reviewer`, `security-reviewer`, `shell-script-reviewer`, `tech-decision-maker`, `issue-writer` (generic), `bdd-guidelines` skill (generic BDD rules — see below)

No stack-specific plugin exists for `--type other`. If the content is mostly shell scripts, also rely on `shell-script-reviewer`. When a test suite is introduced (in any language), it must follow `engineering-agents:bdd-guidelines` and the matching stack-specific BDD skill from one of the bootstrap plugins.

## Workflow — Agent Gates

These agents are mandatory gates, not optional tools.

### Before any commit:
- **secrets-auditor** — verify no plaintext credentials, API keys, or tokens
- **docs-quality-reviewer** — if README or user-facing docs changed
- **shell-script-reviewer** — if any `.sh` file changed
- **`agent-skills:security-and-hardening`** — if anything touching credentials, TLS, or external input changed

### Before opening a PR:
- **`agent-skills:code-review-and-quality`** — five-axis review
- **docs-quality-reviewer** — README quality and branding compliance
- Pre-commit hooks pass

### Before creating any issue:
- **issue-writer** (generic, from `engineering-agents`) — full requirements, acceptance criteria, testing notes

## Standards

Branded `README.md`, `CHANGELOG.md` (Keep a Changelog), `LICENSE` (Apache-2.0 unless stated otherwise), and secrets handling all follow `~/.claude/DIGITALIS.md`. Additionally for `--type other` repos: no binaries unless absolutely necessary — prefer release artefacts on GitHub/Bitbucket releases.
