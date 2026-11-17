# Phase 2: Validation

![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)
![Phase](https://img.shields.io/badge/Phase-2%20VLAN%20Segmentation-purple)
![Docs](https://img.shields.io/badge/Docs-Portfolio%20Ready-informational)

## Tests, What Counts as Proof, and Results

---

## What Counts as Proof

A segmentation test proves something only if it would fail when the firewall is not in the path.

| Test | Counts as proof when | Does not count when |
|---|---|---|
| Blocked port | The connection **times out** from the moved device | It is refused (the packet reached the host) or it was tried before routes were checked |
| Allowed flow | It works **and** the first hop of a trace is the segment's gateway | The first hop is a VPN address, or the route goes over the tunnel interface |
| Host rule | The chain that actually filters the port has been read | Only the host firewall front end was checked (containers publish around it) |
| Redundant pair | Each member was tested on its own | Only "one of them works" |

Route check on a station (example address):

```sh
route -n get 10.0.10.5          # macOS: "interface:" must be the wired one
ip route get 10.0.10.5          # Linux: "dev" must be the wired one
traceroute -n -m 1 10.0.10.5    # first hop must be 10.0.20.1, the Clients gateway
```

On Windows: `tracert -d -h 1 10.0.10.5`.

---

## Station Tests

| Test | From | Result |
|---|---|---|
| Address on the new segment | Each wired station | ✅ Passed |
| DNS answers | Each wired station | ✅ Passed |
| HTTPS to the reverse proxy | Each wired station | ✅ Passed |
| Prometheus port, must be blocked | Each wired station | ✅ Timed out |
| Hypervisor console | Owner station | ✅ Reachable |
| Core traffic leaves over the wired interface, not the tunnel | Two stations, after route acceptance was turned off | ✅ Passed |
| First hop is the Clients gateway | Admin station | ✅ Passed |
| SSH to a hypervisor, git server, resolver and monitoring host | Admin station | ✅ Passed |
| Git over SSH, port 2222 | Admin station | ✅ Passed after the `DOCKER-USER` rule |
| Remote desktop | Two stations, route acceptance off | ✅ Passed after policy 6 and the host rules |

The checks on the first three stations ran before route acceptance was turned off. Their blocked-port timeouts still prove enforcement. Their "reachable" results could have used the tunnel, so they are not counted as proof.

---

## Wi-Fi Tests

| Test | From | Result |
|---|---|---|
| Lease on the Wi-Fi segment | Phone, VPN and mobile data off | ✅ Passed |
| Public sites load | Same phone | ✅ Passed |
| Hypervisor by name and by address, must fail | Same phone | ✅ Did not load |
| Router admin page, must fail | Same phone | ✅ Did not load |
| Direct path to each subnet router | Laptop, Tailscale on | ✅ Both, after the host rule on one router |
| Hypervisor, remote desktop, must fail | Laptop, Tailscale off | ✅ Did not load; remote desktop shows machines offline |

---

## Service Health

| Test | Result |
|---|---|
| Prometheus count of up targets after the sitting | ✅ Same as before the sitting |
| DNS on node addresses and on the VIP, UDP and TCP | ✅ Passed |

---

## Not Tested Yet

- Anything from Guests, Lab services, CI or Agents. They are empty.
- DNS failover with clients on the new segments.
- Each subnet router alone, with the other one off.
- Persistence of the `DOCKER-USER` rule across a reboot.
