#!/bin/sh

ANDROID_NDK=/home/xshl5/Android/android-ndk-r16b
TOOLCHAIN_PATH=`pwd`/toolchain
APP_PLATFORM=android-24

echo "--------------------"
echo "[*] make NDK standalone toolchain"
echo "--------------------"
TOOLCHAIN_TOUCH="$TOOLCHAIN_PATH/touch"
if [ ! -f "$TOOLCHAIN_TOUCH" ]; then
    $ANDROID_NDK/build/tools/make-standalone-toolchain.sh \
        --install-dir=$TOOLCHAIN_PATH \
        --platform=$APP_PLATFORM \
        --toolchain=aarch64-linux-android-4.9 \
#        --system=linux-x86_64
    touch $TOOLCHAIN_TOUCH;
fi

SYSROOT=$TOOLCHAIN_PATH/sysroot

# User specific environment and startup programs
PATH=$TOOLCHAIN_PATH/bin:$PATH

# Tell configure what tools to use.
BUILD_TARGET_HOST=aarch64-linux-android
AR=$BUILD_TARGET_HOST-ar
AS=$BUILD_TARGET_HOST-as
CC=$BUILD_TARGET_HOST-gcc
CXX=$BUILD_TARGET_HOST-g++
LD=$BUILD_TARGET_HOST-ld
STRIP=$BUILD_TARGET_HOST-strip
RANLIB=$BUILD_TARGET_HOST-ranlib

# Tell configure what flags Android requires.
CFLAGS="-O3 -pipe -fPIE -fPIC --sysroot=$SYSROOT"
LDFLAGS="-pie"

# For libcap lib
LIBCAP_DIR=`pwd`/libcap
CFLAGS="$CFLAGS -I$LIBCAP_DIR/include"
LDFLAGS="$LDFLAGS -L$LIBCAP_DIR/lib"

# SELinux specifics
#BASEDIR=$(pwd)
#ANDROID_LIBS="$BASEDIR/../android-libs/arm_64"
#CFLAGS="$CFLAGS -I$ANDROID_LIBS/include"
#LDFLAGS="$LDFLAGS -L$ANDROID_LIBS/lib"

#ODMDIR=/odm

CBA_HOME=`pwd`/build_lxc
PREFIX=$CBA_HOME

CFLAGS=$CFLAGS \
LDFLAGS=$LDFLAGS \
./configure --target=linux-android --host=aarch64-linux-android --with-sysroot=$SYSROOT --enable-shared=yes --enable-static=yes \
	--disable-api-docs \
	--disable-selinux \
	--enable-capabilities \
	--disable-examples \
	--disable-lua \
	--disable-python \
	--disable-bash \
	--enable-configpath-log \
        \
        --disable-doc \
        --disable-api-docs \
	\
	--prefix=$PREFIX \
	--with-systemdsystemunitdir=$PREFIX/lib/systemd/system \
	--with-config-path=$CBA_HOME/containers \
	--with-global-conf=$CBA_HOME/.config \
	--with-runtime-path=/cache
	
make clean
make -j2
make install
