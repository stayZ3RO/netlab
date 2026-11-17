# Phase 2: Lessons Learned

![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)
![Phase](https://img.shields.io/badge/Phase-2%20VLAN%20Segmentation-purple)
![Docs](https://img.shields.io/badge/Docs-Portfolio%20Ready-informational)

## Tests That Passed for the Wrong Reason, and Other Takeaways

---

## Overview

Most checks passed on the first try. Several passed because the traffic never crossed the new firewall. The lessons below are about making tests that can fail.

---

## Key Lessons

### 1. The VPN client routed around the firewall

Tailscale on Windows and macOS accepts advertised subnet routes by default ([Tailscale CLI, `--accept-routes`](https://tailscale.com/kb/1080/cli)). The subnet routers advertise the Servers network, so stations moved to Clients still reached every server through the tunnel, and the gateway policies never saw that traffic.

Fix: turn route acceptance off on every wired station before it moves, and read it back. The roaming laptop keeps it on.

```sh
tailscale set --accept-routes=false
```

---

### 2. A tool that keeps working without its rule is a warning

The remote desktop client showed moved machines online before any policy for it existed. It broke as soon as route acceptance was off, and came back once the policy and host rules were written. A pass before the rule exists means the test is wrong.

---

### 3. The host firewall does not filter Docker-published ports

Docker routes published ports in the `nat` table, so host firewall rules in `INPUT` never see them ([Docker packet filtering](https://docs.docker.com/engine/network/packet-filtering-firewalls/)). Filtering belongs in `DOCKER-USER`, and because the destination is rewritten before that chain, a rule on the published port needs the conntrack original port ([Docker with iptables](https://docs.docker.com/engine/network/firewall-iptables/)). Example, with an example source:

```sh
sudo iptables -L DOCKER-USER -n --line-numbers
# insert above the final DROP; replace 4 with that line number
sudo iptables -I DOCKER-USER 4 -s 10.0.20.0/24 -p tcp \
  -m conntrack --ctorigdstport 2222 -j RETURN
```

A live rule does not survive a reboot; it has to go wherever that host keeps the chain.

---

### 4. A redundant pair must be configured the same

One subnet router had a host firewall and the other had none. The laptop reached one directly and the other only after a host rule was added. Without the rule Tailscale would still have worked over its relays ([Tailscale firewall ports](https://tailscale.com/kb/1082/firewall-ports)), only slower, so the difference would have stayed hidden until a failover.

---

### 5. Re-read every policy after saving it

A destination entered as a range became eleven addresses instead of two. Reading the saved policy caught it before anything moved.

---

### 6. Routed clients need the resolver to listen beyond its own subnet

Pi-hole's default listening mode answers only subnets it has an interface on ([`dns.listeningMode`](https://docs.pi-hole.net/ftldns/configfile/)). Every routed segment needs a different mode, and with it a host firewall that limits who may ask.

---

### 7. Move the admin station last

Every other move was done and checked from a station that had not moved yet. When the admin station's git push failed, the rest of the network was already known to be good, which narrowed the cause to one host.

---

## Standing Rule

Every new flow gets a named, narrow policy: one source, one destination, the exact ports. No zone-wide allow, and no reliance on a path that happens to work.
