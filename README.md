### Add build dependencies
# pkg-config autogen libtool autoconf autotools
sudo apt-get install pkg-config autogen libtool autoconf autotools-dev

# lsb-release
sudo apt-get install lsb-release

### Building LXC for Android
./autogen.sh

# Setting NDK path yourself in build_lxc.sh, And building
./build_lxc.sh
