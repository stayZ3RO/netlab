# Current Topology: UniFi (flat LAN)

The UDM Pro and USW-24-PoE have been the network core since the
2026-09-27 equivalent-state cutover. Deco nodes remain access points. The LAN
is still flat; VLAN segmentation and inter-VLAN firewall policy are planned.
The [Phase 1 diagrams](../docs/phase-1-managed-network-cutover/diagrams.md)
record the earlier ER605 and Omada network.

```mermaid
flowchart TD
    ONT["AT&T Fiber ONT and gateway"]
    UDM["UniFi UDM Pro<br/>gateway, firewall, and DHCP"]
    SW["UniFi USW-24-PoE<br/>managed PoE switch"]
    DECO["Deco nodes<br/>AP mode"]
    DNS["Pi-hole HA pair<br/>Keepalived VIP and Unbound"]
    PVE["Proxmox cluster"]
    MON["Monitoring VM 294<br/>Prometheus, Grafana, Alertmanager"]
    CLIENTS["Wired and wireless clients"]

    ONT -->|IP passthrough| UDM
    UDM --> SW
    SW --> DECO
    SW --> DNS
    SW --> PVE
    SW --> CLIENTS
    PVE --> MON
    DECO --> CLIENTS
```

The UDM Pro supplies DHCP, with the Pi-hole VIP as client DNS. The
2026-09-27 cutover kept the same gateway and DNS behavior; it did not
introduce segmentation.
