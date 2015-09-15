#!/bin/bash
# ============================================================================
# Script for setting up a minimized SUSE 11 SP4 based on JeOS
#
# Author:  Marius Storm-Olsen <mstormo@gmail.com>
# ============================================================================

# add repos to image to make it easier to use the base image later
zypper ar http://download.opensuse.org/distribution/11.4/repo/oss/ OSS
zypper ar http://download.opensuse.org/update/11.4/ Update

zypper ar http://download.opensuse.org/source/distribution/11.4/repo/oss/ Src-OSS
zypper ar http://download.opensuse.org/repositories/openSUSE:/11.4:/Contrib/standard/ Contrib

zypper ar http://download.opensuse.org/repositories/Java:/packages/SLE_11/ Java



# remove any IPv6 from /etc/hosts since zypper will fail on IPv6 resolved names
echo 127.0.0.1       localhost > /etc/hosts

# remove packages not needed for base image
rpm -ev --noscripts \
    bootsplash branding-SLES bridge-utils cron dhcpcd e2fsprogs elfutils file freetype2 gawk \
    gpg-pubkey-307e3d54-53287cdc gpg-pubkey-39db7c82-510a966b gpg-pubkey-3d25d3d9-36e12d04 \
    gpg-pubkey-50a3dd1c-50f35137 gpg-pubkey-9c800aca-53287d18 gpg-pubkey-b37b98a9-5328792f grub \
    ifplugd initviocons iproute2 iputils irqbalance kbd kernel-default \
    kernel-default-base klogd lcms less libaio libasm1 libdw1 libelf1 libext2fs2 \
    libgssglue1 libjpeg liblcms1 libmng libnet libnuma1 libtiff3 libtirpc1 \
    logrotate mdadm mkinitrd module-init-tools netcfg openldap2-client \
    openssl-certs perl-Bootloader perl-satsolver perl-XML-Parser \
    perl-XML-Simple postfix rpcbind suse-build-key \
    suse-sam suse-sam-data sysconfig sysfsutils syslog-ng tar timezone tunctl \
    update-alternatives vim-base vlan xz
zypper clean --all

# remove boot, as it's not used in Docker
rm -rf /boot
