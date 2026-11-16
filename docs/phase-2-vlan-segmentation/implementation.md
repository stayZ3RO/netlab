# Phase 2: Implementation

![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)
![Phase](https://img.shields.io/badge/Phase-2%20VLAN%20Segmentation-purple)
![Docs](https://img.shields.io/badge/Docs-Portfolio%20Ready-informational)

## Cutover Order for the First Sitting, 2026-11-15 to 2026-11-16

---

## Overview

The order was chosen so that each step could be undone from a machine that still worked. The gateway policies and the server-side listeners were in place before any device moved. One canary station moved first, the admin station moved last. Addresses below are examples (see the [overview](overview.md)).

---

## 1. Preflight (read only)

- Confirmed the gateway runs the zone-based firewall.
- Read the DNS listening mode on both resolvers: local-only, which answers only subnets the resolver has an interface on ([Pi-hole `dns.listeningMode`](https://docs.pi-hole.net/ftldns/configfile/)). Routed segments would get no answer until it changed.
- Read both subnet routers: source NAT on, and only the Servers route advertised.
- Recorded the port and current address of each device that would move.

---

## 2. Networks and Zones First

- Created six networks, one custom zone per network. The Servers network stayed alone in Internal.
- Checked the zone defaults before writing any allow: traffic between zones is blocked.

Nothing moved at this step, so nothing could break.

---

## 3. Policies

- Wrote the eight policies from the [zone matrix](overview.md#the-narrow-allows): DNS from Clients and Wi-Fi, HTTPS to the proxy, owner admin ports, VPN transport to the two routers, the temporary bridge, and the router admin blocks for Wi-Fi and Guests.
- Re-read every policy's destination list. One had been entered as a range and held eleven addresses instead of two. Fixed before any device moved.
- Addresses are typed per policy. Address reservations were set at each device's move, because a device holds one fixed address at a time.

---

## 4. DNS Listeners and Host Allow Lists

On each resolver, standby first:

1. Saved a copy of the host firewall rules.
2. Allowed 53 TCP and UDP from Clients and from Wi-Fi.
3. Changed the listening mode from local-only to all interfaces. The host firewall now does the source filtering. Pi-hole's docs warn that this mode can make an open resolver if the host is not firewalled.
4. Checked the DNS, VIP and recursive resolver services were active, and that UDP and TCP queries answered on the node address and on the VIP.

On the other servers the station would reach, added host rules for the owner stations' addresses (SSH) and for Clients (HTTPS on the proxy). Copies of the previous rules were saved on each host first.

---

## 5. Canary Station

Moved one wired workstation by changing its switch port to the Clients network, then ran the [station tests](validation.md#station-tests): address, DNS, HTTPS to the proxy, one admin port, and one port that must be blocked.

---

## 6. Remaining Wired Stations

The other two wired stations, one at a time, same tests.

During this step the remote desktop client kept showing moved machines as online with no policy for it. That was the first sign of the [subnet route bypass](lessons-learned.md#1-the-vpn-client-routed-around-the-firewall). Route acceptance was turned off on the wired stations, then the remote desktop policy and host rules were added.

---

## 7. The Wi-Fi Mesh

Moved the mesh uplink port to the untrusted Wi-Fi network, fixed the main node's address and power-cycled it. Every Wi-Fi client then took an address on that segment.

- A phone with the VPN and mobile data off: a lease on the Wi-Fi segment, public sites load, the hypervisor by name and by address does not, the router admin page does not.
- A laptop with Tailscale on: a direct path to one subnet router, a timeout to the other until its host firewall allowed UDP 41641 from Wi-Fi. The second router has no host firewall, which is how the difference showed.

---

## 8. Admin Station Last

Moved the main admin workstation to Clients.

- First hop of a trace was the Clients gateway.
- SSH to a hypervisor, the git server, a resolver and the monitoring host worked. DNS answered.
- Git over SSH on port 2222 timed out. The git service is a container and its published port is filtered in Docker's `DOCKER-USER` chain, not by the host firewall ([Docker packet filtering](https://docs.docker.com/engine/network/packet-filtering-firewalls/)). A rule for Clients above the chain's final drop fixed it. The host firewall rule for 2222, which did nothing, was removed.
- A stale host key for one server was replaced only after its new fingerprint was read from the hypervisor console.
- The temporary bridge policy was paused.

---

## Rollback

Each move was a switch port profile change, so rollback was the same change back. Host rule copies were saved before each edit. No rollback was needed.

---

## Open Items From the Sitting

- Make the `DOCKER-USER` rule persistent across reboots. Not confirmed yet.
- Delete the paused bridge policy.
- Put the host rules into code so a rebuild carries them.
