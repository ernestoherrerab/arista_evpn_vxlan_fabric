# dc01-srv01a

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
| Management1 | oob_management | oob | default | 192.168.0.191/24 | - |

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
   ip address 192.168.0.191/24
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
| dc01-srv01 | Vlan4094 | 10.0.11.17 | Port-Channel31 |

Dual primary detection is disabled.

### MLAG Device Configuration

```eos
!
mlag configuration
   domain-id dc01-srv01
   local-interface Vlan4094
   peer-address 10.0.11.17
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
| 41 | ACME_GENERAL_FW_41 | - |
| 45 | ACME_GENERAL_FW_45 | - |
| 51 | ACME_DT_FW_51 | - |
| 55 | ACME_DT_FW_55 | - |
| 200 | ACME_GENERAL_FW_VLANS | - |
| 201 | ACME_DT_FW_VLANS | - |
| 202 | ACME_GENERAL_FUSION | - |
| 203 | ACME_DT_FUSION | - |
| 208 | ACME_GENERAL_FW_EXTENDED | - |
| 209 | ACME_DT_FW_VLANS_EXTENDED | - |
| 210 | ACME_GENERAL_FUSION_EXTENDED | - |
| 211 | ACME_DT_FUSION_EXTENDED | - |
| 4001 | MLAG_iBGP_ACME-GENERAL | LEAF_PEER_L3 |
| 4005 | MLAG_iBGP_ACME-DT | LEAF_PEER_L3 |
| 4093 | LEAF_PEER_L3 | LEAF_PEER_L3 |
| 4094 | MLAG_PEER | MLAG |

### VLANs Device Configuration

```eos
!
vlan 41
   name ACME_GENERAL_FW_41
!
vlan 45
   name ACME_GENERAL_FW_45
!
vlan 51
   name ACME_DT_FW_51
!
vlan 55
   name ACME_DT_FW_55
!
vlan 200
   name ACME_GENERAL_FW_VLANS
!
vlan 201
   name ACME_DT_FW_VLANS
!
vlan 202
   name ACME_GENERAL_FUSION
!
vlan 203
   name ACME_DT_FUSION
!
vlan 208
   name ACME_GENERAL_FW_EXTENDED
!
vlan 209
   name ACME_DT_FW_VLANS_EXTENDED
!
vlan 210
   name ACME_GENERAL_FUSION_EXTENDED
!
vlan 211
   name ACME_DT_FUSION_EXTENDED
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
| Ethernet27 | dc01_fw01_Ethernet1 | *trunk | *41,51,200-203 | *- | *- | 27 |
| Ethernet28 | dc01_fw02_Ethernet1 | *trunk | *45,55,208-211 | *- | *- | 28 |
| Ethernet31 | MLAG_PEER_dc01-srv01b_Ethernet31 | *trunk | *- | *- | *['LEAF_PEER_L3', 'MLAG'] | 31 |
| Ethernet32 | MLAG_PEER_dc01-srv01b_Ethernet32 | *trunk | *- | *- | *['LEAF_PEER_L3', 'MLAG'] | 31 |

*Inherited from Port-Channel Interface

##### IPv4

| Interface | Description | Type | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | -----| ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet1 | P2P_LINK_TO_DC01-SP01_Ethernet9 | routed | - | 10.0.9.65/31 | default | 1500 | False | - | - |
| Ethernet2 | P2P_LINK_TO_DC01-SP02_Ethernet9 | routed | - | 10.0.9.67/31 | default | 1500 | False | - | - |

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description P2P_LINK_TO_DC01-SP01_Ethernet9
   no shutdown
   mtu 1500
   no switchport
   ip address 10.0.9.65/31
!
interface Ethernet2
   description P2P_LINK_TO_DC01-SP02_Ethernet9
   no shutdown
   mtu 1500
   no switchport
   ip address 10.0.9.67/31
!
interface Ethernet27
   description dc01_fw01_Ethernet1
   no shutdown
   channel-group 27 mode active
!
interface Ethernet28
   description dc01_fw02_Ethernet1
   no shutdown
   channel-group 28 mode active
!
interface Ethernet31
   description MLAG_PEER_dc01-srv01b_Ethernet31
   no shutdown
   channel-group 31 mode active
!
interface Ethernet32
   description MLAG_PEER_dc01-srv01b_Ethernet32
   no shutdown
   channel-group 31 mode active
```

### Port-Channel Interfaces

#### Port-Channel Interfaces Summary

##### L2

| Interface | Description | Type | Mode | VLANs | Native VLAN | Trunk Group | LACP Fallback Timeout | LACP Fallback Mode | MLAG ID | EVPN ESI |
| --------- | ----------- | ---- | ---- | ----- | ----------- | ------------| --------------------- | ------------------ | ------- | -------- |
| Port-Channel27 | dc01_fw01_LINK_TO_DC01_FW01 | switched | trunk | 41,51,200-203 | - | - | - | - | 27 | - |
| Port-Channel28 | dc01_fw02_LINK_TO_DC01_FW02 | switched | trunk | 45,55,208-211 | - | - | - | - | 28 | - |
| Port-Channel31 | MLAG_PEER_dc01-srv01b_Po31 | switched | trunk | - | - | ['LEAF_PEER_L3', 'MLAG'] | - | - | - | - |

#### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel27
   description dc01_fw01_LINK_TO_DC01_FW01
   no shutdown
   switchport
   switchport trunk allowed vlan 41,51,200-203
   switchport mode trunk
   mlag 27
!
interface Port-Channel28
   description dc01_fw02_LINK_TO_DC01_FW02
   no shutdown
   switchport
   switchport trunk allowed vlan 45,55,208-211
   switchport mode trunk
   mlag 28
!
interface Port-Channel31
   description MLAG_PEER_dc01-srv01b_Po31
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
| Loopback0 | EVPN_Overlay_Peering | default | 10.0.2.13/32 |
| Loopback1 | VTEP_VXLAN_Tunnel_Source | default | 10.0.3.13/32 |

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
   ip address 10.0.2.13/32
!
interface Loopback1
   description VTEP_VXLAN_Tunnel_Source
   no shutdown
   ip address 10.0.3.13/32
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan200 | ACME_GENERAL_FW_VLANS | ACME-GENERAL | - | False |
| Vlan201 | ACME_DT_FW_VLANS | ACME-DT | - | False |
| Vlan202 | ACME_GENERAL_FUSION | ACME-GENERAL | - | False |
| Vlan203 | ACME_DT_FUSION | ACME-DT | - | False |
| Vlan208 | ACME_GENERAL_FW_EXTENDED | ACME-GENERAL | - | False |
| Vlan209 | ACME_DT_FW_VLANS_EXTENDED | ACME-DT | - | False |
| Vlan210 | ACME_GENERAL_FUSION_EXTENDED | ACME-GENERAL | - | False |
| Vlan211 | ACME_DT_FUSION_EXTENDED | ACME-DT | - | False |
| Vlan4001 | MLAG_PEER_L3_iBGP: vrf ACME-GENERAL | ACME-GENERAL | 1500 | False |
| Vlan4005 | MLAG_PEER_L3_iBGP: vrf ACME-DT | ACME-DT | 1500 | False |
| Vlan4093 | MLAG_PEER_L3_PEERING | default | 1500 | False |
| Vlan4094 | MLAG_PEER | default | 1500 | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | VRRP | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ---- | ------ | ------- |
| Vlan200 |  ACME-GENERAL  |  10.0.0.58/29  |  -  |  10.0.0.57  |  -  |  -  |  -  |
| Vlan201 |  ACME-DT  |  10.0.0.74/29  |  -  |  10.0.0.73  |  -  |  -  |  -  |
| Vlan202 |  ACME-GENERAL  |  10.0.0.66/29  |  -  |  10.0.0.65  |  -  |  -  |  -  |
| Vlan203 |  ACME-DT  |  10.0.0.82/29  |  -  |  10.0.0.81  |  -  |  -  |  -  |
| Vlan208 |  ACME-GENERAL  |  10.0.0.130/28  |  -  |  10.0.0.129  |  -  |  -  |  -  |
| Vlan209 |  ACME-DT  |  10.0.0.162/28  |  -  |  10.0.0.161  |  -  |  -  |  -  |
| Vlan210 |  ACME-GENERAL  |  10.0.0.146/28  |  -  |  10.0.0.145  |  -  |  -  |  -  |
| Vlan211 |  ACME-DT  |  10.0.0.178/28  |  -  |  10.0.0.177  |  -  |  -  |  -  |
| Vlan4001 |  ACME-GENERAL  |  10.0.12.16/31  |  -  |  -  |  -  |  -  |  -  |
| Vlan4005 |  ACME-DT  |  10.0.12.16/31  |  -  |  -  |  -  |  -  |  -  |
| Vlan4093 |  default  |  10.0.12.16/31  |  -  |  -  |  -  |  -  |  -  |
| Vlan4094 |  default  |  10.0.11.16/31  |  -  |  -  |  -  |  -  |  -  |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan200
   description ACME_GENERAL_FW_VLANS
   no shutdown
   vrf ACME-GENERAL
   ip address 10.0.0.58/29
   ip virtual-router address 10.0.0.57
!
interface Vlan201
   description ACME_DT_FW_VLANS
   no shutdown
   vrf ACME-DT
   ip address 10.0.0.74/29
   ip virtual-router address 10.0.0.73
!
interface Vlan202
   description ACME_GENERAL_FUSION
   no shutdown
   vrf ACME-GENERAL
   ip address 10.0.0.66/29
   ip virtual-router address 10.0.0.65
!
interface Vlan203
   description ACME_DT_FUSION
   no shutdown
   vrf ACME-DT
   ip address 10.0.0.82/29
   ip virtual-router address 10.0.0.81
!
interface Vlan208
   description ACME_GENERAL_FW_EXTENDED
   no shutdown
   vrf ACME-GENERAL
   ip address 10.0.0.130/28
   ip virtual-router address 10.0.0.129
!
interface Vlan209
   description ACME_DT_FW_VLANS_EXTENDED
   no shutdown
   vrf ACME-DT
   ip address 10.0.0.162/28
   ip virtual-router address 10.0.0.161
!
interface Vlan210
   description ACME_GENERAL_FUSION_EXTENDED
   no shutdown
   vrf ACME-GENERAL
   ip address 10.0.0.146/28
   ip virtual-router address 10.0.0.145
!
interface Vlan211
   description ACME_DT_FUSION_EXTENDED
   no shutdown
   vrf ACME-DT
   ip address 10.0.0.178/28
   ip virtual-router address 10.0.0.177
!
interface Vlan4001
   description MLAG_PEER_L3_iBGP: vrf ACME-GENERAL
   no shutdown
   mtu 1500
   vrf ACME-GENERAL
   ip address 10.0.12.16/31
!
interface Vlan4005
   description MLAG_PEER_L3_iBGP: vrf ACME-DT
   no shutdown
   mtu 1500
   vrf ACME-DT
   ip address 10.0.12.16/31
!
interface Vlan4093
   description MLAG_PEER_L3_PEERING
   no shutdown
   mtu 1500
   ip address 10.0.12.16/31
!
interface Vlan4094
   description MLAG_PEER
   no shutdown
   mtu 1500
   no autostate
   ip address 10.0.11.16/31
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
| 41 | 10041 | - | - |
| 45 | 10045 | - | - |
| 51 | 10051 | - | - |
| 55 | 10055 | - | - |
| 200 | 10200 | - | - |
| 201 | 10201 | - | - |
| 202 | 10202 | - | - |
| 203 | 10203 | - | - |
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
   description dc01-srv01a_VTEP
   vxlan source-interface Loopback1
   vxlan virtual-router encapsulation mac-address mlag-system-id
   vxlan udp-port 4789
   vxlan vlan 41 vni 10041
   vxlan vlan 45 vni 10045
   vxlan vlan 51 vni 10051
   vxlan vlan 55 vni 10055
   vxlan vlan 200 vni 10200
   vxlan vlan 201 vni 10201
   vxlan vlan 202 vni 10202
   vxlan vlan 203 vni 10203
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

### Static Routes

#### Static Routes Summary

| VRF | Destination Prefix | Next Hop IP | Exit interface | Administrative Distance | Tag | Route Name | Metric |
| --- | ------------------ | ----------- | -------------- | ----------------------- | --- | ---------- | ------ |
| ACME-DT | 10.4.40.0/24 | 10.0.0.86 | Vlan203 | 1 | - | AGG_ACME_DT_40 | - |
| ACME-DT | 10.4.41.0/24 | 10.0.0.86 | Vlan203 | 1 | - | AGG_ACME_DT_41 | - |
| ACME-DT | 10.4.44.0/24 | 10.0.0.86 | Vlan203 | 1 | - | AGG_ACME_DT_44 | - |
| ACME-DT | 10.4.45.0/24 | 10.0.0.190 | Vlan211 | 1 | - | AGG_ACME_DT_45 | - |
| ACME-DT | 10.5.51.0/24 | 10.0.0.78 | Vlan201 | 1 | - | FW_ACME_DT_51 | - |
| ACME-DT | 10.5.55.0/24 | 10.0.0.174 | Vlan209 | 1 | - | FW_ACME_DT_55_EXTENDED | - |
| ACME-GENERAL | 10.5.50.0/24 | 10.0.0.70 | Vlan202 | 1 | - | AGG_ACME_DT_50 | - |
| ACME-GENERAL | 10.5.51.0/24 | 10.0.0.70 | Vlan202 | 1 | - | AGG_ACME_DT_51 | - |
| ACME-GENERAL | 10.5.54.0/24 | 10.0.0.70 | Vlan202 | 1 | - | AGG_ACME_DT_54 | - |
| ACME-GENERAL | 10.5.55.0/24 | 10.0.0.158 | Vlan210 | 1 | - | AGG_ACME_DT_55 | - |
| ACME-GENERAL | 10.4.41.0/24 | 10.0.0.62 | Vlan200 | 1 | - | FW_ACME_GENERAL_41 | - |
| ACME-GENERAL | 10.4.45.0/24 | 10.0.0.142 | Vlan208 | 1 | - | FW_ACME_GENERAL_45_EXTENDED | - |

#### Static Routes Device Configuration

```eos
!
ip route vrf ACME-DT 10.4.40.0/24 Vlan203 10.0.0.86 name AGG_ACME_DT_40
ip route vrf ACME-DT 10.4.41.0/24 Vlan203 10.0.0.86 name AGG_ACME_DT_41
ip route vrf ACME-DT 10.4.44.0/24 Vlan203 10.0.0.86 name AGG_ACME_DT_44
ip route vrf ACME-DT 10.4.45.0/24 Vlan211 10.0.0.190 name AGG_ACME_DT_45
ip route vrf ACME-DT 10.5.51.0/24 Vlan201 10.0.0.78 name FW_ACME_DT_51
ip route vrf ACME-DT 10.5.55.0/24 Vlan209 10.0.0.174 name FW_ACME_DT_55_EXTENDED
ip route vrf ACME-GENERAL 10.5.50.0/24 Vlan202 10.0.0.70 name AGG_ACME_DT_50
ip route vrf ACME-GENERAL 10.5.51.0/24 Vlan202 10.0.0.70 name AGG_ACME_DT_51
ip route vrf ACME-GENERAL 10.5.54.0/24 Vlan202 10.0.0.70 name AGG_ACME_DT_54
ip route vrf ACME-GENERAL 10.5.55.0/24 Vlan210 10.0.0.158 name AGG_ACME_DT_55
ip route vrf ACME-GENERAL 10.4.41.0/24 Vlan200 10.0.0.62 name FW_ACME_GENERAL_41
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
| 65557 | 10.0.2.13 |

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
| Remote AS | 65557 |
| Next-hop self | True |
| Send community | all |
| Maximum routes | 12000 |

#### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client | Passive | TTL Max Hops |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- | --------------------- | ---------------------- | ------- | ------------ |
| 10.0.2.1 | 65520 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - | - | - |
| 10.0.2.2 | 65520 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - | - | - |
| 10.0.9.64 | 65520 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 10.0.9.66 | 65520 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 10.0.12.17 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | default | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - | - |
| 10.0.12.17 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | ACME-DT | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - |
| 10.0.12.17 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | ACME-GENERAL | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - |

#### Router BGP EVPN Address Family

##### EVPN Peer Groups

| Peer Group | Activate | Encapsulation |
| ---------- | -------- | ------------- |
| EVPN-OVERLAY-PEERS | True | default |

#### Router BGP VLANs

| VLAN | Route-Distinguisher | Both Route-Target | Import Route Target | Export Route-Target | Redistribute |
| ---- | ------------------- | ----------------- | ------------------- | ------------------- | ------------ |
| 41 | 65000:10041 | 10041:10041 | - | - | learned |
| 45 | 65000:10045 | 10045:10045 | - | - | learned |
| 51 | 65000:10051 | 10051:10051 | - | - | learned |
| 55 | 65000:10055 | 10055:10055 | - | - | learned |
| 200 | 65000:10200 | 10200:10200 | - | - | learned |
| 201 | 65000:10201 | 10201:10201 | - | - | learned |
| 202 | 65000:10202 | 10202:10202 | - | - | learned |
| 203 | 65000:10203 | 10203:10203 | - | - | learned |
| 208 | 65000:10208 | 10208:10208 | - | - | learned |
| 209 | 65000:10209 | 10209:10209 | - | - | learned |
| 210 | 65000:10210 | 10210:10210 | - | - | learned |
| 211 | 65000:10211 | 10211:10211 | - | - | learned |

#### Router BGP VRFs

| VRF | Route-Distinguisher | Redistribute |
| --- | ------------------- | ------------ |
| ACME-DT | 10.0.3.13:4405 | connected<br>static |
| ACME-GENERAL | 10.0.3.13:4401 | connected<br>static |

#### Router BGP Device Configuration

```eos
!
router bgp 65557
   router-id 10.0.2.13
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
   neighbor MLAG-IPv4-UNDERLAY-PEER remote-as 65557
   neighbor MLAG-IPv4-UNDERLAY-PEER next-hop-self
   neighbor MLAG-IPv4-UNDERLAY-PEER description dc01-srv01b
   neighbor MLAG-IPv4-UNDERLAY-PEER password 7 <removed>
   neighbor MLAG-IPv4-UNDERLAY-PEER send-community
   neighbor MLAG-IPv4-UNDERLAY-PEER maximum-routes 12000
   neighbor MLAG-IPv4-UNDERLAY-PEER route-map RM-MLAG-PEER-IN in
   neighbor 10.0.2.1 peer group EVPN-OVERLAY-PEERS
   neighbor 10.0.2.1 remote-as 65520
   neighbor 10.0.2.1 description dc01-sp01
   neighbor 10.0.2.1 route-map RM-EVPN-FILTER-AS65520 out
   neighbor 10.0.2.2 peer group EVPN-OVERLAY-PEERS
   neighbor 10.0.2.2 remote-as 65520
   neighbor 10.0.2.2 description dc01-sp02
   neighbor 10.0.2.2 route-map RM-EVPN-FILTER-AS65520 out
   neighbor 10.0.9.64 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.0.9.64 remote-as 65520
   neighbor 10.0.9.64 description dc01-sp01_Ethernet9
   neighbor 10.0.9.66 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.0.9.66 remote-as 65520
   neighbor 10.0.9.66 description dc01-sp02_Ethernet9
   neighbor 10.0.12.17 peer group MLAG-IPv4-UNDERLAY-PEER
   neighbor 10.0.12.17 description dc01-srv01b
   redistribute connected route-map RM-CONN-2-BGP
   !
   vlan 200
      rd 65000:10200
      route-target both 10200:10200
      redistribute learned
   !
   vlan 201
      rd 65000:10201
      route-target both 10201:10201
      redistribute learned
   !
   vlan 202
      rd 65000:10202
      route-target both 10202:10202
      redistribute learned
   !
   vlan 203
      rd 65000:10203
      route-target both 10203:10203
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
   vlan 41
      rd 65000:10041
      route-target both 10041:10041
      redistribute learned
   !
   vlan 45
      rd 65000:10045
      route-target both 10045:10045
      redistribute learned
   !
   vlan 51
      rd 65000:10051
      route-target both 10051:10051
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
      neighbor MLAG-IPv4-UNDERLAY-PEER activate
   !
   vrf ACME-DT
      rd 10.0.3.13:4405
      route-target import evpn 4405:4405
      route-target export evpn 4405:4405
      router-id 10.0.2.13
      neighbor 10.0.12.17 peer group MLAG-IPv4-UNDERLAY-PEER
      redistribute connected
      redistribute static
   !
   vrf ACME-GENERAL
      rd 10.0.3.13:4401
      route-target import evpn 4401:4401
      route-target export evpn 4401:4401
      router-id 10.0.2.13
      neighbor 10.0.12.17 peer group MLAG-IPv4-UNDERLAY-PEER
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
route-map RM-EVPN-FILTER-AS65520 deny 10
   match as 65520
!
route-map RM-EVPN-FILTER-AS65520 permit 20
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
