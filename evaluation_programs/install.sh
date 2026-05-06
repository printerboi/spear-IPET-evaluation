#! /bin/bash

# Installing Section

SKIPBUILD=true

echo "Downloading evaluation programs..."

if ! [ -d "_dependencies" ]; then
    echo "_dependencies dir does not exist, creating temporary directory..."
    mkdir _dependencies/
    mkdir _dependencies/download
else
    echo "_dependencies exists, skipping creation."
fi

echo "(1/X) Installing Libsodium"

[ ! -f "_dependencies/download/libsodium.tar.gz" ] && curl --output _dependencies/download/libsodium.tar.gz "https://download.libsodium.org/libsodium/releases/libsodium-1.0.22.tar.gz"
if [ ! -d "_dependencies/libsodium" ]; then
    tar -xzf _dependencies/download/libsodium.tar.gz -C _dependencies/
    mv _dependencies/libsodium-1.0.22 _dependencies/libsodium
    cd _dependencies/libsodium && ./configure
    cd ../..
else
    echo "=> Libsodium already satisfied"
fi

echo "(2/X) Installing cJson"

[ ! -f "_dependencies/download/cjson.zip" ] && curl -L --output _dependencies/download/cjson.zip "https://github.com/DaveGamble/cJSON/archive/refs/tags/v1.7.19.zip"
if [ ! -d "_dependencies/cjson" ]; then
    unzip -q _dependencies/download/cjson.zip -d _dependencies/
    mv _dependencies/cJSON-1.7.19 _dependencies/cJSON
else
    echo "=> SQLite already satisfied. Continuing..."
fi

echo "(3/X) Installing lz4"

if [ ! -d "_dependencies/lz4" ]; then
    git clone https://github.com/lz4/lz4.git _dependencies/lz4
else
    echo "=> lz4 already satisfied. Continuing..."
fi

echo "(4/X) Installing PathfindingLib"

if [ ! -d "_dependencies/PathfindingLib" ]; then
    git clone https://github.com/Bucephalus-Studios/PathfindingLib.git _dependencies/PathfindingLib
else
    echo "=> PathfindingLib already satisfied. Continuing..."
fi

echo "(5/X) Installing libtommath"

if [ ! -d "_dependencies/libtommath" ]; then
    git clone https://github.com/libtom/libtommath.git _dependencies/libtommath
else
    echo "=> libtommath already satisfied. Continuing..."
fi

echo "(6/X) Installing coreutils"

COREUTILS_VERSION="9.5"
COREUTILS_ARCHIVE="coreutils-${COREUTILS_VERSION}.tar.xz"
COREUTILS_URL="https://ftp.gnu.org/gnu/coreutils/${COREUTILS_ARCHIVE}"

[ ! -f "_dependencies/download/${COREUTILS_ARCHIVE}" ] && \
    curl -L --output "_dependencies/download/${COREUTILS_ARCHIVE}" "${COREUTILS_URL}"

if [ ! -d "_dependencies/coreutils" ]; then
    tar -xf "_dependencies/download/${COREUTILS_ARCHIVE}" -C _dependencies/
    mv "_dependencies/coreutils-${COREUTILS_VERSION}" _dependencies/coreutils

    cd _dependencies/coreutils
    ./configure CC=/usr/lib/llvm-17/bin/clang CFLAGS="-g -O0 -Xclang -disable-O0-optnone -fno-discard-value-names"
    cd ../..
else
    echo "=> coreutils already satisfied. Continuing..."
fi

# BUILDING Section


# if [ "$SKIPBUILD" = false ]; then
#     echo "(7/X) Building Libsodium"
#     mkdir -p _dependencies/.build/libsodium
#     cd Libsodium && make libsodium
# fi