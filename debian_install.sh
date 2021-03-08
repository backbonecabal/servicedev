# install some prerequisites needed by adding GPG public keys (could be removed later)
sudo apt-get -y install --no-install-recommends wget gnupg ca-certificates

# import openresty GPG key:
wget -O - https://openresty.org/package/pubkey.gpg | sudo apt-key add -

# add the openresty official APT repository:
codename=`grep -Po 'VERSION="[0-9]+ \(\K[^)]+' /etc/os-release`

echo "deb http://openresty.org/package/debian $codename openresty" \
    | sudo tee /etc/apt/sources.list.d/openresty.list

# to update the APT index:
sudo apt-get update

sudo apt-get -y install openresty