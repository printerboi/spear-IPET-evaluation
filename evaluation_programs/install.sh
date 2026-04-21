#! /bin/bash

# Installing Section

echo "Downloading evaluation programs..."

if not [ -d "dependencies" ]; then
    echo "dependencies dir does not exist, creating temporary directory..."
    mkdir dependencies/
    mkdir dependencies/download
else
    echo "dependencies exists, skipping creation."
fi

echo "(1/X) Installing Libsodium"

[ ! -f "dependencies/download/libsodium.tar.gz" ] && curl --output dependencies/download/libsodium.tar.gz "https://download.libsodium.org/libsodium/releases/libsodium-1.0.22.tar.gz"
if [ ! -d "dependencies/libsodium-1.0.22" ]; then
    tar -xzf dependencies/download/libsodium.tar.gz -C dependencies/
    cd dependencies/libsodium-1.0.22 && ./configure
fi


# BUILDING Section


echo "(7/X) Building Libsodium"
mkdir -p dependencies/.build/libsodium
cd Libsodium && make libsodium