# Current Status

![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![Project](https://img.shields.io/badge/Project-Managed%20Network%20Infrastructure-blue)
![Phase](https://img.shields.io/badge/Phase-1%20Managed%20Cutover-purple)
![Docs](https://img.shields.io/badge/Docs-Portfolio%20Ready-informational)

## UniFi Network Core Live; VLAN Segmentation Planned

---

## Project Status

**Phase 1 and the 2026-09-27 UniFi hardware refresh are complete.**

The current network core is a UniFi UDM Pro and USW-24-PoE. The LAN remains flat, with Deco nodes in AP mode. Phase 1 documents the earlier ER605 and Omada cutover as history.

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

The next focus is **Phase 2: VLAN Segmentation**.

Planned work:

- Define network zones
- Assign VLAN IDs
- Create subnet plan
- Plan DHCP scopes
- Plan firewall rules
- Determine trunk/access port layout
- Prepare SSID-to-VLAN mapping

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
| Start VLAN/subnet design | ⏳ Pending |
| Build firewall policy matrix | ⏳ Pending |

---

## Summary

Phase 1 successfully moved the network to a managed infrastructure foundation.

The environment is now ready for VLAN design, segmentation planning, firewall policy work, and SSID-to-VLAN mapping.
