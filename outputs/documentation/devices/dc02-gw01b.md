# dc02-gw01b

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
- [MLAG](#mlag)
  - [MLAG Summary](#mlag-summary)
  - [MLAG Device Configuration](#mlag-device-configuration)
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
| Management1 | oob_management | oob | default | 192.168.0.196/24 | - |

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
   ip address 192.168.0.196/24
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

## MLAG

### MLAG Summary

| Domain-id | Local-interface | Peer-address | Peer-link |
| --------- | --------------- | ------------ | --------- |
| dc02-gw01 | Vlan4094 | 10.0.11.16 | Port-Channel31 |

Dual primary detection is disabled.

### MLAG Device Configuration

```eos
!
mlag configuration
   domain-id dc02-gw01
   local-interface Vlan4094
   peer-address 10.0.11.16
   peer-link Port-Channel31
   reload-delay mlag 300
   reload-delay non-mlag 330
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

#### Global Spanning-Tree Settings

- Spanning Tree disabled for VLANs: **4093-4094**

### Spanning Tree Device Configuration

```eos
!
spanning-tree mode mstp
no spanning-tree vlan-id 4093-4094
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
| 42 | ACME_GENERAL_42 | - |
| 43 | ACME_GENERAL_FW_43 | - |
| 44 | ACME_GENERAL_EXT_44 | - |
| 45 | ACME_GENERAL_FW_45 | - |
| 49 | ACME_GENERAL_49 | - |
| 52 | ACME_DT_V50 | - |
| 53 | ACME_DT_FW_53 | - |
| 54 | ACME_DT_V54 | - |
| 55 | ACME_DT_FW_55 | - |
| 204 | ACME_GENERAL_FW_VLANS | - |
| 205 | ACME_DT_FW_VLANS | - |
| 206 | ACME_GENERAL_FUSION | - |
| 207 | ACME_DT_FUSION | - |
| 208 | ACME_GENERAL_FW_VLANS_EXTENDED | - |
| 209 | ACME_DT_FW_VLANS_EXT | - |
| 210 | ACME_GENERAL_FUSION_EXTENDED | - |
| 211 | ACME_DT_FUSION_EXT | - |
| 4001 | MLAG_iBGP_ACME-GENERAL | LEAF_PEER_L3 |
| 4005 | MLAG_iBGP_ACME-DT | LEAF_PEER_L3 |
| 4093 | LEAF_PEER_L3 | LEAF_PEER_L3 |
| 4094 | MLAG_PEER | MLAG |

### VLANs Device Configuration

```eos
!
vlan 42
   name ACME_GENERAL_42
!
vlan 43
   name ACME_GENERAL_FW_43
!
vlan 44
   name ACME_GENERAL_EXT_44
!
vlan 45
   name ACME_GENERAL_FW_45
!
vlan 49
   name ACME_GENERAL_49
!
vlan 52
   name ACME_DT_V50
!
vlan 53
   name ACME_DT_FW_53
!
vlan 54
   name ACME_DT_V54
!
vlan 55
   name ACME_DT_FW_55
!
vlan 204
   name ACME_GENERAL_FW_VLANS
!
vlan 205
   name ACME_DT_FW_VLANS
!
vlan 206
   name ACME_GENERAL_FUSION
!
vlan 207
   name ACME_DT_FUSION
!
vlan 208
   name ACME_GENERAL_FW_VLANS_EXTENDED
!
vlan 209
   name ACME_DT_FW_VLANS_EXT
!
vlan 210
   name ACME_GENERAL_FUSION_EXTENDED
!
vlan 211
   name ACME_DT_FUSION_EXT
!
vlan 4001
   name MLAG_iBGP_ACME-GENERAL
   trunk group LEAF_PEER_L3
!
vlan 4005
   name MLAG_iBGP_ACME-DT
   trunk group LEAF_PEER_L3
!
vlan 4093
   name LEAF_PEER_L3
   trunk group LEAF_PEER_L3
!
vlan 4094
   name MLAG_PEER
   trunk group MLAG
```

## Interfaces

### Ethernet Interfaces

#### Ethernet Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |
| Ethernet31 | MLAG_PEER_dc02-gw01a_Ethernet31 | *trunk | *- | *- | *['LEAF_PEER_L3', 'MLAG'] | 31 |
| Ethernet32 | MLAG_PEER_dc02-gw01a_Ethernet32 | *trunk | *- | *- | *['LEAF_PEER_L3', 'MLAG'] | 31 |

*Inherited from Port-Channel Interface

##### IPv4

| Interface | Description | Type | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | -----| ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet1 | P2P_LINK_TO_DC02-SP01_Ethernet12 | routed | - | 10.0.10.73/31 | default | 1500 | False | - | - |
| Ethernet2 | P2P_LINK_TO_DC02-SP02_Ethernet12 | routed | - | 10.0.10.75/31 | default | 1500 | False | - | - |
| Ethernet26 | P2P_LINK_TO_dc01-gw01b_Ethernet26 | routed | - | 10.0.0.3/31 | default | 1500 | False | - | - |

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description P2P_LINK_TO_DC02-SP01_Ethernet12
   no shutdown
   mtu 1500
   no switchport
   ip address 10.0.10.73/31
!
interface Ethernet2
   description P2P_LINK_TO_DC02-SP02_Ethernet12
   no shutdown
   mtu 1500
   no switchport
   ip address 10.0.10.75/31
!
interface Ethernet26
   description P2P_LINK_TO_dc01-gw01b_Ethernet26
   no shutdown
   mtu 1500
   no switchport
   ip address 10.0.0.3/31
!
interface Ethernet31
   description MLAG_PEER_dc02-gw01a_Ethernet31
   no shutdown
   channel-group 31 mode active
!
interface Ethernet32
   description MLAG_PEER_dc02-gw01a_Ethernet32
   no shutdown
   channel-group 31 mode active
```

### Port-Channel Interfaces

#### Port-Channel Interfaces Summary

##### L2

| Interface | Description | Type | Mode | VLANs | Native VLAN | Trunk Group | LACP Fallback Timeout | LACP Fallback Mode | MLAG ID | EVPN ESI |
| --------- | ----------- | ---- | ---- | ----- | ----------- | ------------| --------------------- | ------------------ | ------- | -------- |
| Port-Channel31 | MLAG_PEER_dc02-gw01a_Po31 | switched | trunk | - | - | ['LEAF_PEER_L3', 'MLAG'] | - | - | - | - |

#### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel31
   description MLAG_PEER_dc02-gw01a_Po31
   no shutdown
   switchport
   switchport mode trunk
   switchport trunk group LEAF_PEER_L3
   switchport trunk group MLAG
```

### Loopback Interfaces

#### Loopback Interfaces Summary

##### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | EVPN_Overlay_Peering | default | 10.0.4.14/32 |
| Loopback1 | VTEP_VXLAN_Tunnel_Source | default | 10.0.5.13/32 |

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
   ip address 10.0.4.14/32
!
interface Loopback1
   description VTEP_VXLAN_Tunnel_Source
   no shutdown
   ip address 10.0.5.13/32
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan42 | ACME_GENERAL_42 | ACME-GENERAL | - | False |
| Vlan44 | ACME_GENERAL_EXT_44 | ACME-GENERAL | - | False |
| Vlan49 | ACME_GENERAL_49 | ACME-GENERAL | - | False |
| Vlan52 | ACME_DT_V50 | ACME-DT | - | False |
| Vlan54 | ACME_DT_V54 | ACME-DT | - | False |
| Vlan204 | ACME_GENERAL_FW_VLANS | ACME-GENERAL | - | False |
| Vlan205 | ACME_DT_FW_VLANS | ACME-DT | - | False |
| Vlan206 | ACME_GENERAL_FUSION | ACME-GENERAL | - | False |
| Vlan207 | ACME_DT_FUSION | ACME-DT | - | False |
| Vlan208 | ACME_GENERAL_FW_VLANS_EXTENDED | ACME-GENERAL | - | False |
| Vlan209 | ACME_DT_FW_VLANS_EXT | ACME-DT | - | False |
| Vlan210 | ACME_GENERAL_FUSION_EXTENDED | ACME-GENERAL | - | False |
| Vlan211 | ACME_DT_FUSION_EXT | ACME-DT | - | False |
| Vlan4001 | MLAG_PEER_L3_iBGP: vrf ACME-GENERAL | ACME-GENERAL | 1500 | False |
| Vlan4005 | MLAG_PEER_L3_iBGP: vrf ACME-DT | ACME-DT | 1500 | False |
| Vlan4093 | MLAG_PEER_L3_PEERING | default | 1500 | False |
| Vlan4094 | MLAG_PEER | default | 1500 | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | VRRP | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ---- | ------ | ------- |
| Vlan42 |  ACME-GENERAL  |  -  |  10.4.42.1/24  |  -  |  -  |  -  |  -  |
| Vlan44 |  ACME-GENERAL  |  -  |  10.4.44.1/24  |  -  |  -  |  -  |  -  |
| Vlan49 |  ACME-GENERAL  |  -  |  10.4.49.1/24  |  -  |  -  |  -  |  -  |
| Vlan52 |  ACME-DT  |  -  |  10.5.52.1/24  |  -  |  -  |  -  |  -  |
| Vlan54 |  ACME-DT  |  -  |  10.5.54.1/24  |  -  |  -  |  -  |  -  |
| Vlan204 |  ACME-GENERAL  |  -  |  -  |  -  |  -  |  -  |  -  |
| Vlan205 |  ACME-DT  |  -  |  -  |  -  |  -  |  -  |  -  |
| Vlan206 |  ACME-GENERAL  |  -  |  -  |  -  |  -  |  -  |  -  |
| Vlan207 |  ACME-DT  |  -  |  -  |  -  |  -  |  -  |  -  |
| Vlan208 |  ACME-GENERAL  |  -  |  -  |  -  |  -  |  -  |  -  |
| Vlan209 |  ACME-DT  |  -  |  -  |  -  |  -  |  -  |  -  |
| Vlan210 |  ACME-GENERAL  |  -  |  -  |  -  |  -  |  -  |  -  |
| Vlan211 |  ACME-DT  |  -  |  -  |  -  |  -  |  -  |  -  |
| Vlan4001 |  ACME-GENERAL  |  10.0.12.17/31  |  -  |  -  |  -  |  -  |  -  |
| Vlan4005 |  ACME-DT  |  10.0.12.17/31  |  -  |  -  |  -  |  -  |  -  |
| Vlan4093 |  default  |  10.0.12.17/31  |  -  |  -  |  -  |  -  |  -  |
| Vlan4094 |  default  |  10.0.11.17/31  |  -  |  -  |  -  |  -  |  -  |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan42
   description ACME_GENERAL_42
   no shutdown
   vrf ACME-GENERAL
   ip address virtual 10.4.42.1/24
!
interface Vlan44
   description ACME_GENERAL_EXT_44
   no shutdown
   vrf ACME-GENERAL
   ip address virtual 10.4.44.1/24
!
interface Vlan49
   description ACME_GENERAL_49
   no shutdown
   vrf ACME-GENERAL
   ip address virtual 10.4.49.1/24
!
interface Vlan52
   description ACME_DT_V50
   no shutdown
   vrf ACME-DT
   ip address virtual 10.5.52.1/24
!
interface Vlan54
   description ACME_DT_V54
   no shutdown
   vrf ACME-DT
   ip address virtual 10.5.54.1/24
!
interface Vlan204
   description ACME_GENERAL_FW_VLANS
   no shutdown
   vrf ACME-GENERAL
!
interface Vlan205
   description ACME_DT_FW_VLANS
   no shutdown
   vrf ACME-DT
!
interface Vlan206
   description ACME_GENERAL_FUSION
   no shutdown
   vrf ACME-GENERAL
!
interface Vlan207
   description ACME_DT_FUSION
   no shutdown
   vrf ACME-DT
!
interface Vlan208
   description ACME_GENERAL_FW_VLANS_EXTENDED
   no shutdown
   vrf ACME-GENERAL
!
interface Vlan209
   description ACME_DT_FW_VLANS_EXT
   no shutdown
   vrf ACME-DT
!
interface Vlan210
   description ACME_GENERAL_FUSION_EXTENDED
   no shutdown
   vrf ACME-GENERAL
!
interface Vlan211
   description ACME_DT_FUSION_EXT
   no shutdown
   vrf ACME-DT
!
interface Vlan4001
   description MLAG_PEER_L3_iBGP: vrf ACME-GENERAL
   no shutdown
   mtu 1500
   vrf ACME-GENERAL
   ip address 10.0.12.17/31
!
interface Vlan4005
   description MLAG_PEER_L3_iBGP: vrf ACME-DT
   no shutdown
   mtu 1500
   vrf ACME-DT
   ip address 10.0.12.17/31
!
interface Vlan4093
   description MLAG_PEER_L3_PEERING
   no shutdown
   mtu 1500
   ip address 10.0.12.17/31
!
interface Vlan4094
   description MLAG_PEER
   no shutdown
   mtu 1500
   no autostate
   ip address 10.0.11.17/31
```

### VXLAN Interface

#### VXLAN Interface Summary

| Setting | Value |
| ------- | ----- |
| Source Interface | Loopback1 |
| UDP port | 4789 |
| EVPN MLAG Shared Router MAC | mlag-system-id |

##### VLAN to VNI, Flood List and Multicast Group Mappings

| VLAN | VNI | Flood List | Multicast Group |
| ---- | --- | ---------- | --------------- |
| 42 | 10042 | - | - |
| 43 | 10043 | - | - |
| 44 | 10044 | - | - |
| 45 | 10045 | - | - |
| 49 | 10049 | - | - |
| 52 | 10052 | - | - |
| 53 | 10053 | - | - |
| 54 | 10054 | - | - |
| 55 | 10055 | - | - |
| 204 | 10204 | - | - |
| 205 | 10205 | - | - |
| 206 | 10206 | - | - |
| 207 | 10207 | - | - |
| 208 | 10208 | - | - |
| 209 | 10209 | - | - |
| 210 | 10210 | - | - |
| 211 | 10211 | - | - |

##### VRF to VNI and Multicast Group Mappings

| VRF | VNI | Multicast Group |
| ---- | --- | --------------- |
| ACME-DT | 4405 | - |
| ACME-GENERAL | 4401 | - |

#### VXLAN Interface Device Configuration

```eos
!
interface Vxlan1
   description dc02-gw01b_VTEP
   vxlan source-interface Loopback1
   vxlan virtual-router encapsulation mac-address mlag-system-id
   vxlan udp-port 4789
   vxlan vlan 42 vni 10042
   vxlan vlan 43 vni 10043
   vxlan vlan 44 vni 10044
   vxlan vlan 45 vni 10045
   vxlan vlan 49 vni 10049
   vxlan vlan 52 vni 10052
   vxlan vlan 53 vni 10053
   vxlan vlan 54 vni 10054
   vxlan vlan 55 vni 10055
   vxlan vlan 204 vni 10204
   vxlan vlan 205 vni 10205
   vxlan vlan 206 vni 10206
   vxlan vlan 207 vni 10207
   vxlan vlan 208 vni 10208
   vxlan vlan 209 vni 10209
   vxlan vlan 210 vni 10210
   vxlan vlan 211 vni 10211
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
| 65599 | 10.0.4.14 |

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
| Next-hop unchanged | True |
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

##### MLAG-IPv4-UNDERLAY-PEER

| Settings | Value |
| -------- | ----- |
| Address Family | ipv4 |
| Remote AS | 65599 |
| Next-hop self | True |
| Send community | all |
| Maximum routes | 12000 |

#### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client | Passive | TTL Max Hops |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- | --------------------- | ---------------------- | ------- | ------------ |
| 10.0.0.2 | 65559 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 10.0.2.16 | 65559 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - | - | - |
| 10.0.4.1 | 65560 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - | - | - |
| 10.0.4.2 | 65560 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - | - | - |
| 10.0.10.72 | 65560 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 10.0.10.74 | 65560 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 10.0.12.16 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | default | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - | - |
| 10.0.12.16 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | ACME-DT | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - |
| 10.0.12.16 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | ACME-GENERAL | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - |

#### Router BGP EVPN Address Family

##### EVPN Peer Groups

| Peer Group | Activate | Encapsulation |
| ---------- | -------- | ------------- |
| EVPN-OVERLAY-PEERS | True | default |

#### Router BGP VLANs

| VLAN | Route-Distinguisher | Both Route-Target | Import Route Target | Export Route-Target | Redistribute |
| ---- | ------------------- | ----------------- | ------------------- | ------------------- | ------------ |
| 42 | 65000:10042 | 10042:10042 | - | - | learned |
| 43 | 65000:10043 | 10043:10043 | - | - | learned |
| 44 | 65000:10044 | 10044:10044 | - | - | learned |
| 45 | 65000:10045 | 10045:10045 | - | - | learned |
| 49 | 65000:10049 | 10049:10049 | - | - | learned |
| 52 | 65000:10052 | 10052:10052 | - | - | learned |
| 53 | 65000:10053 | 10053:10053 | - | - | learned |
| 54 | 65000:10054 | 10054:10054 | - | - | learned |
| 55 | 65000:10055 | 10055:10055 | - | - | learned |
| 204 | 65000:10204 | 10204:10204 | - | - | learned |
| 205 | 65000:10205 | 10205:10205 | - | - | learned |
| 206 | 65000:10206 | 10206:10206 | - | - | learned |
| 207 | 65000:10207 | 10207:10207 | - | - | learned |
| 208 | 65000:10208 | 10208:10208 | - | - | learned |
| 209 | 65000:10209 | 10209:10209 | - | - | learned |
| 210 | 65000:10210 | 10210:10210 | - | - | learned |
| 211 | 65000:10211 | 10211:10211 | - | - | learned |

#### Router BGP VRFs

| VRF | Route-Distinguisher | Redistribute |
| --- | ------------------- | ------------ |
| ACME-DT | 10.0.5.13:4405 | connected |
| ACME-GENERAL | 10.0.5.13:4401 | connected |

#### Router BGP Device Configuration

```eos
!
router bgp 65599
   router-id 10.0.4.14
   distance bgp 20 200 200
   maximum-paths 4 ecmp 4
   no bgp default ipv4-unicast
   neighbor EVPN-OVERLAY-PEERS peer group
   neighbor EVPN-OVERLAY-PEERS next-hop-unchanged
   neighbor EVPN-OVERLAY-PEERS update-source Loopback0
   neighbor EVPN-OVERLAY-PEERS ebgp-multihop 4
   neighbor EVPN-OVERLAY-PEERS password 7 <removed>
   neighbor EVPN-OVERLAY-PEERS send-community
   neighbor EVPN-OVERLAY-PEERS maximum-routes 0
   neighbor IPv4-UNDERLAY-PEERS peer group
   neighbor IPv4-UNDERLAY-PEERS password 7 <removed>
   neighbor IPv4-UNDERLAY-PEERS send-community
   neighbor IPv4-UNDERLAY-PEERS maximum-routes 12000
   neighbor MLAG-IPv4-UNDERLAY-PEER peer group
   neighbor MLAG-IPv4-UNDERLAY-PEER remote-as 65599
   neighbor MLAG-IPv4-UNDERLAY-PEER next-hop-self
   neighbor MLAG-IPv4-UNDERLAY-PEER description dc02-gw01a
   neighbor MLAG-IPv4-UNDERLAY-PEER password 7 <removed>
   neighbor MLAG-IPv4-UNDERLAY-PEER send-community
   neighbor MLAG-IPv4-UNDERLAY-PEER maximum-routes 12000
   neighbor MLAG-IPv4-UNDERLAY-PEER route-map RM-MLAG-PEER-IN in
   neighbor 10.0.0.2 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.0.0.2 remote-as 65559
   neighbor 10.0.0.2 description dc01-gw01b
   neighbor 10.0.2.16 peer group EVPN-OVERLAY-PEERS
   neighbor 10.0.2.16 remote-as 65559
   neighbor 10.0.2.16 description dc01-gw01b
   neighbor 10.0.4.1 peer group EVPN-OVERLAY-PEERS
   neighbor 10.0.4.1 remote-as 65560
   neighbor 10.0.4.1 description dc02-sp01
   neighbor 10.0.4.2 peer group EVPN-OVERLAY-PEERS
   neighbor 10.0.4.2 remote-as 65560
   neighbor 10.0.4.2 description dc02-sp02
   neighbor 10.0.10.72 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.0.10.72 remote-as 65560
   neighbor 10.0.10.72 description dc02-sp01_Ethernet12
   neighbor 10.0.10.74 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.0.10.74 remote-as 65560
   neighbor 10.0.10.74 description dc02-sp02_Ethernet12
   neighbor 10.0.12.16 peer group MLAG-IPv4-UNDERLAY-PEER
   neighbor 10.0.12.16 description dc02-gw01a
   redistribute connected route-map RM-CONN-2-BGP
   !
   vlan 204
      rd 65000:10204
      route-target both 10204:10204
      redistribute learned
   !
   vlan 205
      rd 65000:10205
      route-target both 10205:10205
      redistribute learned
   !
   vlan 206
      rd 65000:10206
      route-target both 10206:10206
      redistribute learned
   !
   vlan 207
      rd 65000:10207
      route-target both 10207:10207
      redistribute learned
   !
   vlan 208
      rd 65000:10208
      route-target both 10208:10208
      redistribute learned
   !
   vlan 209
      rd 65000:10209
      route-target both 10209:10209
      redistribute learned
   !
   vlan 210
      rd 65000:10210
      route-target both 10210:10210
      redistribute learned
   !
   vlan 211
      rd 65000:10211
      route-target both 10211:10211
      redistribute learned
   !
   vlan 42
      rd 65000:10042
      route-target both 10042:10042
      redistribute learned
   !
   vlan 43
      rd 65000:10043
      route-target both 10043:10043
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
   vlan 49
      rd 65000:10049
      route-target both 10049:10049
      redistribute learned
   !
   vlan 52
      rd 65000:10052
      route-target both 10052:10052
      redistribute learned
   !
   vlan 53
      rd 65000:10053
      route-target both 10053:10053
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
      neighbor EVPN-OVERLAY-PEERS default-route-target only
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-PEERS activate
      neighbor IPv4-UNDERLAY-PEERS activate
      neighbor MLAG-IPv4-UNDERLAY-PEER activate
   !
   vrf ACME-DT
      rd 10.0.5.13:4405
      route-target import evpn 4405:4405
      route-target export evpn 4405:4405
      router-id 10.0.4.14
      neighbor 10.0.12.16 peer group MLAG-IPv4-UNDERLAY-PEER
      redistribute connected
   !
   vrf ACME-GENERAL
      rd 10.0.5.13:4401
      route-target import evpn 4401:4401
      route-target export evpn 4401:4401
      router-id 10.0.4.14
      neighbor 10.0.12.16 peer group MLAG-IPv4-UNDERLAY-PEER
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
| Enabled | - | - | - | - | - |

#### IP IGMP Snooping Device Configuration

```eos
```

## Filters

### Prefix-lists

#### Prefix-lists Summary

##### PL-LOOPBACKS-EVPN-OVERLAY

| Sequence | Action |
| -------- | ------ |
| 10 | permit 10.0.4.0/24 eq 32 |
| 20 | permit 10.0.5.0/24 eq 32 |

#### Prefix-lists Device Configuration

```eos
!
ip prefix-list PL-LOOPBACKS-EVPN-OVERLAY
   seq 10 permit 10.0.4.0/24 eq 32
   seq 20 permit 10.0.5.0/24 eq 32
```

### Route-maps

#### Route-maps Summary

##### RM-CONN-2-BGP

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY | - | - | - |

##### RM-MLAG-PEER-IN

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | - | origin incomplete | - | - |

#### Route-maps Device Configuration

```eos
!
route-map RM-CONN-2-BGP permit 10
   match ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY
!
route-map RM-MLAG-PEER-IN permit 10
   description Make routes learned over MLAG Peer-link less preferred on spines to ensure optimal routing
   set origin incomplete
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