#!/usr/bin/env bash

set -e
set -u
set -x

apt update -q
apt install -y gnupg ca-certificates

# gpg settings should be set through this file rather than on the cli :/
cat <<EOF > dirmngr.conf
keyserver hkps://keyserver.ubuntu.com
EOF

# build.openvpn.net gpg key http://keyserver.ubuntu.com/pks/lookup?search=8E6DA8B4E158C569&fingerprint=on&op=index
gpg --options /dirmngr.conf --recv-keys 30EBF4E73CCE63EEE124DD278E6DA8B4E158C569
gpg --export 30EBF4E73CCE63EEE124DD278E6DA8B4E158C569 > /usr/share/keyrings/buildopenvpnnet.gpg

# add openvpn repo for jammy 22.04
# commented this out for now due to the following:
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/buildopenvpnnet.gpg] http://build.openvpn.net/debian/openvpn/stable focal main" > /etc/apt/sources.list.d/openvpn-aptrepo.list

apt-get update -q
apt-get install openvpn -y

apt-get clean
apt-get -y -q autoclean
apt-get -y -q autoremove
rm -rf /tmp/*
