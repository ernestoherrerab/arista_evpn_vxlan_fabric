#!/bin/bash

#echo Starting Mutlticast Server Source  Streaming 239.103.1.1-3 for 60 seconds
echo "Starting Sources"
#adding routes in kernel to prefer et1 instead of ATD underlay interface
sudo ip route add  239.103.1.1 dev vlan101
sudo ip route add  239.103.1.2 dev vlan101
sudo ip route add  239.103.1.3 dev vlan101

for i in {1..3} ; do
  IP='239.103.1'
  IP=$IP.$i
  iperf -c $IP -u -b 0.125m -T 10 -t 60 -i 1 -&

done

#chmod 755 mcast-source.sh