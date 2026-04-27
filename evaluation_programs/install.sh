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

echo "(2/X) Installing SQLite"

[ ! -f "_dependencies/download/sqlite3.zip" ] && curl --output _dependencies/download/sqlite3.zip "https://sqlite.org/2025/sqlite-amalgamation-3500400.zip"
if [ ! -d "_dependencies/sqlite" ]; then
    unzip -q _dependencies/download/sqlite3.zip -d _dependencies/
    mv _dependencies/sqlite-amalgamation-3500400 _dependencies/sqlite
else
    echo "=> SQLite already satisfied. Continuing..."
fi

echo "(3/X) Installing cJson"

[ ! -f "_dependencies/download/cjson.zip" ] && curl -L --output _dependencies/download/cjson.zip "https://github.com/DaveGamble/cJSON/archive/refs/tags/v1.7.19.zip"
if [ ! -d "_dependencies/cjson" ]; then
    unzip -q _dependencies/download/cjson.zip -d _dependencies/
    mv _dependencies/cJSON-1.7.19 _dependencies/cJSON
else
    echo "=> SQLite already satisfied. Continuing..."
fi

echo "(4/X) Installing TinyXML2"

[ ! -f "_dependencies/download/tinyxml2.zip" ] && curl -L --output _dependencies/download/tinyxml2.zip "https://github.com/leethomason/tinyxml2/archive/refs/tags/11.0.0.zip"
if [ ! -d "_dependencies/tinyxml2" ]; then
    unzip -q _dependencies/download/tinyxml2.zip -d _dependencies/
    mv _dependencies/tinyxml2-11.0.0 _dependencies/tinyxml2
else
    echo "=> SQLite already satisfied. Continuing..."
fi

echo "(5/X) Installing STB"

if [ ! -d "_dependencies/stb" ]; then
    git clone https://github.com/nothings/stb.git _dependencies/stb
else
    echo "=> stb already satisfied. Continuing..."
fi

echo "(6/X) Installing uthash"

if [ ! -d "_dependencies/uthash" ]; then
    git clone https://github.com/troydhanson/uthash.git _dependencies/uthash
else
    echo "=> uthash already satisfied. Continuing..."
fi

echo "(6/X) Installing lz4"

if [ ! -d "_dependencies/lz4" ]; then
    git clone https://github.com/lz4/lz4.git _dependencies/lz4
else
    echo "=> lz4 already satisfied. Continuing..."
fi

echo "(7/X) Installing zlib"

if [ ! -d "_dependencies/zlib" ]; then
    git clone https://github.com/madler/zlib.git _dependencies/zlib
else
    echo "=> zlib already satisfied. Continuing..."
fi

echo "(8/X) Installing curl"

if [ ! -d "_dependencies/curl" ]; then
    git clone https://github.com/curl/curl.git _dependencies/curl
else
    echo "=> curl already satisfied. Continuing..."
fi

echo "(9/X) Installing libpng"

if [ ! -d "_dependencies/libpng" ]; then
    git clone https://github.com/pnggroup/libpng.git _dependencies/libpng
else
    echo "=> libpng already satisfied. Continuing..."
fi

# BUILDING Section


# if [ "$SKIPBUILD" = false ]; then
#     echo "(7/X) Building Libsodium"
#     mkdir -p _dependencies/.build/libsodium
#     cd Libsodium && make libsodium
# fi