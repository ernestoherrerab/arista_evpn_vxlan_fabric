#!/bin/bash
echo "Starting Multicast Stream Receivers"
sudo ip route add  239.103.1.1 dev vlan301
sudo ip route add  239.103.1.2 dev vlan301
sudo ip route add  239.103.1.3 dev vlan301
iperf -s -u -B 239.103.1.1 -i 1 &
iperf -s -u -B 239.103.1.2 -i 1 &
iperf -s -u -B 239.103.1.3 -i 1 &

#chmod 755 mcast-receiver.sh