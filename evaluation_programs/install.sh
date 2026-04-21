#! /bin/bash

# Installing Section

SKIPBUILD=true

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
    cd ../..
else
    echo "=> Libsodium already satisfied"
fi

echo "(2/X) Installing SQLite"

[ ! -f "dependencies/download/sqlite3.zip" ] && curl --output dependencies/download/sqlite3.zip "https://sqlite.org/2025/sqlite-amalgamation-3500400.zip"
if [ ! -d "dependencies/sqlite" ]; then
    unzip -q dependencies/download/sqlite3.zip -d dependencies/
    mv dependencies/sqlite-amalgamation-3500400 dependencies/sqlite
else
    echo "=> SQLite already satisfied. Continuing..."
fi


# BUILDING Section


if [ "$SKIPBUILD" = false ]; then
    echo "(7/X) Building Libsodium"
    mkdir -p dependencies/.build/libsodium
    cd Libsodium && make libsodium
fi