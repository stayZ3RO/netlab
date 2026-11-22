# Current Status

![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)
![Project](https://img.shields.io/badge/Project-Managed%20Network%20Infrastructure-blue)
![Phase](https://img.shields.io/badge/Phase-2%20VLAN%20Segmentation%20(in%20progress)-purple)
![Docs](https://img.shields.io/badge/Docs-Portfolio%20Ready-informational)

## UniFi Network Core Live; VLAN Segmentation In Progress

---

## Project Status

**Phase 1 and the 2026-09-27 UniFi hardware refresh are complete.**

The current network core is a UniFi UDM Pro and USW-24-PoE, with Deco nodes in AP mode. Phase 1 documents the earlier ER605 and Omada cutover as history.

**Phase 2 is in progress.** The first sitting, 2026-11-15 to 2026-11-16, moved the wired owner stations to a Clients segment and the Deco mesh to an untrusted Wi-Fi segment, behind zone-based policies. Servers are still on the Servers segment. See [Phase 2](docs/phase-2-vlan-segmentation/).

---

## Completed Work

| Area | Status | Notes |
|---|---:|---|
| ER605 router cutover | ✅ Complete | Historical Phase 1 cutover, replaced by UniFi on 2026-09-27 |
| Managed switch integration | ✅ Complete | Historical TL-SG2210P integration, replaced by USW-24-PoE |
| UniFi hardware refresh | ✅ Complete | UDM Pro and USW-24-PoE form the current network core |
| Deco AP mode migration | ✅ Complete | Deco mesh is no longer acting as the router |
| DNS validation | ✅ Complete | Pi-hole HA DNS path remained operational |
| DHCP validation | ✅ Complete | Clients received valid leases |
| Internet validation | ✅ Complete | Wired and wireless clients had internet access |
| Proxmox service validation | ✅ Complete | Proxmox-hosted services remained reachable |
| Monitoring validation | ✅ Complete | Grafana and Prometheus remained available |
| Remote access validation | ✅ Complete | Remote management path remained functional |
| Phase 2 segments and zones | ✅ Complete | Seven segments, one zone each, blocked between zones by default |
| Phase 2 station and Wi-Fi moves | ✅ Complete | Canary, wired stations, Deco mesh, admin station last |

---

## Current Architecture

```text
Internet
  ↓
ONT
  ↓
AT&T Gateway / IP Passthrough
  ↓
UniFi UDM Pro
  ↓
UniFi USW-24-PoE Managed Switch
  ├── Deco Mesh APs
  ├── Proxmox Host
  ├── Primary Pi-hole
  ├── Secondary Pi-hole
  ├── Wired Clients
  └── Wireless Clients
```

---

## Current Focus

The current focus is finishing **Phase 2: VLAN Segmentation**.

See [Open Items](#open-items) for the remaining work.

---

## Open Items

- Move server guests into the Lab services, CI and Agents segments, one sitting each.
- Test DNS failover and each subnet router alone from the new segments.
- Verify the persisted `DOCKER-USER` rule after a reboot. See the [implementation record](docs/phase-2-vlan-segmentation/implementation.md) and [validation record](docs/phase-2-vlan-segmentation/validation.md).
- Delete the temporary bridge policy.
- Prepare and apply trusted and guest SSID mappings on the new access point in Phase 4.
- Update monitoring targets after segmentation.
- Document the final diagrams and screenshots.

---

## Why VLANs Were Deferred

VLANs were intentionally deferred until after the router/switch cutover was completed and validated.

This keeps the project clean:

1. Establish a stable managed network baseline.
2. Validate DNS, DHCP, internet, monitoring, and remote access.
3. Introduce segmentation and firewall policy after the baseline is stable.

---

## Next Documentation Tasks

| Task | Status |
|---|---:|
| Add current physical topology diagram | ✅ Complete |
| Add final logical topology diagram | ⏳ Pending |
| Add sanitized Phase 1 Omada screenshots | ✅ Complete |
| Add switch port mapping | ⏳ Pending |
| Start VLAN/subnet design | ✅ Complete |
| Build firewall policy matrix | ✅ Complete (base zone matrix) |
| Add redacted Phase 2 screenshots | ⏳ Pending |

---

## Summary

Phase 1 successfully moved the network to a managed infrastructure foundation, and the 2026-09-27 UniFi hardware refresh (UDM Pro and USW-24-PoE) replaced the original router and switch.

Phase 2 has segments, zones and narrow allows in place, with the owner stations and Wi-Fi moved. Server moves, SSID mapping and per-service firewall policy come next.
