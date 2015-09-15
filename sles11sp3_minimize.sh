#!/bin/bash
# ============================================================================
# Script for setting up a minimized SUSE 11 SP3 based on JeOS
#
# Author:  Marius Storm-Olsen <mstormo@gmail.com>
# ============================================================================

# add repos to image to make it easier to use the base image later
zypper ar http://demeter.uni-regensburg.de/SLES11SP3-x64/DVD1/ Dvd
zypper ar http://demeter.uni-regensburg.de/SLE11SP3-SDK-x64/DVD1/ SDK-Dvd

zypper ar http://demeter.uni-regensburg.de/repo/\$RCE/SLES11-SP3-Updates/sle-11-x86_64/ SP3-Updates
zypper ar http://demeter.uni-regensburg.de/repo/\$RCE/SLES11-SP3-Pool/sle-11-x86_64/    SP3-Pool

zypper ar http://demeter.uni-regensburg.de/repo/\$RCE/SLE11-SDK-SP3-Pool/sle-11-x86_64/    SDK-SP3-Pool
zypper ar http://demeter.uni-regensburg.de/repo/\$RCE/SLE11-SDK-SP3-Updates/sle-11-x86_64/ SDK-SP3-Updates


# remove any IPv6 from /etc/hosts since zypper will fail on IPv6 resolved names
echo 127.0.0.1       localhost > /etc/hosts

# remove packages not needed for base image
rpm -ev --noscripts \
    bootsplash branding-SLES bridge-utils cron dhcpcd e2fsprogs elfutils file freetype2 gawk \
    gpg-pubkey-307e3d54-53287cdc gpg-pubkey-39db7c82-510a966b gpg-pubkey-3d25d3d9-36e12d04 \
    gpg-pubkey-50a3dd1c-50f35137 gpg-pubkey-9c800aca-53287d18 gpg-pubkey-b37b98a9-5328792f grub \
    gpm hwinfo ifplugd initviocons iproute2 iputils irqbalance kbd kernel-default \
    kernel-default-base klogd lcms less libaio libasm1 libdw1 libelf1 libevent-1_4-2 libext2fs2 \
    libgssglue1 libjpeg liblcms1 libmng libnet libnuma1 libpython2_6-1_0 libtiff3 libtirpc1 \
    logrotate mdadm mkinitrd module-init-tools netcfg nfs-client nfsidmap openldap2-client \
    openssl-certs perl-Bootloader perl-satsolver perl-URI perl-WWW-Curl  perl-XML-Parser \
    perl-XML-Simple perl-XML-Writer postfix python-base release-notes-sles rpcbind suse-build-key \
    suse-sam suse-sam-data suseRegister sysconfig sysfsutils syslog-ng tar timezone tunctl \
    update-alternatives uuid-runtime vim vim-base vlan w3m xz
zypper clean --all

# remove boot, as it's not used in Docker
rm -rf /boot
