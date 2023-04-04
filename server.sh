#!/bin/bash

# change value for your limit open files:
openfiles="2097152"
maxevents="1048576"

# backup .conf files:
cp -f /etc/security/limits.conf{,.bak}
cp -f /etc/systemd/system.conf{,.bak}
cp -f /etc/systemd/user.conf{,.bak}
cp -f /etc/sysctl.conf{,.bak}

# Global parameter
sh -c 'echo "* soft  nproc   '$openfiles'" >> /etc/security/limits.conf'
sh -c 'echo "* hard  nproc   '$openfiles'" >> /etc/security/limits.conf'
sh -c 'echo "* soft  nofile  '$openfiles'" >> /etc/security/limits.conf'
sh -c 'echo "* hard  nofile  '$openfiles'" >> /etc/security/limits.conf'
sh -c 'echo "root  soft  nproc   '$openfiles'" >> /etc/security/limits.conf'
sh -c 'echo "root  hard  nproc   '$openfiles'" >> /etc/security/limits.conf'
sh -c 'echo "root  soft  nofile  '$openfiles'" >> /etc/security/limits.conf'
sh -c 'echo "root  hard  nofile  '$openfiles'" >> /etc/security/limits.conf'
sh -c 'echo "DefaultLimitNOFILE='$openfiles'" >> /etc/systemd/system.conf'
sh -c 'echo "DefaultLimitNOFILE='$openfiles'" >> /etc/systemd/user.conf'

# File
sh -c 'echo "fs.file-max = '$openfiles'" >> /etc/sysctl.conf'
sh -c 'echo "fs.aio-max-nr = '$maxevents'" >> /etc/sysctl.conf'

# Do less swapping 10%
sh -c 'echo "vm.swappiness = 10" >> /etc/sysctl.conf'
sh -c 'echo "vm.dirty_ratio = 60" >> /etc/sysctl.conf'
sh -c 'echo "vm.dirty_background_ratio = 2" >> /etc/sysctl.conf'

### TUNING NETWORK PERFORMANCE ###
# Decrease the time default value for connections to keep alive
sh -c 'echo "net.ipv4.tcp_keepalive_time = 300" >> /etc/sysctl.conf'
sh -c 'echo "net.ipv4.tcp_keepalive_probes = 5" >> /etc/sysctl.conf'
sh -c 'echo "net.ipv4.tcp_keepalive_intvl = 15" >> /etc/sysctl.conf'

# Default Socket Receive Buffer
sh -c 'echo "net.core.rmem_default = 31457280" >> /etc/sysctl.conf'

# Maximum Socket Receive Buffer
sh -c 'echo "net.core.rmem_max = 33554432" >> /etc/sysctl.conf'

# Default Socket Send Buffer
sh -c 'echo "net.core.wmem_default = 31457280" >> /etc/sysctl.conf'

# Maximum Socket Send Buffer
sh -c 'echo "net.core.wmem_max = 33554432" >> /etc/sysctl.conf'

# Increase number of incoming connections
sh -c 'echo "net.core.somaxconn = 65535" >> /etc/sysctl.conf'

# Increase number of incoming connections backlog
sh -c 'echo "net.core.netdev_max_backlog = 65536" >> /etc/sysctl.conf'

# Increase the maximum amount of option memory buffers
sh -c 'echo "net.core.optmem_max = 25165824" >> /etc/sysctl.conf'

# Increase the maximum total buffer-space allocatable
# This is measured in units of pages (4096 bytes)
sh -c 'echo "net.ipv4.tcp_mem = 786432 1048576 26777216" >> /etc/sysctl.conf'
sh -c 'echo "net.ipv4.udp_mem = 65536 131072 262144" >> /etc/sysctl.conf'

# Increase the read-buffer space allocatable
sh -c 'echo "net.ipv4.tcp_rmem = 8192 87380 33554432" >> /etc/sysctl.conf'
sh -c 'echo "net.ipv4.udp_rmem_min = 16384" >> /etc/sysctl.conf'

# Increase the write-buffer-space allocatable
sh -c 'echo "net.ipv4.tcp_wmem = 8192 65536 33554432" >> /etc/sysctl.conf'
sh -c 'echo "net.ipv4.udp_wmem_min = 16384" >> /etc/sysctl.conf'
