#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
sed -i 's/192.168.1.1/10.10.10.123/g' package/base-files/files/bin/config_generate

# Modify max connection
sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
