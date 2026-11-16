# Phase 2: VLAN Segmentation

![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)
![Phase](https://img.shields.io/badge/Phase-2%20VLAN%20Segmentation-purple)
![Routing](https://img.shields.io/badge/Routing-UDM%20Pro-informational)
![Firewall](https://img.shields.io/badge/Firewall-Zone--Based-red)
![Docs](https://img.shields.io/badge/Docs-Portfolio%20Ready-informational)

## Segments, Zones, Narrow Allows, and a Staged Cutover of the Stations

---

## Status

In progress. The first sitting ran on 2026-11-15 and 2026-11-16.

- Seven networks exist, one zone each. The zone defaults block traffic between zones.
- The wired owner stations are on the Clients segment.
- The whole Wi-Fi mesh is on the untrusted Wi-Fi segment.
- Every server, the DNS pair, the subnet routers and the Proxmox nodes are still on the Servers segment.
- The Guests, Lab services, CI and Agents segments exist and are empty.

Moving servers into their segments, and the trusted and guest SSIDs on a new access point, are later sittings.

---

## Documentation Index

| Document | Purpose |
|---|---|
| [Overview](overview.md) | Goals, the segment plan, the zone matrix and the narrow allows |
| [Implementation](implementation.md) | The cutover order and what was done at each step |
| [Validation](validation.md) | The tests, what counts as proof, results, and what was not tested |
| [Lessons Learned](lessons-learned.md) | What the sitting showed, including four tests that passed for the wrong reason |
| [Screenshots](screenshots.md) | Evidence still to capture and redact |

---

## Phase 2 Result So Far

| Area | Result |
|---|---:|
| Networks and zones created | ✅ Complete |
| Zone policies for DNS, proxy, admin, VPN transport, remote desktop | ✅ Complete |
| DNS answering routed segments | ✅ Complete |
| Canary station moved and tested | ✅ Complete |
| Remaining wired stations moved | ✅ Complete |
| Wi-Fi mesh moved to the untrusted Wi-Fi segment | ✅ Complete |
| Admin station moved last | ✅ Complete |
| Servers moved into Lab services, CI and Agents | ⏳ Planned |
| Trusted and guest SSIDs on the new access point | ⏳ Planned (Phase 4) |
| Rollback required | ❌ No |

All addresses in these documents are examples. They do not match the real plan.
