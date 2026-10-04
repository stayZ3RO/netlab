# Changelog

![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![Project](https://img.shields.io/badge/Project-Managed%20Network%20Infrastructure-blue)
![Docs](https://img.shields.io/badge/Docs-Portfolio%20Ready-informational)

## Documentation and Infrastructure Change History

---

### 2026-09-27 UniFi hardware refresh

- Replaced the ER605 and TL-SG2210P with a UDM Pro and USW-24-PoE in an equivalent-state cutover.
- Kept the LAN flat, with the same gateway, DHCP, DNS, and Deco AP behavior. VLAN segmentation and firewall policy remain planned.

### Recent documentation merges

- 2026-09-22: redacted the ER605 WAN and reservation screenshots (#9).
- 2026-09-27: updated links to renamed public repositories (#11).
- 2026-09-28: clarified README network status and wording (#12).

### Added

- Initial project repository structure
- Main README with portfolio-style project overview
- Current status document
- Project roadmap
- Lessons learned summary
- Phase 1 managed network cutover documentation
- Implementation notes
- Validation checklist
- Rollback plan
- Screenshot checklist
- Diagram documentation
- Top-level diagrams, screenshots, and config folders

### Completed

- ER605 router/firewall cutover
- TL-SG2210P managed switch integration
- Deco AP mode migration
- DNS validation
- DHCP validation
- Internet validation
- Pi-hole HA DNS validation
- Proxmox service validation
- Monitoring validation
- Remote access validation

### Changed

- Updated README format to better match the existing home infrastructure lab repository style
- Added clearer section labels, emoji status indicators, and documentation navigation
- Reframed Project 2 as the managed network foundation for VLAN segmentation

### Next

- Add final topology diagrams
- Add sanitized screenshots
- Begin VLAN segmentation design
- Create VLAN/subnet table
- Build firewall policy matrix
- Map SSIDs to VLANs
