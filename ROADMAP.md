# Roadmap

![Status](https://img.shields.io/badge/Status-Active-blue)
![Project](https://img.shields.io/badge/Project-Managed%20Network%20Infrastructure-blue)
![Phase](https://img.shields.io/badge/Phase-2%20VLAN%20Segmentation%20(in%20progress)-purple)
![Docs](https://img.shields.io/badge/Docs-Portfolio%20Ready-informational)

## Project Roadmap for VLAN Segmentation, Firewall Policy, SSID Mapping, and Operations

---

## Overview

This roadmap tracks the progression of the managed network infrastructure lab.

Project 2 starts with a completed managed router/switch cutover. On 2026-09-27 the ER605 and TL-SG2210P were replaced by a UniFi UDM Pro and USW-24-PoE, which are the current network core. The project will continue into VLAN segmentation, firewall policy, SSID mapping, and monitoring updates.

---

## Phase 1 - Managed Router/Switch Cutover and Baseline Validation

Status: ✅ Complete

Focus:

- Dedicated router/firewall introduced
- Managed switch introduced
- Deco mesh moved to AP mode
- DNS/DHCP/internet validated
- Monitoring validated
- Remote access validated

Documentation:

- [Phase 1 Overview](docs/phase-1-managed-network-cutover/overview.md)
- [Phase 1 Implementation](docs/phase-1-managed-network-cutover/implementation.md)
- [Phase 1 Validation](docs/phase-1-managed-network-cutover/validation.md)

---

## Phase 2 - VLAN Segmentation

Status: 🔄 In Progress (first sitting 2026-11-15 to 2026-11-16)

Done:

- Seven segments by role, one firewall zone each
- Narrow allows for DNS, the reverse proxy, owner admin ports, VPN transport and remote desktop
- DNS answering routed segments
- Canary station, remaining wired stations, the Wi-Fi mesh, then the admin station moved and tested

Remaining:

- Move server guests into Lab services, CI and Agents, one sitting each
- Test DNS failover and each subnet router alone from the new segments
- Delete the temporary bridge policy

Documentation:

- [Phase 2 Overview](docs/phase-2-vlan-segmentation/overview.md)
- [Phase 2 Implementation](docs/phase-2-vlan-segmentation/implementation.md)
- [Phase 2 Validation](docs/phase-2-vlan-segmentation/validation.md)
- [Phase 2 Lessons Learned](docs/phase-2-vlan-segmentation/lessons-learned.md)

---

## Phase 3 - Firewall Policy

Status: ⏳ Planned (the base zone matrix landed in Phase 2)

Goals:

- Define inter-VLAN access rules
- Restrict IoT and guest access
- Permit required DNS, DHCP, and NTP
- Permit management access only from trusted/admin networks
- Document firewall policy matrix
- Validate allowed and blocked traffic

---

## Phase 4 - Wireless SSID Mapping

Status: ⏳ Planned

Goals:

- Map SSIDs to VLANs
- Separate trusted Wi-Fi, guest Wi-Fi, IoT Wi-Fi, and lab Wi-Fi
- Validate wireless DHCP assignment
- Validate DNS resolution by SSID
- Confirm isolation behavior

---

## Phase 5 - Monitoring and Operations

Status: ⏳ Planned

Goals:

- Update Prometheus targets by VLAN
- Update Grafana dashboards
- Monitor gateway, switch, APs, DNS, and core services
- Document backup and restore procedures
- Build troubleshooting runbooks
- Document final validation screenshots
