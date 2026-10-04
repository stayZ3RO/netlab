# Agent Instructions

Read these first:

1. `CURRENT-STATUS.md`: Phase 1 complete, managed network baseline ready for VLAN segmentation
2. `ROADMAP.md`
3. `LESSONS-LEARNED.md`
4. `CHANGELOG.md`

## Scope

Project 2 of the home network lab: the historical ER605/Omada cutover, followed by the 2026-09-27 UniFi UDM Pro and USW-24-PoE equivalent-state refresh. Deco remains in AP mode. Builds on `dns` (Project 1). The LAN is flat; VLAN segmentation, firewall policy, and SSID-to-VLAN mapping are planned.

## Directories

`configs/`, `diagrams/`, `docs/`, `screenshots/`, `screenshots-redacted/`

## Rules

- Do not commit unless explicitly instructed.
- Do not modify live network/infrastructure from this repo. It's documentation/portfolio, not a control surface.
- Public-safe repo: never introduce secrets, tokens, private keys, or non-public-safe IPs/hostnames.
