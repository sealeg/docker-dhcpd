#!/bin/bash
set -e

if [ -z "$1" ]; then
    config_dir=/config
    if [ ! -d "$config_dir" ]; then
        printf '%s dir is not present.\n' $config_dir

        exit 1
    fi
    conf="$config_dir/dhcpd.conf"
    if [ ! -r $conf ]; then
        printf '%s is not readable.\n' $conf

        exit 1
    fi

    data_dir=/data
    if [ ! -d "$data_dir" ]; then
        printf '%s dir is not present.\n' $data_dir

        exit 1
    fi

    [ -e "$data_dir/dhcpd.leases" ] || touch "$data_dir/dhcpd.leases"
    chown -R dhcpd:dhcpd "$data_dir"
    if [ -e "$data_dir/dhcpd.leases~" ]; then
        chown dhcpd:dhcpd "$data_dir/dhcpd.leases~"
    fi

    exec /usr/sbin/dhcpd -4 -f -d \
        -cf "$conf" \
        -lf "$data_dir/dhcpd.leases" \
        -user dhcpd -group dhcpd \
        --no-pid
else
    exec "$@"
fi
