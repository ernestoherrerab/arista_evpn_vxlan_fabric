# dc02-srv01b

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
  - [Static Routes](#static-routes)
  - [ARP](#arp)
  - [Router BGP](#router-bgp)
- [BFD](#bfd)
  - [Router BFD](#router-bfd)
- [Multicast](#multicast)
  - [IP IGMP Snooping](#ip-igmp-snooping)
  - [Router Multicast](#router-multicast)
  - [PIM Sparse Mode](#pim-sparse-mode)
- [Filters](#filters)
  - [Prefix-lists](#prefix-lists)
  - [Route-maps](#route-maps)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)
- [Virtual Source NAT](#virtual-source-nat)
  - [Virtual Source NAT Summary](#virtual-source-nat-summary)
  - [Virtual Source NAT Configuration](#virtual-source-nat-configuration)

## Management

### Management Interfaces

#### Management Interfaces Summary

##### IPv4

| Management Interface | Description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management1 | oob_management | oob | default | 192.168.0.194/24 | - |

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
   ip address 192.168.0.194/24
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
| dc02-srv01 | Vlan4094 | 10.0.11.12 | Port-Channel31 |

Dual primary detection is disabled.

### MLAG Device Configuration

```eos
!
mlag configuration
   domain-id dc02-srv01
   local-interface Vlan4094
   peer-address 10.0.11.12
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
| 43 | ACME_GENERAL_FW_43 | - |
| 45 | ACME_GENERAL_FW_45 | - |
| 53 | ACME_DT_FW_53 | - |
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
vlan 43
   name ACME_GENERAL_FW_43
!
vlan 45
   name ACME_GENERAL_FW_45
!
vlan 53
   name ACME_DT_FW_53
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
| Ethernet27 | dc02_fw01_Ethernet2 | *trunk | *43,53,204-207 | *- | *- | 27 |
| Ethernet28 | dc02_fw02_Ethernet2 | *trunk | *45,55,208-211 | *- | *- | 28 |
| Ethernet31 | MLAG_PEER_dc02-srv01a_Ethernet31 | *trunk | *- | *- | *['LEAF_PEER_L3', 'MLAG'] | 31 |
| Ethernet32 | MLAG_PEER_dc02-srv01a_Ethernet32 | *trunk | *- | *- | *['LEAF_PEER_L3', 'MLAG'] | 31 |

*Inherited from Port-Channel Interface

##### IPv4

| Interface | Description | Type | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | -----| ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet1 | P2P_LINK_TO_DC02-SP01_Ethernet10 | routed | - | 10.0.10.57/31 | default | 1500 | False | - | - |
| Ethernet2 | P2P_LINK_TO_DC02-SP02_Ethernet10 | routed | - | 10.0.10.59/31 | default | 1500 | False | - | - |

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description P2P_LINK_TO_DC02-SP01_Ethernet10
   no shutdown
   mtu 1500
   no switchport
   ip address 10.0.10.57/31
   pim ipv4 sparse-mode
!
interface Ethernet2
   description P2P_LINK_TO_DC02-SP02_Ethernet10
   no shutdown
   mtu 1500
   no switchport
   ip address 10.0.10.59/31
   pim ipv4 sparse-mode
!
interface Ethernet27
   description dc02_fw01_Ethernet2
   no shutdown
   channel-group 27 mode active
!
interface Ethernet28
   description dc02_fw02_Ethernet2
   no shutdown
   channel-group 28 mode active
!
interface Ethernet31
   description MLAG_PEER_dc02-srv01a_Ethernet31
   no shutdown
   channel-group 31 mode active
!
interface Ethernet32
   description MLAG_PEER_dc02-srv01a_Ethernet32
   no shutdown
   channel-group 31 mode active
```

### Port-Channel Interfaces

#### Port-Channel Interfaces Summary

##### L2

| Interface | Description | Type | Mode | VLANs | Native VLAN | Trunk Group | LACP Fallback Timeout | LACP Fallback Mode | MLAG ID | EVPN ESI |
| --------- | ----------- | ---- | ---- | ----- | ----------- | ------------| --------------------- | ------------------ | ------- | -------- |
| Port-Channel27 | dc02_fw01_LINK_TO_DC02-FW01 | switched | trunk | 43,53,204-207 | - | - | - | - | 27 | - |
| Port-Channel28 | dc02_fw02_LINK_TO_DC02-FW02 | switched | trunk | 45,55,208-211 | - | - | - | - | 28 | - |
| Port-Channel31 | MLAG_PEER_dc02-srv01a_Po31 | switched | trunk | - | - | ['LEAF_PEER_L3', 'MLAG'] | - | - | - | - |

#### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel27
   description dc02_fw01_LINK_TO_DC02-FW01
   no shutdown
   switchport
   switchport trunk allowed vlan 43,53,204-207
   switchport mode trunk
   mlag 27
!
interface Port-Channel28
   description dc02_fw02_LINK_TO_DC02-FW02
   no shutdown
   switchport
   switchport trunk allowed vlan 45,55,208-211
   switchport mode trunk
   mlag 28
!
interface Port-Channel31
   description MLAG_PEER_dc02-srv01a_Po31
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
| Loopback0 | EVPN_Overlay_Peering | default | 10.0.4.12/32 |
| Loopback1 | VTEP_VXLAN_Tunnel_Source | default | 10.0.5.11/32 |
| Loopback101 | ACME-GENERAL_DIAGNOSTIC | ACME-GENERAL | 10.0.6.140/32 |
| Loopback102 | ACME-DT_DIAGNOSTIC | ACME-DT | 10.0.6.204/32 |

##### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | EVPN_Overlay_Peering | default | - |
| Loopback1 | VTEP_VXLAN_Tunnel_Source | default | - |
| Loopback101 | ACME-GENERAL_DIAGNOSTIC | ACME-GENERAL | - |
| Loopback102 | ACME-DT_DIAGNOSTIC | ACME-DT | - |

#### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description EVPN_Overlay_Peering
   no shutdown
   ip address 10.0.4.12/32
!
interface Loopback1
   description VTEP_VXLAN_Tunnel_Source
   no shutdown
   ip address 10.0.5.11/32
!
interface Loopback101
   description ACME-GENERAL_DIAGNOSTIC
   no shutdown
   vrf ACME-GENERAL
   ip address 10.0.6.140/32
!
interface Loopback102
   description ACME-DT_DIAGNOSTIC
   no shutdown
   vrf ACME-DT
   ip address 10.0.6.204/32
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
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
| Vlan204 |  ACME-GENERAL  |  10.0.0.91/29  |  -  |  10.0.0.89  |  -  |  -  |  -  |
| Vlan205 |  ACME-DT  |  10.0.0.107/29  |  -  |  10.0.0.105  |  -  |  -  |  -  |
| Vlan206 |  ACME-GENERAL  |  10.0.0.99/29  |  -  |  10.0.0.97  |  -  |  -  |  -  |
| Vlan207 |  ACME-DT  |  10.0.0.115/29  |  -  |  10.0.0.113  |  -  |  -  |  -  |
| Vlan208 |  ACME-GENERAL  |  10.0.0.133/28  |  -  |  10.0.0.129  |  -  |  -  |  -  |
| Vlan209 |  ACME-DT  |  10.0.0.165/28  |  -  |  10.0.0.161  |  -  |  -  |  -  |
| Vlan210 |  ACME-GENERAL  |  10.0.0.149/28  |  -  |  10.0.0.145  |  -  |  -  |  -  |
| Vlan211 |  ACME-DT  |  10.0.0.181/28  |  -  |  10.0.0.177  |  -  |  -  |  -  |
| Vlan4001 |  ACME-GENERAL  |  10.0.12.13/31  |  -  |  -  |  -  |  -  |  -  |
| Vlan4005 |  ACME-DT  |  10.0.12.13/31  |  -  |  -  |  -  |  -  |  -  |
| Vlan4093 |  default  |  10.0.12.13/31  |  -  |  -  |  -  |  -  |  -  |
| Vlan4094 |  default  |  10.0.11.13/31  |  -  |  -  |  -  |  -  |  -  |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan204
   description ACME_GENERAL_FW_VLANS
   no shutdown
   vrf ACME-GENERAL
   ip address 10.0.0.91/29
   pim ipv4 sparse-mode
   ip virtual-router address 10.0.0.89
!
interface Vlan205
   description ACME_DT_FW_VLANS
   no shutdown
   vrf ACME-DT
   ip address 10.0.0.107/29
   pim ipv4 sparse-mode
   ip virtual-router address 10.0.0.105
!
interface Vlan206
   description ACME_GENERAL_FUSION
   no shutdown
   vrf ACME-GENERAL
   ip address 10.0.0.99/29
   pim ipv4 sparse-mode
   ip virtual-router address 10.0.0.97
!
interface Vlan207
   description ACME_DT_FUSION
   no shutdown
   vrf ACME-DT
   ip address 10.0.0.115/29
   pim ipv4 sparse-mode
   ip virtual-router address 10.0.0.113
!
interface Vlan208
   description ACME_GENERAL_FW_VLANS_EXTENDED
   no shutdown
   vrf ACME-GENERAL
   ip address 10.0.0.133/28
   pim ipv4 sparse-mode
   ip virtual-router address 10.0.0.129
!
interface Vlan209
   description ACME_DT_FW_VLANS_EXT
   no shutdown
   vrf ACME-DT
   ip address 10.0.0.165/28
   pim ipv4 sparse-mode
   ip virtual-router address 10.0.0.161
!
interface Vlan210
   description ACME_GENERAL_FUSION_EXTENDED
   no shutdown
   vrf ACME-GENERAL
   ip address 10.0.0.149/28
   pim ipv4 sparse-mode
   ip virtual-router address 10.0.0.145
!
interface Vlan211
   description ACME_DT_FUSION_EXT
   no shutdown
   vrf ACME-DT
   ip address 10.0.0.181/28
   pim ipv4 sparse-mode
   ip virtual-router address 10.0.0.177
!
interface Vlan4001
   description MLAG_PEER_L3_iBGP: vrf ACME-GENERAL
   no shutdown
   mtu 1500
   vrf ACME-GENERAL
   ip address 10.0.12.13/31
!
interface Vlan4005
   description MLAG_PEER_L3_iBGP: vrf ACME-DT
   no shutdown
   mtu 1500
   vrf ACME-DT
   ip address 10.0.12.13/31
!
interface Vlan4093
   description MLAG_PEER_L3_PEERING
   no shutdown
   mtu 1500
   ip address 10.0.12.13/31
   pim ipv4 sparse-mode
!
interface Vlan4094
   description MLAG_PEER
   no shutdown
   mtu 1500
   no autostate
   ip address 10.0.11.13/31
```

### VXLAN Interface

#### VXLAN Interface Summary

| Setting | Value |
| ------- | ----- |
| Source Interface | Loopback0 |
| MLAG Source Interface | Loopback1 |
| UDP port | 4789 |
| EVPN MLAG Shared Router MAC | mlag-system-id |

##### VLAN to VNI, Flood List and Multicast Group Mappings

| VLAN | VNI | Flood List | Multicast Group |
| ---- | --- | ---------- | --------------- |
| 43 | 10043 | - | 232.48.0.42 |
| 45 | 10045 | - | 232.48.0.44 |
| 53 | 10053 | - | 232.48.0.52 |
| 55 | 10055 | - | 232.48.0.54 |
| 204 | 10204 | - | 232.48.0.203 |
| 205 | 10205 | - | 232.48.0.204 |
| 206 | 10206 | - | 232.48.0.205 |
| 207 | 10207 | - | 232.48.0.206 |
| 208 | 10208 | - | 232.48.0.207 |
| 209 | 10209 | - | 232.48.0.208 |
| 210 | 10210 | - | 232.48.0.209 |
| 211 | 10211 | - | 232.48.0.210 |

##### VRF to VNI and Multicast Group Mappings

| VRF | VNI | Multicast Group |
| ---- | --- | --------------- |
| ACME-DT | 4405 | 232.64.17.52 |
| ACME-GENERAL | 4401 | 232.64.17.48 |

#### VXLAN Interface Device Configuration

```eos
!
interface Vxlan1
   description dc02-srv01b_VTEP
   vxlan source-interface Loopback0
   vxlan virtual-router encapsulation mac-address mlag-system-id
   vxlan udp-port 4789
   vxlan vlan 43 vni 10043
   vxlan vlan 45 vni 10045
   vxlan vlan 53 vni 10053
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
   vxlan mlag source-interface Loopback1
   vxlan vlan 43 multicast group 232.48.0.42
   vxlan vlan 45 multicast group 232.48.0.44
   vxlan vlan 53 multicast group 232.48.0.52
   vxlan vlan 55 multicast group 232.48.0.54
   vxlan vlan 204 multicast group 232.48.0.203
   vxlan vlan 205 multicast group 232.48.0.204
   vxlan vlan 206 multicast group 232.48.0.205
   vxlan vlan 207 multicast group 232.48.0.206
   vxlan vlan 208 multicast group 232.48.0.207
   vxlan vlan 209 multicast group 232.48.0.208
   vxlan vlan 210 multicast group 232.48.0.209
   vxlan vlan 211 multicast group 232.48.0.210
   vxlan vrf ACME-DT multicast group 232.64.17.52
   vxlan vrf ACME-GENERAL multicast group 232.64.17.48
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

### Static Routes

#### Static Routes Summary

| VRF | Destination Prefix | Next Hop IP | Exit interface | Administrative Distance | Tag | Route Name | Metric |
| --- | ------------------ | ----------- | -------------- | ----------------------- | --- | ---------- | ------ |
| ACME-DT | 10.4.42.0/24 | 10.0.0.118 | Vlan207 | 1 | - | AGG_ACME_DT_42 | - |
| ACME-DT | 10.4.43.0/24 | 10.0.0.118 | Vlan207 | 1 | - | AGG_ACME_DT_43 | - |
| ACME-DT | 10.4.44.0/24 | 10.0.0.118 | Vlan207 | 1 | - | AGG_ACME_DT_44 | - |
| ACME-DT | 10.4.45.0/24 | 10.0.0.190 | Vlan211 | 1 | - | AGG_ACME_DT_45 | - |
| ACME-DT | 10.5.53.0/24 | 10.0.0.110 | Vlan205 | 1 | - | FW_ACME_DT_51 | - |
| ACME-DT | 10.5.55.0/24 | 10.0.0.174 | Vlan209 | 1 | - | FW_ACME_DT_55_EXT | - |
| ACME-GENERAL | 10.5.52.0/24 | 10.0.0.102 | Vlan206 | 1 | - | AGG_ACME_DT_52 | - |
| ACME-GENERAL | 10.5.53.0/24 | 10.0.0.102 | Vlan206 | 1 | - | AGG_ACME_DT_53 | - |
| ACME-GENERAL | 10.5.54.0/24 | 10.0.0.102 | Vlan206 | 1 | - | AGG_ACME_DT_54 | - |
| ACME-GENERAL | 10.5.55.0/24 | 10.0.0.158 | Vlan210 | 1 | - | AGG_ACME_DT_55_EXT | - |
| ACME-GENERAL | 10.4.43.0/24 | 10.0.0.94 | Vlan204 | 1 | - | FW_ACME_GENERAL_43 | - |
| ACME-GENERAL | 10.4.45.0/24 | 10.0.0.142 | Vlan208 | 1 | - | FW_ACME_GENERAL_45_EXTENDED | - |

#### Static Routes Device Configuration

```eos
!
ip route vrf ACME-DT 10.4.42.0/24 Vlan207 10.0.0.118 name AGG_ACME_DT_42
ip route vrf ACME-DT 10.4.43.0/24 Vlan207 10.0.0.118 name AGG_ACME_DT_43
ip route vrf ACME-DT 10.4.44.0/24 Vlan207 10.0.0.118 name AGG_ACME_DT_44
ip route vrf ACME-DT 10.4.45.0/24 Vlan211 10.0.0.190 name AGG_ACME_DT_45
ip route vrf ACME-DT 10.5.53.0/24 Vlan205 10.0.0.110 name FW_ACME_DT_51
ip route vrf ACME-DT 10.5.55.0/24 Vlan209 10.0.0.174 name FW_ACME_DT_55_EXT
ip route vrf ACME-GENERAL 10.5.52.0/24 Vlan206 10.0.0.102 name AGG_ACME_DT_52
ip route vrf ACME-GENERAL 10.5.53.0/24 Vlan206 10.0.0.102 name AGG_ACME_DT_53
ip route vrf ACME-GENERAL 10.5.54.0/24 Vlan206 10.0.0.102 name AGG_ACME_DT_54
ip route vrf ACME-GENERAL 10.5.55.0/24 Vlan210 10.0.0.158 name AGG_ACME_DT_55_EXT
ip route vrf ACME-GENERAL 10.4.43.0/24 Vlan204 10.0.0.94 name FW_ACME_GENERAL_43
ip route vrf ACME-GENERAL 10.4.45.0/24 Vlan208 10.0.0.142 name FW_ACME_GENERAL_45_EXTENDED
```

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
| 65597 | 10.0.4.12 |

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

##### MLAG-IPv4-UNDERLAY-PEER

| Settings | Value |
| -------- | ----- |
| Address Family | ipv4 |
| Remote AS | 65597 |
| Next-hop self | True |
| Send community | all |
| Maximum routes | 12000 |

#### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client | Passive | TTL Max Hops |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- | --------------------- | ---------------------- | ------- | ------------ |
| 10.0.4.1 | 65560 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - | - | - |
| 10.0.4.2 | 65560 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - | - | - |
| 10.0.10.56 | 65560 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 10.0.10.58 | 65560 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 10.0.12.12 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | default | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - | - |
| 10.0.12.12 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | ACME-DT | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - |
| 10.0.12.12 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | ACME-GENERAL | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - |

#### Router BGP EVPN Address Family

##### EVPN Peer Groups

| Peer Group | Activate | Encapsulation |
| ---------- | -------- | ------------- |
| EVPN-OVERLAY-PEERS | True | default |

#### Router BGP VLANs

| VLAN | Route-Distinguisher | Both Route-Target | Import Route Target | Export Route-Target | Redistribute |
| ---- | ------------------- | ----------------- | ------------------- | ------------------- | ------------ |
| 43 | 10.0.4.12:10043 | 10043:10043 | - | - | learned<br>igmp |
| 45 | 10.0.4.12:10045 | 10045:10045 | - | - | learned<br>igmp |
| 53 | 10.0.4.12:10053 | 10053:10053 | - | - | learned<br>igmp |
| 55 | 10.0.4.12:10055 | 10055:10055 | - | - | learned<br>igmp |
| 204 | 10.0.4.12:10204 | 10204:10204 | - | - | learned<br>igmp |
| 205 | 10.0.4.12:10205 | 10205:10205 | - | - | learned<br>igmp |
| 206 | 10.0.4.12:10206 | 10206:10206 | - | - | learned<br>igmp |
| 207 | 10.0.4.12:10207 | 10207:10207 | - | - | learned<br>igmp |
| 208 | 10.0.4.12:10208 | 10208:10208 | - | - | learned<br>igmp |
| 209 | 10.0.4.12:10209 | 10209:10209 | - | - | learned<br>igmp |
| 210 | 10.0.4.12:10210 | 10210:10210 | - | - | learned<br>igmp |
| 211 | 10.0.4.12:10211 | 10211:10211 | - | - | learned<br>igmp |

#### Router BGP VRFs

| VRF | Route-Distinguisher | Redistribute | EVPN Multicast |
| --- | ------------------- | ------------ | -------------- |
| ACME-DT | 10.0.4.12:4405 | connected<br>static | IPv4: True<br>Transit: False |
| ACME-GENERAL | 10.0.4.12:4401 | connected<br>static | IPv4: True<br>Transit: False |

#### Router BGP Device Configuration

```eos
!
router bgp 65597
   router-id 10.0.4.12
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
   neighbor MLAG-IPv4-UNDERLAY-PEER peer group
   neighbor MLAG-IPv4-UNDERLAY-PEER remote-as 65597
   neighbor MLAG-IPv4-UNDERLAY-PEER next-hop-self
   neighbor MLAG-IPv4-UNDERLAY-PEER description dc02-srv01a
   neighbor MLAG-IPv4-UNDERLAY-PEER password 7 <removed>
   neighbor MLAG-IPv4-UNDERLAY-PEER send-community
   neighbor MLAG-IPv4-UNDERLAY-PEER maximum-routes 12000
   neighbor MLAG-IPv4-UNDERLAY-PEER route-map RM-MLAG-PEER-IN in
   neighbor 10.0.4.1 peer group EVPN-OVERLAY-PEERS
   neighbor 10.0.4.1 remote-as 65560
   neighbor 10.0.4.1 description dc02-sp01
   neighbor 10.0.4.1 route-map RM-EVPN-FILTER-AS65560 out
   neighbor 10.0.4.2 peer group EVPN-OVERLAY-PEERS
   neighbor 10.0.4.2 remote-as 65560
   neighbor 10.0.4.2 description dc02-sp02
   neighbor 10.0.4.2 route-map RM-EVPN-FILTER-AS65560 out
   neighbor 10.0.10.56 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.0.10.56 remote-as 65560
   neighbor 10.0.10.56 description dc02-sp01_Ethernet10
   neighbor 10.0.10.58 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.0.10.58 remote-as 65560
   neighbor 10.0.10.58 description dc02-sp02_Ethernet10
   neighbor 10.0.12.12 peer group MLAG-IPv4-UNDERLAY-PEER
   neighbor 10.0.12.12 description dc02-srv01a
   redistribute connected route-map RM-CONN-2-BGP
   !
   vlan 204
      rd 10.0.4.12:10204
      route-target both 10204:10204
      redistribute igmp
      redistribute learned
   !
   vlan 205
      rd 10.0.4.12:10205
      route-target both 10205:10205
      redistribute igmp
      redistribute learned
   !
   vlan 206
      rd 10.0.4.12:10206
      route-target both 10206:10206
      redistribute igmp
      redistribute learned
   !
   vlan 207
      rd 10.0.4.12:10207
      route-target both 10207:10207
      redistribute igmp
      redistribute learned
   !
   vlan 208
      rd 10.0.4.12:10208
      route-target both 10208:10208
      redistribute igmp
      redistribute learned
   !
   vlan 209
      rd 10.0.4.12:10209
      route-target both 10209:10209
      redistribute igmp
      redistribute learned
   !
   vlan 210
      rd 10.0.4.12:10210
      route-target both 10210:10210
      redistribute igmp
      redistribute learned
   !
   vlan 211
      rd 10.0.4.12:10211
      route-target both 10211:10211
      redistribute igmp
      redistribute learned
   !
   vlan 43
      rd 10.0.4.12:10043
      route-target both 10043:10043
      redistribute igmp
      redistribute learned
   !
   vlan 45
      rd 10.0.4.12:10045
      route-target both 10045:10045
      redistribute igmp
      redistribute learned
   !
   vlan 53
      rd 10.0.4.12:10053
      route-target both 10053:10053
      redistribute igmp
      redistribute learned
   !
   vlan 55
      rd 10.0.4.12:10055
      route-target both 10055:10055
      redistribute igmp
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
      neighbor MLAG-IPv4-UNDERLAY-PEER activate
   !
   vrf ACME-DT
      rd 10.0.4.12:4405
      evpn multicast
      route-target import evpn 4405:4405
      route-target export evpn 4405:4405
      router-id 10.0.4.12
      neighbor 10.0.12.12 peer group MLAG-IPv4-UNDERLAY-PEER
      redistribute connected
      redistribute static
   !
   vrf ACME-GENERAL
      rd 10.0.4.12:4401
      evpn multicast
      route-target import evpn 4401:4401
      route-target export evpn 4401:4401
      router-id 10.0.4.12
      neighbor 10.0.12.12 peer group MLAG-IPv4-UNDERLAY-PEER
      redistribute connected
      redistribute static
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

##### IP IGMP Snooping Vlan Summary

| Vlan | IGMP Snooping | Fast Leave | Max Groups | Proxy |
| ---- | ------------- | ---------- | ---------- | ----- |
| 43 | - | - | - | - |
| 45 | - | - | - | - |
| 53 | - | - | - | - |
| 55 | - | - | - | - |
| 204 | - | - | - | - |
| 205 | - | - | - | - |
| 206 | - | - | - | - |
| 207 | - | - | - | - |
| 208 | - | - | - | - |
| 209 | - | - | - | - |
| 210 | - | - | - | - |
| 211 | - | - | - | - |

| Vlan | Querier Enabled | IP Address | Query Interval | Max Response Time | Last Member Query Interval | Last Member Query Count | Startup Query Interval | Startup Query Count | Version |
| ---- | --------------- | ---------- | -------------- | ----------------- | -------------------------- | ----------------------- | ---------------------- | ------------------- | ------- |
| 43 | True | 10.0.4.12 | - | - | - | - | - | - | - |
| 45 | True | 10.0.4.12 | - | - | - | - | - | - | - |
| 53 | True | 10.0.4.12 | - | - | - | - | - | - | - |
| 55 | True | 10.0.4.12 | - | - | - | - | - | - | - |
| 204 | True | 10.0.4.12 | - | - | - | - | - | - | - |
| 205 | True | 10.0.4.12 | - | - | - | - | - | - | - |
| 206 | True | 10.0.4.12 | - | - | - | - | - | - | - |
| 207 | True | 10.0.4.12 | - | - | - | - | - | - | - |
| 208 | True | 10.0.4.12 | - | - | - | - | - | - | - |
| 209 | True | 10.0.4.12 | - | - | - | - | - | - | - |
| 210 | True | 10.0.4.12 | - | - | - | - | - | - | - |
| 211 | True | 10.0.4.12 | - | - | - | - | - | - | - |

#### IP IGMP Snooping Device Configuration

```eos
!
ip igmp snooping vlan 43 querier
ip igmp snooping vlan 43 querier address 10.0.4.12
ip igmp snooping vlan 45 querier
ip igmp snooping vlan 45 querier address 10.0.4.12
ip igmp snooping vlan 53 querier
ip igmp snooping vlan 53 querier address 10.0.4.12
ip igmp snooping vlan 55 querier
ip igmp snooping vlan 55 querier address 10.0.4.12
ip igmp snooping vlan 204 querier
ip igmp snooping vlan 204 querier address 10.0.4.12
ip igmp snooping vlan 205 querier
ip igmp snooping vlan 205 querier address 10.0.4.12
ip igmp snooping vlan 206 querier
ip igmp snooping vlan 206 querier address 10.0.4.12
ip igmp snooping vlan 207 querier
ip igmp snooping vlan 207 querier address 10.0.4.12
ip igmp snooping vlan 208 querier
ip igmp snooping vlan 208 querier address 10.0.4.12
ip igmp snooping vlan 209 querier
ip igmp snooping vlan 209 querier address 10.0.4.12
ip igmp snooping vlan 210 querier
ip igmp snooping vlan 210 querier address 10.0.4.12
ip igmp snooping vlan 211 querier
ip igmp snooping vlan 211 querier address 10.0.4.12
```

### Router Multicast

#### IP Router Multicast Summary

- Routing for IPv4 multicast is enabled.
- Software forwarding by the Software Forwarding Engine (SFE)

#### IP Router Multicast VRFs

| VRF Name | Multicast Routing |
| -------- | ----------------- |
| ACME-DT | enabled |
| ACME-GENERAL | enabled |

#### Router Multicast Device Configuration

```eos
!
router multicast
   ipv4
      routing
      software-forwarding sfe
   !
   vrf ACME-DT
      ipv4
         routing
   !
   vrf ACME-GENERAL
      ipv4
         routing
```

### PIM Sparse Mode

#### PIM Sparse Mode Enabled Interfaces

| Interface Name | VRF Name | IP Version | Border Router | DR Priority | Local Interface |
| -------------- | -------- | ---------- | ------------- | ----------- | --------------- |
| Ethernet1 | - | IPv4 | - | - | - |
| Ethernet2 | - | IPv4 | - | - | - |
| Vlan204 | ACME-GENERAL | IPv4 | - | - | - |
| Vlan205 | ACME-DT | IPv4 | - | - | - |
| Vlan206 | ACME-GENERAL | IPv4 | - | - | - |
| Vlan207 | ACME-DT | IPv4 | - | - | - |
| Vlan208 | ACME-GENERAL | IPv4 | - | - | - |
| Vlan209 | ACME-DT | IPv4 | - | - | - |
| Vlan210 | ACME-GENERAL | IPv4 | - | - | - |
| Vlan211 | ACME-DT | IPv4 | - | - | - |
| Vlan4093 | - | IPv4 | - | - | - |

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

##### RM-EVPN-FILTER-AS65560

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | deny | as 65560 | - | - | - |
| 20 | permit | - | - | - | - |

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
route-map RM-EVPN-FILTER-AS65560 deny 10
   match as 65560
!
route-map RM-EVPN-FILTER-AS65560 permit 20
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

## Virtual Source NAT

### Virtual Source NAT Summary

| Source NAT VRF | Source NAT IP Address |
| -------------- | --------------------- |
| ACME-DT | 10.0.6.204 |
| ACME-GENERAL | 10.0.6.140 |

### Virtual Source NAT Configuration

```eos
!
ip address virtual source-nat vrf ACME-DT address 10.0.6.204
ip address virtual source-nat vrf ACME-GENERAL address 10.0.6.140
```
