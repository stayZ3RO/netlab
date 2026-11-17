# Agent Instructions

Read these first:

1. `phase-state.md`: Phase 1 complete, Phase 2 VLAN segmentation in progress
2. `ROADMAP.md`
3. `LESSONS-LEARNED.md`
4. `CHANGELOG.md`

## Scope

Project 2 of the home network lab: the historical ER605/Omada cutover, followed by the 2026-09-27 UniFi UDM Pro and USW-24-PoE equivalent-state refresh. Deco remains in AP mode. Builds on `dns` (Project 1). Phase 2 VLAN segmentation is in progress (stations and Wi-Fi mesh moved, servers not yet); firewall policy per service and SSID-to-VLAN mapping are planned.

## Directories

`configs/`, `diagrams/`, `docs/`, `screenshots/`, `screenshots-redacted/`, `scripts/` (relative-link checker used by the docs-check workflows)

## Rules

- Do not commit unless explicitly instructed.
- Do not modify live network/infrastructure from this repo. It's documentation/portfolio, not a control surface.
- Public-safe repo: never introduce secrets, tokens, private keys, or non-public-safe IPs/hostnames.
