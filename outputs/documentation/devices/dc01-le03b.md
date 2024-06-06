# dc01-le03b

## Table of Contents

- [Management](#management)
  - [Management Interfaces](#management-interfaces)
  - [Clock Settings](#clock-settings)
  - [Management API HTTP](#management-api-http)
- [Authentication](#authentication)
  - [Local Users](#local-users)
  - [AAA Authorization](#aaa-authorization)
- [Monitoring](#monitoring)
  - [TerminAttr Daemon](#terminattr-daemon)
- [LLDP](#lldp)
  - [LLDP Summary](#lldp-summary)
  - [LLDP Device Configuration](#lldp-device-configuration)
- [Spanning Tree](#spanning-tree)
  - [Spanning Tree Summary](#spanning-tree-summary)
  - [Spanning Tree Device Configuration](#spanning-tree-device-configuration)
- [Internal VLAN Allocation Policy](#internal-vlan-allocation-policy)
  - [Internal VLAN Allocation Policy Summary](#internal-vlan-allocation-policy-summary)
  - [Internal VLAN Allocation Policy Device Configuration](#internal-vlan-allocation-policy-device-configuration)
- [VLANs](#vlans)
  - [VLANs Summary](#vlans-summary)
  - [VLANs Device Configuration](#vlans-device-configuration)
- [Interfaces](#interfaces)
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Port-Channel Interfaces](#port-channel-interfaces)
  - [Loopback Interfaces](#loopback-interfaces)
  - [VLAN Interfaces](#vlan-interfaces)
  - [VXLAN Interface](#vxlan-interface)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [Virtual Router MAC Address](#virtual-router-mac-address)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [ARP](#arp)
  - [Router BGP](#router-bgp)
- [BFD](#bfd)
  - [Router BFD](#router-bfd)
- [Multicast](#multicast)
  - [IP IGMP Snooping](#ip-igmp-snooping)
- [Filters](#filters)
  - [Prefix-lists](#prefix-lists)
  - [Route-maps](#route-maps)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)

## Management

### Management Interfaces

#### Management Interfaces Summary

##### IPv4

| Management Interface | Description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management1 | oob_management | oob | default | 192.168.0.180/24 | - |

##### IPv6

| Management Interface | Description | Type | VRF | IPv6 Address | IPv6 Gateway |
| -------------------- | ----------- | ---- | --- | ------------ | ------------ |
| Management1 | oob_management | oob | default | - | - |

#### Management Interfaces Device Configuration

```eos
!
interface Management1
   description oob_management
   no shutdown
   ip address 192.168.0.180/24
```

### Clock Settings

#### Clock Timezone Settings

Clock Timezone is set to **CET**.

#### Clock Device Configuration

```eos
!
clock timezone CET
```

### Management API HTTP

#### Management API HTTP Summary

| HTTP | HTTPS | Default Services |
| ---- | ----- | ---------------- |
| False | True | - |

#### Management API VRF Access

| VRF Name | IPv4 ACL | IPv6 ACL |
| -------- | -------- | -------- |
| default | - | - |

#### Management API HTTP Device Configuration

```eos
!
management api http-commands
   protocol https
   no shutdown
   !
   vrf default
      no shutdown
```

## Authentication

### Local Users

#### Local Users Summary

| User | Privilege | Role | Disabled | Shell |
| ---- | --------- | ---- | -------- | ----- |
| arista | 15 | network-admin | False | - |
| cvpadmin | 15 | network-admin | False | - |

#### Local Users Device Configuration

```eos
!
username arista privilege 15 role network-admin secret sha512 <removed>
username cvpadmin privilege 15 role network-admin secret sha512 <removed>
```

### AAA Authorization

#### AAA Authorization Summary

| Type | User Stores |
| ---- | ----------- |
| Exec | local |

Authorization for configuration commands is disabled.

#### AAA Authorization Device Configuration

```eos
aaa authorization exec default local
!
```

## Monitoring

### TerminAttr Daemon

#### TerminAttr Daemon Summary

| CV Compression | CloudVision Servers | VRF | Authentication | Smash Excludes | Ingest Exclude | Bypass AAA |
| -------------- | ------------------- | --- | -------------- | -------------- | -------------- | ---------- |
| gzip | 192.168.0.5:9910 | default | token,/tmp/token | ale,flexCounter,hardware,kni,pulse,strata | /Sysdb/cell/1/agent,/Sysdb/cell/2/agent | False |

#### TerminAttr Daemon Device Configuration

```eos
!
daemon TerminAttr
   exec /usr/bin/TerminAttr -cvaddr=192.168.0.5:9910 -cvauth=token,/tmp/token -cvvrf=default -smashexcludes=ale,flexCounter,hardware,kni,pulse,strata -ingestexclude=/Sysdb/cell/1/agent,/Sysdb/cell/2/agent -taillogs
   no shutdown
```

## LLDP

### LLDP Summary

#### LLDP Global Settings

| Enabled | Management Address | Management VRF | Timer | Hold-Time | Re-initialization Timer | Drop Received Tagged Packets |
| ------- | ------------------ | -------------- | ----- | --------- | ----------------------- | ---------------------------- |
| True | all | default | 30 | 120 | 2 | - |

#### LLDP Interface Settings

| Interface | Transmit | Receive |
| --------- | -------- | ------- |

### LLDP Device Configuration

```eos
!
lldp management-address all
lldp management-address vrf default
```

## Spanning Tree

### Spanning Tree Summary

STP mode: **mstp**

#### MSTP Instance and Priority

| Instance(s) | Priority |
| -------- | -------- |
| 0 | 4096 |

### Spanning Tree Device Configuration

```eos
!
spanning-tree mode mstp
spanning-tree mst 0 priority 4096
```

## Internal VLAN Allocation Policy

### Internal VLAN Allocation Policy Summary

| Policy Allocation | Range Beginning | Range Ending |
| ------------------| --------------- | ------------ |
| ascending | 1006 | 1199 |

### Internal VLAN Allocation Policy Device Configuration

```eos
!
vlan internal order ascending range 1006 1199
```

## VLANs

### VLANs Summary

| VLAN ID | Name | Trunk Groups |
| ------- | ---- | ------------ |
| 40 | ACME_GENERAL_40 | - |
| 41 | ACME_GENERAL_FW_41 | - |
| 44 | ACME_GENERAL_44 | - |
| 45 | ACME_GENERAL_FW_45 | - |
| 50 | ACME_DT_V50 | - |
| 51 | ACME_DT_FW_51 | - |
| 54 | ACME_DT_V54 | - |
| 55 | ACME_DT_FW_55 | - |

### VLANs Device Configuration

```eos
!
vlan 40
   name ACME_GENERAL_40
!
vlan 41
   name ACME_GENERAL_FW_41
!
vlan 44
   name ACME_GENERAL_44
!
vlan 45
   name ACME_GENERAL_FW_45
!
vlan 50
   name ACME_DT_V50
!
vlan 51
   name ACME_DT_FW_51
!
vlan 54
   name ACME_DT_V54
!
vlan 55
   name ACME_DT_FW_55
```

## Interfaces

### Ethernet Interfaces

#### Ethernet Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |
| Ethernet3 | server11_Ethernet2 | *access | *40 | *- | *- | 3 |

*Inherited from Port-Channel Interface

##### IPv4

| Interface | Description | Type | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | -----| ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet1 | P2P_LINK_TO_DC01-SP01_Ethernet6 | routed | - | 10.0.9.57/31 | default | 1500 | False | - | - |
| Ethernet2 | P2P_LINK_TO_DC01-SP02_Ethernet6 | routed | - | 10.0.9.59/31 | default | 1500 | False | - | - |

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description P2P_LINK_TO_DC01-SP01_Ethernet6
   no shutdown
   mtu 1500
   no switchport
   ip address 10.0.9.57/31
!
interface Ethernet2
   description P2P_LINK_TO_DC01-SP02_Ethernet6
   no shutdown
   mtu 1500
   no switchport
   ip address 10.0.9.59/31
!
interface Ethernet3
   description server11_Ethernet2
   no shutdown
   channel-group 3 mode active
```

### Port-Channel Interfaces

#### Port-Channel Interfaces Summary

##### L2

| Interface | Description | Type | Mode | VLANs | Native VLAN | Trunk Group | LACP Fallback Timeout | LACP Fallback Mode | MLAG ID | EVPN ESI |
| --------- | ----------- | ---- | ---- | ----- | ----------- | ------------| --------------------- | ------------------ | ------- | -------- |
| Port-Channel3 | server11_LINK_TO_SRV18 | switched | access | 40 | - | - | - | - | - | 0000:0000:0303:0202:0101 |

##### EVPN Multihoming

####### EVPN Multihoming Summary

| Interface | Ethernet Segment Identifier | Multihoming Redundancy Mode | Route Target |
| --------- | --------------------------- | --------------------------- | ------------ |
| Port-Channel3 | 0000:0000:0303:0202:0101 | all-active | 03:03:02:02:01:01 |

#### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel3
   description server11_LINK_TO_SRV18
   no shutdown
   switchport
   switchport access vlan 40
   evpn ethernet-segment
      identifier 0000:0000:0303:0202:0101
      route-target import 03:03:02:02:01:01
   lacp system-id 0303.0202.0101
   spanning-tree portfast
```

### Loopback Interfaces

#### Loopback Interfaces Summary

##### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | EVPN_Overlay_Peering | default | 10.0.2.12/32 |
| Loopback1 | VTEP_VXLAN_Tunnel_Source | default | 10.0.3.12/32 |

##### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | EVPN_Overlay_Peering | default | - |
| Loopback1 | VTEP_VXLAN_Tunnel_Source | default | - |

#### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description EVPN_Overlay_Peering
   no shutdown
   ip address 10.0.2.12/32
!
interface Loopback1
   description VTEP_VXLAN_Tunnel_Source
   no shutdown
   ip address 10.0.3.12/32
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan40 | ACME_GENERAL_40 | ACME-GENERAL | - | False |
| Vlan44 | ACME_GENERAL_44 | ACME-GENERAL | - | False |
| Vlan50 | ACME_DT_V50 | ACME-DT | - | False |
| Vlan54 | ACME_DT_V54 | ACME-DT | - | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | VRRP | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ---- | ------ | ------- |
| Vlan40 |  ACME-GENERAL  |  -  |  10.4.40.1/24  |  -  |  -  |  -  |  -  |
| Vlan44 |  ACME-GENERAL  |  -  |  10.4.44.1/24  |  -  |  -  |  -  |  -  |
| Vlan50 |  ACME-DT  |  -  |  10.5.50.1/24  |  -  |  -  |  -  |  -  |
| Vlan54 |  ACME-DT  |  -  |  10.5.54.1/24  |  -  |  -  |  -  |  -  |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan40
   description ACME_GENERAL_40
   no shutdown
   vrf ACME-GENERAL
   ip address virtual 10.4.40.1/24
!
interface Vlan44
   description ACME_GENERAL_44
   no shutdown
   vrf ACME-GENERAL
   ip address virtual 10.4.44.1/24
!
interface Vlan50
   description ACME_DT_V50
   no shutdown
   vrf ACME-DT
   ip address virtual 10.5.50.1/24
!
interface Vlan54
   description ACME_DT_V54
   no shutdown
   vrf ACME-DT
   ip address virtual 10.5.54.1/24
```

### VXLAN Interface

#### VXLAN Interface Summary

| Setting | Value |
| ------- | ----- |
| Source Interface | Loopback1 |
| UDP port | 4789 |

##### VLAN to VNI, Flood List and Multicast Group Mappings

| VLAN | VNI | Flood List | Multicast Group |
| ---- | --- | ---------- | --------------- |
| 40 | 10040 | - | - |
| 41 | 10041 | - | - |
| 44 | 10044 | - | - |
| 45 | 10045 | - | - |
| 50 | 10050 | - | - |
| 51 | 10051 | - | - |
| 54 | 10054 | - | - |
| 55 | 10055 | - | - |

##### VRF to VNI and Multicast Group Mappings

| VRF | VNI | Multicast Group |
| ---- | --- | --------------- |
| ACME-DT | 4405 | - |
| ACME-GENERAL | 4401 | - |

#### VXLAN Interface Device Configuration

```eos
!
interface Vxlan1
   description dc01-le03b_VTEP
   vxlan source-interface Loopback1
   vxlan udp-port 4789
   vxlan vlan 40 vni 10040
   vxlan vlan 41 vni 10041
   vxlan vlan 44 vni 10044
   vxlan vlan 45 vni 10045
   vxlan vlan 50 vni 10050
   vxlan vlan 51 vni 10051
   vxlan vlan 54 vni 10054
   vxlan vlan 55 vni 10055
   vxlan vrf ACME-DT vni 4405
   vxlan vrf ACME-GENERAL vni 4401
```

## Routing

### Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

### Virtual Router MAC Address

#### Virtual Router MAC Address Summary

Virtual Router MAC Address: 00:1c:73:00:00:99

#### Virtual Router MAC Address Device Configuration

```eos
!
ip virtual-router mac-address 00:1c:73:00:00:99
```

### IP Routing

#### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | True |
| ACME-DT | True |
| ACME-GENERAL | True |

#### IP Routing Device Configuration

```eos
!
ip routing
ip routing vrf ACME-DT
ip routing vrf ACME-GENERAL
```

### IPv6 Routing

#### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| ACME-DT | false |
| ACME-GENERAL | false |
| default | false |

### ARP

Global ARP timeout: 275

#### ARP Device Configuration

```eos
!
arp aging timeout default 275
```

### Router BGP

ASN Notation: asplain

#### Router BGP Summary

| BGP AS | Router ID |
| ------ | --------- |
| 65524 | 10.0.2.12 |

| BGP Tuning |
| ---------- |
| no bgp default ipv4-unicast |
| distance bgp 20 200 200 |
| maximum-paths 4 ecmp 4 |

#### Router BGP Peer Groups

##### EVPN-OVERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | evpn |
| Source | Loopback0 |
| Ebgp multihop | 4 |
| Send community | all |
| Maximum routes | 0 (no limit) |

##### IPv4-UNDERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | ipv4 |
| Send community | all |
| Maximum routes | 12000 |

#### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client | Passive | TTL Max Hops |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- | --------------------- | ---------------------- | ------- | ------------ |
| 10.0.2.1 | 65520 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - | - | - |
| 10.0.2.2 | 65520 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - | - | - |
| 10.0.9.56 | 65520 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 10.0.9.58 | 65520 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |

#### Router BGP EVPN Address Family

##### EVPN Peer Groups

| Peer Group | Activate | Encapsulation |
| ---------- | -------- | ------------- |
| EVPN-OVERLAY-PEERS | True | default |

#### Router BGP VLANs

| VLAN | Route-Distinguisher | Both Route-Target | Import Route Target | Export Route-Target | Redistribute |
| ---- | ------------------- | ----------------- | ------------------- | ------------------- | ------------ |
| 40 | 65000:10040 | 10040:10040 | - | - | learned |
| 41 | 65000:10041 | 10041:10041 | - | - | learned |
| 44 | 65000:10044 | 10044:10044 | - | - | learned |
| 45 | 65000:10045 | 10045:10045 | - | - | learned |
| 50 | 65000:10050 | 10050:10050 | - | - | learned |
| 51 | 65000:10051 | 10051:10051 | - | - | learned |
| 54 | 65000:10054 | 10054:10054 | - | - | learned |
| 55 | 65000:10055 | 10055:10055 | - | - | learned |

#### Router BGP VRFs

| VRF | Route-Distinguisher | Redistribute |
| --- | ------------------- | ------------ |
| ACME-DT | 10.0.3.12:4405 | connected |
| ACME-GENERAL | 10.0.3.12:4401 | connected |

#### Router BGP Device Configuration

```eos
!
router bgp 65524
   router-id 10.0.2.12
   distance bgp 20 200 200
   maximum-paths 4 ecmp 4
   no bgp default ipv4-unicast
   neighbor EVPN-OVERLAY-PEERS peer group
   neighbor EVPN-OVERLAY-PEERS update-source Loopback0
   neighbor EVPN-OVERLAY-PEERS ebgp-multihop 4
   neighbor EVPN-OVERLAY-PEERS password 7 <removed>
   neighbor EVPN-OVERLAY-PEERS send-community
   neighbor EVPN-OVERLAY-PEERS maximum-routes 0
   neighbor IPv4-UNDERLAY-PEERS peer group
   neighbor IPv4-UNDERLAY-PEERS password 7 <removed>
   neighbor IPv4-UNDERLAY-PEERS send-community
   neighbor IPv4-UNDERLAY-PEERS maximum-routes 12000
   neighbor 10.0.2.1 peer group EVPN-OVERLAY-PEERS
   neighbor 10.0.2.1 remote-as 65520
   neighbor 10.0.2.1 description dc01-sp01
   neighbor 10.0.2.1 route-map RM-EVPN-FILTER-AS65520 out
   neighbor 10.0.2.2 peer group EVPN-OVERLAY-PEERS
   neighbor 10.0.2.2 remote-as 65520
   neighbor 10.0.2.2 description dc01-sp02
   neighbor 10.0.2.2 route-map RM-EVPN-FILTER-AS65520 out
   neighbor 10.0.9.56 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.0.9.56 remote-as 65520
   neighbor 10.0.9.56 description dc01-sp01_Ethernet6
   neighbor 10.0.9.58 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.0.9.58 remote-as 65520
   neighbor 10.0.9.58 description dc01-sp02_Ethernet6
   redistribute connected route-map RM-CONN-2-BGP
   !
   vlan 40
      rd 65000:10040
      route-target both 10040:10040
      redistribute learned
   !
   vlan 41
      rd 65000:10041
      route-target both 10041:10041
      redistribute learned
   !
   vlan 44
      rd 65000:10044
      route-target both 10044:10044
      redistribute learned
   !
   vlan 45
      rd 65000:10045
      route-target both 10045:10045
      redistribute learned
   !
   vlan 50
      rd 65000:10050
      route-target both 10050:10050
      redistribute learned
   !
   vlan 51
      rd 65000:10051
      route-target both 10051:10051
      redistribute learned
   !
   vlan 54
      rd 65000:10054
      route-target both 10054:10054
      redistribute learned
   !
   vlan 55
      rd 65000:10055
      route-target both 10055:10055
      redistribute learned
   !
   address-family evpn
      neighbor EVPN-OVERLAY-PEERS activate
   !
   address-family rt-membership
      neighbor EVPN-OVERLAY-PEERS activate
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-PEERS activate
      neighbor IPv4-UNDERLAY-PEERS activate
   !
   vrf ACME-DT
      rd 10.0.3.12:4405
      route-target import evpn 4405:4405
      route-target export evpn 4405:4405
      router-id 10.0.2.12
      redistribute connected
   !
   vrf ACME-GENERAL
      rd 10.0.3.12:4401
      route-target import evpn 4401:4401
      route-target export evpn 4401:4401
      router-id 10.0.2.12
      redistribute connected
```

## BFD

### Router BFD

#### Router BFD Multihop Summary

| Interval | Minimum RX | Multiplier |
| -------- | ---------- | ---------- |
| 1200 | 1200 | 3 |

#### Router BFD Device Configuration

```eos
!
router bfd
   multihop interval 1200 min-rx 1200 multiplier 3
```

## Multicast

### IP IGMP Snooping

#### IP IGMP Snooping Summary

| IGMP Snooping | Fast Leave | Interface Restart Query | Proxy | Restart Query Interval | Robustness Variable |
| ------------- | ---------- | ----------------------- | ----- | ---------------------- | ------------------- |
| Disabled | - | - | - | - | - |

#### IP IGMP Snooping Device Configuration

```eos
!
no ip igmp snooping
```

## Filters

### Prefix-lists

#### Prefix-lists Summary

##### PL-LOOPBACKS-EVPN-OVERLAY

| Sequence | Action |
| -------- | ------ |
| 10 | permit 10.0.2.0/24 eq 32 |
| 20 | permit 10.0.3.0/24 eq 32 |

#### Prefix-lists Device Configuration

```eos
!
ip prefix-list PL-LOOPBACKS-EVPN-OVERLAY
   seq 10 permit 10.0.2.0/24 eq 32
   seq 20 permit 10.0.3.0/24 eq 32
```

### Route-maps

#### Route-maps Summary

##### RM-CONN-2-BGP

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY | - | - | - |

##### RM-EVPN-FILTER-AS65520

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | deny | as 65520 | - | - | - |
| 20 | permit | - | - | - | - |

#### Route-maps Device Configuration

```eos
!
route-map RM-CONN-2-BGP permit 10
   match ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY
!
route-map RM-EVPN-FILTER-AS65520 deny 10
   match as 65520
!
route-map RM-EVPN-FILTER-AS65520 permit 20
```

## VRF Instances

### VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |
| ACME-DT | enabled |
| ACME-GENERAL | enabled |

### VRF Instances Device Configuration

```eos
!
vrf instance ACME-DT
!
vrf instance ACME-GENERAL
```
