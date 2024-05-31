# acme_fabric

## Table of Contents

- [Fabric Switches and Management IP](#fabric-switches-and-management-ip)
  - [Fabric Switches with inband Management IP](#fabric-switches-with-inband-management-ip)
- [Fabric Topology](#fabric-topology)
- [Fabric IP Allocation](#fabric-ip-allocation)
  - [Fabric Point-To-Point Links](#fabric-point-to-point-links)
  - [Point-To-Point Links Node Allocation](#point-to-point-links-node-allocation)
  - [Loopback Interfaces (BGP EVPN Peering)](#loopback-interfaces-bgp-evpn-peering)
  - [Loopback0 Interfaces Node Allocation](#loopback0-interfaces-node-allocation)
  - [VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)](#vtep-loopback-vxlan-tunnel-source-interfaces-vteps-only)
  - [VTEP Loopback Node allocation](#vtep-loopback-node-allocation)

## Fabric Switches and Management IP

| POD | Type | Node | Management IP | Platform | Provisioned in CloudVision | Serial Number |
| --- | ---- | ---- | ------------- | -------- | -------------------------- | ------------- |
| dc01 | firewall | dc01-fw01 | 192.168.0.133/24 | vEOS-LAB | Provisioned | - |
| dc01 | firewall | dc01-fw02 | 192.168.0.167/24 | vEOS-LAB | Provisioned | - |
| dc01 | l3leaf | dc01-gw01a | 192.168.0.197/24 | vEOS-LAB | Provisioned | - |
| dc01 | l3leaf | dc01-gw01b | 192.168.0.198/24 | vEOS-LAB | Provisioned | - |
| dc01 | l3leaf | dc01-le01a | 192.168.0.175/24 | vEOS-LAB | Provisioned | - |
| dc01 | l3leaf | dc01-le01b | 192.168.0.176/24 | vEOS-LAB | Provisioned | - |
| dc01 | l3leaf | dc01-le02a | 192.168.0.177/24 | vEOS-LAB | Provisioned | - |
| dc01 | l3leaf | dc01-le02b | 192.168.0.178/24 | vEOS-LAB | Provisioned | - |
| dc01 | l3leaf | dc01-le03a | 192.168.0.179/24 | vEOS-LAB | Provisioned | - |
| dc01 | l3leaf | dc01-le03b | 192.168.0.180/24 | vEOS-LAB | Provisioned | - |
| dc01 | spine | dc01-sp01 | 192.168.0.181/24 | vEOS-LAB | Provisioned | - |
| dc01 | spine | dc01-sp02 | 192.168.0.182/24 | vEOS-LAB | Provisioned | - |
| dc01 | l3leaf | dc01-srv01a | 192.168.0.191/24 | vEOS-LAB | Provisioned | - |
| dc01 | l3leaf | dc01-srv01b | 192.168.0.192/24 | vEOS-LAB | Provisioned | - |
| dc02 | firewall | dc02-fw01 | 192.168.0.153/24 | vEOS-LAB | Provisioned | - |
| dc02 | firewall | dc02-fw02 | 192.168.0.168/24 | vEOS-LAB | Provisioned | - |
| dc02 | l3leaf | dc02-gw01a | 192.168.0.195/24 | vEOS-LAB | Provisioned | - |
| dc02 | l3leaf | dc02-gw01b | 192.168.0.196/24 | vEOS-LAB | Provisioned | - |
| dc02 | l3leaf | dc02-le01a | 192.168.0.185/24 | vEOS-LAB | Provisioned | - |
| dc02 | l3leaf | dc02-le01b | 192.168.0.186/24 | vEOS-LAB | Provisioned | - |
| dc02 | l3leaf | dc02-le02a | 192.168.0.187/24 | vEOS-LAB | Provisioned | - |
| dc02 | l3leaf | dc02-le02b | 192.168.0.188/24 | vEOS-LAB | Provisioned | - |
| dc02 | spine | dc02-sp01 | 192.168.0.189/24 | vEOS-LAB | Provisioned | - |
| dc02 | spine | dc02-sp02 | 192.168.0.190/24 | vEOS-LAB | Provisioned | - |
| dc02 | l3leaf | dc02-srv01a | 192.168.0.193/24 | vEOS-LAB | Provisioned | - |
| dc02 | l3leaf | dc02-srv01b | 192.168.0.194/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server01 | 192.168.0.135/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server02 | 192.168.0.136/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server03 | 192.168.0.141/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server04 | 192.168.0.142/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server07 | 192.168.0.137/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server08 | 192.168.0.138/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server09 | 192.168.0.143/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server10 | 192.168.0.144/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server11 | 192.168.0.147/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server13 | 192.168.0.139/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server14 | 192.168.0.140/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server15 | 192.168.0.145/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server16 | 192.168.0.146/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server17 | 192.168.0.155/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server18 | 192.168.0.156/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server19 | 192.168.0.161/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server20 | 192.168.0.162/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server22 | 192.168.0.157/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server23 | 192.168.0.158/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server24 | 192.168.0.163/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server25 | 192.168.0.164/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server27 | 192.168.0.159/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server28 | 192.168.0.160/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server29 | 192.168.0.165/24 | vEOS-LAB | Provisioned | - |
| acme_fabric | server | server30 | 192.168.0.166/24 | vEOS-LAB | Provisioned | - |

> Provision status is based on Ansible inventory declaration and do not represent real status from CloudVision.

### Fabric Switches with inband Management IP

| POD | Type | Node | Management IP | Inband Interface |
| --- | ---- | ---- | ------------- | ---------------- |

## Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | ----------| -------------- |
| l3leaf | dc01-gw01a | Ethernet1 | spine | dc01-sp01 | Ethernet11 |
| l3leaf | dc01-gw01a | Ethernet2 | spine | dc01-sp02 | Ethernet11 |
| l3leaf | dc01-gw01a | Ethernet25 | l3leaf | dc02-gw01a | Ethernet25 |
| l3leaf | dc01-gw01a | Ethernet31 | mlag_peer | dc01-gw01b | Ethernet31 |
| l3leaf | dc01-gw01a | Ethernet32 | mlag_peer | dc01-gw01b | Ethernet32 |
| l3leaf | dc01-gw01b | Ethernet1 | spine | dc01-sp01 | Ethernet12 |
| l3leaf | dc01-gw01b | Ethernet2 | spine | dc01-sp02 | Ethernet12 |
| l3leaf | dc01-gw01b | Ethernet26 | l3leaf | dc02-gw01b | Ethernet26 |
| l3leaf | dc01-le01a | Ethernet1 | spine | dc01-sp01 | Ethernet1 |
| l3leaf | dc01-le01a | Ethernet2 | spine | dc01-sp02 | Ethernet1 |
| l3leaf | dc01-le01a | Ethernet3 | server | server01 | Ethernet1 |
| l3leaf | dc01-le01a | Ethernet4 | server | server02 | Ethernet1 |
| l3leaf | dc01-le01a | Ethernet5 | server | server07 | Ethernet1 |
| l3leaf | dc01-le01a | Ethernet6 | server | server08 | Ethernet1 |
| l3leaf | dc01-le01a | Ethernet7 | server | server13 | Ethernet1 |
| l3leaf | dc01-le01a | Ethernet8 | server | server14 | Ethernet1 |
| l3leaf | dc01-le01a | Ethernet31 | mlag_peer | dc01-le01b | Ethernet31 |
| l3leaf | dc01-le01a | Ethernet32 | mlag_peer | dc01-le01b | Ethernet32 |
| l3leaf | dc01-le01b | Ethernet1 | spine | dc01-sp01 | Ethernet2 |
| l3leaf | dc01-le01b | Ethernet2 | spine | dc01-sp02 | Ethernet2 |
| l3leaf | dc01-le01b | Ethernet3 | server | server01 | Ethernet2 |
| l3leaf | dc01-le01b | Ethernet4 | server | server02 | Ethernet2 |
| l3leaf | dc01-le01b | Ethernet5 | server | server07 | Ethernet2 |
| l3leaf | dc01-le01b | Ethernet6 | server | server08 | Ethernet2 |
| l3leaf | dc01-le01b | Ethernet7 | server | server13 | Ethernet2 |
| l3leaf | dc01-le01b | Ethernet8 | server | server14 | Ethernet2 |
| l3leaf | dc01-le02a | Ethernet1 | spine | dc01-sp01 | Ethernet3 |
| l3leaf | dc01-le02a | Ethernet2 | spine | dc01-sp02 | Ethernet3 |
| l3leaf | dc01-le02a | Ethernet3 | server | server03 | Ethernet1 |
| l3leaf | dc01-le02a | Ethernet4 | server | server04 | Ethernet1 |
| l3leaf | dc01-le02a | Ethernet5 | server | server09 | Ethernet1 |
| l3leaf | dc01-le02a | Ethernet6 | server | server10 | Ethernet1 |
| l3leaf | dc01-le02a | Ethernet7 | server | server15 | Ethernet1 |
| l3leaf | dc01-le02a | Ethernet8 | server | server16 | Ethernet1 |
| l3leaf | dc01-le02a | Ethernet31 | mlag_peer | dc01-le02b | Ethernet31 |
| l3leaf | dc01-le02a | Ethernet32 | mlag_peer | dc01-le02b | Ethernet32 |
| l3leaf | dc01-le02b | Ethernet1 | spine | dc01-sp01 | Ethernet4 |
| l3leaf | dc01-le02b | Ethernet2 | spine | dc01-sp02 | Ethernet4 |
| l3leaf | dc01-le02b | Ethernet3 | server | server03 | Ethernet2 |
| l3leaf | dc01-le02b | Ethernet4 | server | server04 | Ethernet2 |
| l3leaf | dc01-le02b | Ethernet5 | server | server09 | Ethernet2 |
| l3leaf | dc01-le02b | Ethernet6 | server | server10 | Ethernet2 |
| l3leaf | dc01-le02b | Ethernet7 | server | server15 | Ethernet2 |
| l3leaf | dc01-le02b | Ethernet8 | server | server16 | Ethernet2 |
| l3leaf | dc01-le03a | Ethernet1 | spine | dc01-sp01 | Ethernet5 |
| l3leaf | dc01-le03a | Ethernet2 | spine | dc01-sp02 | Ethernet5 |
| l3leaf | dc01-le03a | Ethernet3 | server | server11 | Ethernet1 |
| l3leaf | dc01-le03b | Ethernet1 | spine | dc01-sp01 | Ethernet6 |
| l3leaf | dc01-le03b | Ethernet2 | spine | dc01-sp02 | Ethernet6 |
| l3leaf | dc01-le03b | Ethernet3 | server | server11 | Ethernet2 |
| spine | dc01-sp01 | Ethernet9 | l3leaf | dc01-srv01a | Ethernet1 |
| spine | dc01-sp01 | Ethernet10 | l3leaf | dc01-srv01b | Ethernet1 |
| spine | dc01-sp02 | Ethernet9 | l3leaf | dc01-srv01a | Ethernet2 |
| spine | dc01-sp02 | Ethernet10 | l3leaf | dc01-srv01b | Ethernet2 |
| l3leaf | dc01-srv01a | Ethernet27 | firewall | dc01_fw01 | Ethernet1 |
| l3leaf | dc01-srv01a | Ethernet28 | firewall | dc01_fw02 | Ethernet1 |
| l3leaf | dc01-srv01a | Ethernet31 | mlag_peer | dc01-srv01b | Ethernet31 |
| l3leaf | dc01-srv01a | Ethernet32 | mlag_peer | dc01-srv01b | Ethernet32 |
| l3leaf | dc01-srv01b | Ethernet27 | firewall | dc01_fw01 | Ethernet2 |
| l3leaf | dc01-srv01b | Ethernet28 | firewall | dc01_fw02 | Ethernet2 |
| l3leaf | dc02-gw01a | Ethernet1 | spine | dc02-sp01 | Ethernet11 |
| l3leaf | dc02-gw01a | Ethernet2 | spine | dc02-sp02 | Ethernet11 |
| l3leaf | dc02-gw01a | Ethernet31 | mlag_peer | dc02-gw01b | Ethernet31 |
| l3leaf | dc02-gw01a | Ethernet32 | mlag_peer | dc02-gw01b | Ethernet32 |
| l3leaf | dc02-gw01b | Ethernet1 | spine | dc02-sp01 | Ethernet12 |
| l3leaf | dc02-gw01b | Ethernet2 | spine | dc02-sp02 | Ethernet12 |
| l3leaf | dc02-le01a | Ethernet1 | spine | dc02-sp01 | Ethernet1 |
| l3leaf | dc02-le01a | Ethernet2 | spine | dc02-sp02 | Ethernet1 |
| l3leaf | dc02-le01a | Ethernet3 | server | server17 | Ethernet1 |
| l3leaf | dc02-le01a | Ethernet4 | server | server18 | Ethernet1 |
| l3leaf | dc02-le01a | Ethernet5 | server | server22 | Ethernet1 |
| l3leaf | dc02-le01a | Ethernet6 | server | server23 | Ethernet1 |
| l3leaf | dc02-le01a | Ethernet7 | server | server27 | Ethernet1 |
| l3leaf | dc02-le01a | Ethernet8 | server | server28 | Ethernet1 |
| l3leaf | dc02-le01a | Ethernet31 | mlag_peer | dc02-le01b | Ethernet31 |
| l3leaf | dc02-le01a | Ethernet32 | mlag_peer | dc02-le01b | Ethernet32 |
| l3leaf | dc02-le01b | Ethernet1 | spine | dc02-sp01 | Ethernet2 |
| l3leaf | dc02-le01b | Ethernet2 | spine | dc02-sp02 | Ethernet2 |
| l3leaf | dc02-le01b | Ethernet3 | server | server17 | Ethernet2 |
| l3leaf | dc02-le01b | Ethernet4 | server | server18 | Ethernet2 |
| l3leaf | dc02-le01b | Ethernet5 | server | server22 | Ethernet2 |
| l3leaf | dc02-le01b | Ethernet6 | server | server23 | Ethernet2 |
| l3leaf | dc02-le01b | Ethernet7 | server | server27 | Ethernet2 |
| l3leaf | dc02-le01b | Ethernet8 | server | server28 | Ethernet2 |
| l3leaf | dc02-le02a | Ethernet1 | spine | dc02-sp01 | Ethernet3 |
| l3leaf | dc02-le02a | Ethernet2 | spine | dc02-sp02 | Ethernet3 |
| l3leaf | dc02-le02a | Ethernet3 | server | server19 | Ethernet1 |
| l3leaf | dc02-le02a | Ethernet4 | server | server20 | Ethernet1 |
| l3leaf | dc02-le02a | Ethernet5 | server | server24 | Ethernet1 |
| l3leaf | dc02-le02a | Ethernet6 | server | server25 | Ethernet1 |
| l3leaf | dc02-le02a | Ethernet7 | server | server29 | Ethernet1 |
| l3leaf | dc02-le02a | Ethernet8 | server | server30 | Ethernet1 |
| l3leaf | dc02-le02a | Ethernet31 | mlag_peer | dc02-le02b | Ethernet31 |
| l3leaf | dc02-le02a | Ethernet32 | mlag_peer | dc02-le02b | Ethernet32 |
| l3leaf | dc02-le02b | Ethernet1 | spine | dc02-sp01 | Ethernet4 |
| l3leaf | dc02-le02b | Ethernet2 | spine | dc02-sp02 | Ethernet4 |
| l3leaf | dc02-le02b | Ethernet3 | server | server19 | Ethernet2 |
| l3leaf | dc02-le02b | Ethernet4 | server | server20 | Ethernet2 |
| l3leaf | dc02-le02b | Ethernet5 | server | server24 | Ethernet2 |
| l3leaf | dc02-le02b | Ethernet6 | server | server25 | Ethernet2 |
| l3leaf | dc02-le02b | Ethernet7 | server | server29 | Ethernet2 |
| l3leaf | dc02-le02b | Ethernet8 | server | server30 | Ethernet2 |
| spine | dc02-sp01 | Ethernet9 | l3leaf | dc02-srv01a | Ethernet1 |
| spine | dc02-sp01 | Ethernet10 | l3leaf | dc02-srv01b | Ethernet1 |
| spine | dc02-sp02 | Ethernet9 | l3leaf | dc02-srv01a | Ethernet2 |
| spine | dc02-sp02 | Ethernet10 | l3leaf | dc02-srv01b | Ethernet2 |
| l3leaf | dc02-srv01a | Ethernet27 | firewall | dc02_fw01 | Ethernet1 |
| l3leaf | dc02-srv01a | Ethernet28 | firewall | dc02_fw02 | Ethernet1 |
| l3leaf | dc02-srv01a | Ethernet31 | mlag_peer | dc02-srv01b | Ethernet31 |
| l3leaf | dc02-srv01a | Ethernet32 | mlag_peer | dc02-srv01b | Ethernet32 |
| l3leaf | dc02-srv01b | Ethernet27 | firewall | dc02_fw01 | Ethernet2 |
| l3leaf | dc02-srv01b | Ethernet28 | firewall | dc02_fw02 | Ethernet2 |

## Fabric IP Allocation

### Fabric Point-To-Point Links

| Uplink IPv4 Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ---------------- | ------------------- | ------------------ | ------------------ |
| 10.0.9.0/24 | 256 | 40 | 15.63 % |
| 10.0.10.0/24 | 256 | 32 | 12.5 % |

### Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |
| dc01-gw01a | Ethernet1 | 10.0.9.81/31 | dc01-sp01 | Ethernet11 | 10.0.9.80/31 |
| dc01-gw01a | Ethernet2 | 10.0.9.83/31 | dc01-sp02 | Ethernet11 | 10.0.9.82/31 |
| dc01-gw01a | Ethernet25 | 10.0.0.0/31 | dc02-gw01a | Ethernet25 | 10.0.0.1/31 |
| dc01-gw01b | Ethernet1 | 10.0.9.89/31 | dc01-sp01 | Ethernet12 | 10.0.9.88/31 |
| dc01-gw01b | Ethernet2 | 10.0.9.91/31 | dc01-sp02 | Ethernet12 | 10.0.9.90/31 |
| dc01-gw01b | Ethernet26 | 10.0.0.2/31 | dc02-gw01b | Ethernet26 | 10.0.0.3/31 |
| dc01-le01a | Ethernet1 | 10.0.9.17/31 | dc01-sp01 | Ethernet1 | 10.0.9.16/31 |
| dc01-le01a | Ethernet2 | 10.0.9.19/31 | dc01-sp02 | Ethernet1 | 10.0.9.18/31 |
| dc01-le01b | Ethernet1 | 10.0.9.25/31 | dc01-sp01 | Ethernet2 | 10.0.9.24/31 |
| dc01-le01b | Ethernet2 | 10.0.9.27/31 | dc01-sp02 | Ethernet2 | 10.0.9.26/31 |
| dc01-le02a | Ethernet1 | 10.0.9.33/31 | dc01-sp01 | Ethernet3 | 10.0.9.32/31 |
| dc01-le02a | Ethernet2 | 10.0.9.35/31 | dc01-sp02 | Ethernet3 | 10.0.9.34/31 |
| dc01-le02b | Ethernet1 | 10.0.9.41/31 | dc01-sp01 | Ethernet4 | 10.0.9.40/31 |
| dc01-le02b | Ethernet2 | 10.0.9.43/31 | dc01-sp02 | Ethernet4 | 10.0.9.42/31 |
| dc01-le03a | Ethernet1 | 10.0.9.49/31 | dc01-sp01 | Ethernet5 | 10.0.9.48/31 |
| dc01-le03a | Ethernet2 | 10.0.9.51/31 | dc01-sp02 | Ethernet5 | 10.0.9.50/31 |
| dc01-le03b | Ethernet1 | 10.0.9.57/31 | dc01-sp01 | Ethernet6 | 10.0.9.56/31 |
| dc01-le03b | Ethernet2 | 10.0.9.59/31 | dc01-sp02 | Ethernet6 | 10.0.9.58/31 |
| dc01-sp01 | Ethernet9 | 10.0.9.64/31 | dc01-srv01a | Ethernet1 | 10.0.9.65/31 |
| dc01-sp01 | Ethernet10 | 10.0.9.72/31 | dc01-srv01b | Ethernet1 | 10.0.9.73/31 |
| dc01-sp02 | Ethernet9 | 10.0.9.66/31 | dc01-srv01a | Ethernet2 | 10.0.9.67/31 |
| dc01-sp02 | Ethernet10 | 10.0.9.74/31 | dc01-srv01b | Ethernet2 | 10.0.9.75/31 |
| dc02-gw01a | Ethernet1 | 10.0.10.65/31 | dc02-sp01 | Ethernet11 | 10.0.10.64/31 |
| dc02-gw01a | Ethernet2 | 10.0.10.67/31 | dc02-sp02 | Ethernet11 | 10.0.10.66/31 |
| dc02-gw01b | Ethernet1 | 10.0.10.73/31 | dc02-sp01 | Ethernet12 | 10.0.10.72/31 |
| dc02-gw01b | Ethernet2 | 10.0.10.75/31 | dc02-sp02 | Ethernet12 | 10.0.10.74/31 |
| dc02-le01a | Ethernet1 | 10.0.10.17/31 | dc02-sp01 | Ethernet1 | 10.0.10.16/31 |
| dc02-le01a | Ethernet2 | 10.0.10.19/31 | dc02-sp02 | Ethernet1 | 10.0.10.18/31 |
| dc02-le01b | Ethernet1 | 10.0.10.25/31 | dc02-sp01 | Ethernet2 | 10.0.10.24/31 |
| dc02-le01b | Ethernet2 | 10.0.10.27/31 | dc02-sp02 | Ethernet2 | 10.0.10.26/31 |
| dc02-le02a | Ethernet1 | 10.0.10.33/31 | dc02-sp01 | Ethernet3 | 10.0.10.32/31 |
| dc02-le02a | Ethernet2 | 10.0.10.35/31 | dc02-sp02 | Ethernet3 | 10.0.10.34/31 |
| dc02-le02b | Ethernet1 | 10.0.10.41/31 | dc02-sp01 | Ethernet4 | 10.0.10.40/31 |
| dc02-le02b | Ethernet2 | 10.0.10.43/31 | dc02-sp02 | Ethernet4 | 10.0.10.42/31 |
| dc02-sp01 | Ethernet9 | 10.0.10.48/31 | dc02-srv01a | Ethernet1 | 10.0.10.49/31 |
| dc02-sp01 | Ethernet10 | 10.0.10.56/31 | dc02-srv01b | Ethernet1 | 10.0.10.57/31 |
| dc02-sp02 | Ethernet9 | 10.0.10.50/31 | dc02-srv01a | Ethernet2 | 10.0.10.51/31 |
| dc02-sp02 | Ethernet10 | 10.0.10.58/31 | dc02-srv01b | Ethernet2 | 10.0.10.59/31 |

### Loopback Interfaces (BGP EVPN Peering)

| Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------- | ------------------- | ------------------ | ------------------ |
| 10.0.0.24/29 | 8 | 2 | 25.0 % |
| 10.0.0.40/29 | 8 | 2 | 25.0 % |
| 10.0.2.0/24 | 256 | 12 | 4.69 % |
| 10.0.4.0/24 | 256 | 10 | 3.91 % |
| 10.248.0.0/24 | 256 | 25 | 9.77 % |

### Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| dc01 | dc01-fw01 | 10.0.0.25/32 |
| dc01 | dc01-fw02 | 10.0.0.26/32 |
| dc01 | dc01-gw01a | 10.0.2.15/32 |
| dc01 | dc01-gw01b | 10.0.2.16/32 |
| dc01 | dc01-le01a | 10.0.2.7/32 |
| dc01 | dc01-le01b | 10.0.2.8/32 |
| dc01 | dc01-le02a | 10.0.2.9/32 |
| dc01 | dc01-le02b | 10.0.2.10/32 |
| dc01 | dc01-le03a | 10.0.2.11/32 |
| dc01 | dc01-le03b | 10.0.2.12/32 |
| dc01 | dc01-sp01 | 10.0.2.1/32 |
| dc01 | dc01-sp02 | 10.0.2.2/32 |
| dc01 | dc01-srv01a | 10.0.2.13/32 |
| dc01 | dc01-srv01b | 10.0.2.14/32 |
| dc02 | dc02-fw01 | 10.0.0.41/32 |
| dc02 | dc02-fw02 | 10.0.0.42/32 |
| dc02 | dc02-gw01a | 10.0.4.13/32 |
| dc02 | dc02-gw01b | 10.0.4.14/32 |
| dc02 | dc02-le01a | 10.0.4.7/32 |
| dc02 | dc02-le01b | 10.0.4.8/32 |
| dc02 | dc02-le02a | 10.0.4.9/32 |
| dc02 | dc02-le02b | 10.0.4.10/32 |
| dc02 | dc02-sp01 | 10.0.4.1/32 |
| dc02 | dc02-sp02 | 10.0.4.2/32 |
| dc02 | dc02-srv01a | 10.0.4.11/32 |
| dc02 | dc02-srv01b | 10.0.4.12/32 |
| acme_fabric | server01 | 10.248.0.1/32 |
| acme_fabric | server02 | 10.248.0.2/32 |
| acme_fabric | server03 | 10.248.0.3/32 |
| acme_fabric | server04 | 10.248.0.4/32 |
| acme_fabric | server07 | 10.248.0.7/32 |
| acme_fabric | server08 | 10.248.0.8/32 |
| acme_fabric | server09 | 10.248.0.9/32 |
| acme_fabric | server10 | 10.248.0.10/32 |
| acme_fabric | server11 | 10.248.0.11/32 |
| acme_fabric | server13 | 10.248.0.13/32 |
| acme_fabric | server14 | 10.248.0.14/32 |
| acme_fabric | server15 | 10.248.0.15/32 |
| acme_fabric | server16 | 10.248.0.16/32 |
| acme_fabric | server17 | 10.248.0.17/32 |
| acme_fabric | server18 | 10.248.0.18/32 |
| acme_fabric | server19 | 10.248.0.19/32 |
| acme_fabric | server20 | 10.248.0.20/32 |
| acme_fabric | server22 | 10.248.0.22/32 |
| acme_fabric | server23 | 10.248.0.23/32 |
| acme_fabric | server24 | 10.248.0.24/32 |
| acme_fabric | server25 | 10.248.0.25/32 |
| acme_fabric | server27 | 10.248.0.27/32 |
| acme_fabric | server28 | 10.248.0.28/32 |
| acme_fabric | server29 | 10.248.0.29/32 |
| acme_fabric | server30 | 10.248.0.30/32 |

### VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)

| VTEP Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| --------------------- | ------------------- | ------------------ | ------------------ |
| 10.0.3.0/24 | 256 | 10 | 3.91 % |
| 10.0.5.0/24 | 256 | 8 | 3.13 % |

### VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
| dc01 | dc01-gw01a | 10.0.3.15/32 |
| dc01 | dc01-gw01b | 10.0.3.15/32 |
| dc01 | dc01-le01a | 10.0.3.7/32 |
| dc01 | dc01-le01b | 10.0.3.7/32 |
| dc01 | dc01-le02a | 10.0.3.9/32 |
| dc01 | dc01-le02b | 10.0.3.9/32 |
| dc01 | dc01-le03a | 10.0.3.11/32 |
| dc01 | dc01-le03b | 10.0.3.12/32 |
| dc01 | dc01-srv01a | 10.0.3.13/32 |
| dc01 | dc01-srv01b | 10.0.3.13/32 |
| dc02 | dc02-gw01a | 10.0.5.13/32 |
| dc02 | dc02-gw01b | 10.0.5.13/32 |
| dc02 | dc02-le01a | 10.0.5.7/32 |
| dc02 | dc02-le01b | 10.0.5.7/32 |
| dc02 | dc02-le02a | 10.0.5.9/32 |
| dc02 | dc02-le02b | 10.0.5.9/32 |
| dc02 | dc02-srv01a | 10.0.5.11/32 |
| dc02 | dc02-srv01b | 10.0.5.11/32 |
