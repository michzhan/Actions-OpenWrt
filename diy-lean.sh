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

# ========================
# replace default package

cat << EOF > pkg_default.txt
# Default packages - the really basic set
DEFAULT_PACKAGES:=base-files libc libgcc busybox dropbear mtd uci opkg netifd fstools uclient-fetch logd \
kmod-nf-nathelper kmod-nf-nathelper-extra kmod-ipt-raw wget curl \
default-settings luci luci-app-ddns luci-app-sqm luci-app-upnp \
luci-app-filetransfer \
luci-app-arpbind luci-app-wol luci-app-ramfree \
luci-app-sfe luci-app-flowoffload luci-app-nlbwmon
# For nas targets
DEFAULT_PACKAGES.nas:=block-mount fdisk lsblk mdadm automount
# For router targets
DEFAULT_PACKAGES.router:=dnsmasq-full iptables ip6tables ppp ppp-mod-pppoe firewall kmod-ipt-offload kmod-tcp-bbr odhcpd-ipv6only odhcp6c
DEFAULT_PACKAGES.bootloader:=
EOF

cat include/target.mk | sed "/^# Default packages/,/DEFAULT_PACKAGES.bootloader:=$/s/.*/#ZZZZZ/" > tmp1
sed '$!N; /^\(.*\)\n\1$/!P; D'  tmp1 > tmp2
sed '/#ZZZZZ/r pkg_default.txt' tmp2 > tmp3
mv include/target.mk include/target.mk.old
mv tmp3 include/target.mk
rm -rf tmp1 tmp2

# =======================
