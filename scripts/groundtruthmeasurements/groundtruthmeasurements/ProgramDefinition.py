####################################################################
#
#               Program Definitions
#
####################################################################

"""
Contains all evaluation programs and their respective arguments and inputs
"""
program_definitions = [
    # Libsodium
    {
        "name": "asymmetricEncryption",
        "executeable": "../../evaluation_programs/Libsodium/.build/asymmetricEncryption",
        "args": [],
        "input": ""
    },
    {
        "name": "symmetricFileEncrypt",
        "executeable": "../../evaluation_programs/Libsodium/.build/symmetricFileEncrypt",
        "args": ["../../evaluation_programs/Libsodium/input/infile.txt", "../../evaluation_programs/Libsodium/input/outfile.txt"],
        "input": ""
    },
    {
        "name": "pwhash",
        "executeable": "../../evaluation_programs/Libsodium/.build/pwhash",
        "args": [],
        "input": ""
    },
    {
        "name": "signing",
        "executeable": "../../evaluation_programs/Libsodium/.build/signing",
        "args": [],
        "input": ""
    },
    {
        "name": "chachaEncryption",
        "executeable": "../../evaluation_programs/Libsodium/.build/chachaEncryption",
        "args": [],
        "input": ""
    },
    {
        "name": "chachaDecryption",
        "executeable": "../../evaluation_programs/Libsodium/.build/chachaDecryption",
        "args": [],
        "input": ""
    },
    {
        "name": "keyExchange",
        "executeable": "../../evaluation_programs/Libsodium/.build/keyExchange",
        "args": [],
        "input": ""
    },
    {
        "name": "mac",
        "executeable": "../../evaluation_programs/Libsodium/.build/mac",
        "args": [],
        "input": ""
    },
    # LZ4
    {
        "name": "blockCompression",
        "executeable": "../../evaluation_programs/lz4/.build/blockCompression",
        "args": [],
        "input": ""
    },
    {
        "name": "blockDeCompression",
        "executeable": "../../evaluation_programs/lz4/.build/blockDeCompression",
        "args": [],
        "input": ""
    },
    {
        "name": "fileCompression",
        "executeable": "../../evaluation_programs/lz4/.build/fileCompression",
        "args": ["../../evaluation_programs/lz4/input/infile.png", "../../evaluation_programs/lz4/input/outfile.txt"],
        "input": ""
    },
    {
        "name": "ringbufferCompression",
        "executeable": "../../evaluation_programs/lz4/.build/ringbufferCompression",
        "args": [],
        "input": ""
    },
    {
        "name": "dictionaryCompression",
        "executeable": "../../evaluation_programs/lz4/.build/dictionaryCompression",
        "args": [],
        "input": ""
    },
    # PathfindingLib
    {
        "name": "aStarEmpty",
        "executeable": "../../evaluation_programs/PathfindingLib/.build/aStarEmpty",
        "args": [],
        "input": ""
    },
    {
        "name": "aStarMaze",
        "executeable": "../../evaluation_programs/PathfindingLib/.build/aStarMaze",
        "args": [],
        "input": ""
    },
    {
        "name": "dijkstra",
        "executeable": "../../evaluation_programs/PathfindingLib/.build/dijkstra",
        "args": [],
        "input": ""
    },
    {
        "name": "bfs",
        "executeable": "../../evaluation_programs/PathfindingLib/.build/bfs",
        "args": [],
        "input": ""
    },
    {
        "name": "greedyBestFirst",
        "executeable": "../../evaluation_programs/PathfindingLib/.build/greedyBestFirst",
        "args": [],
        "input": ""
    },
    # Libtommath
    {
        "name": "addMul",
        "executeable": "../../evaluation_programs/libtommath/.build/addMul",
        "args": [],
        "input": ""
    },
    {
        "name": "moduloExp",
        "executeable": "../../evaluation_programs/libtommath/.build/moduloExp",
        "args": [],
        "input": ""
    },
    {
        "name": "rsa",
        "executeable": "../../evaluation_programs/libtommath/.build/rsa",
        "args": [],
        "input": ""
    },
    {
        "name": "primeTest",
        "executeable": "../../evaluation_programs/libtommath/.build/primeTest",
        "args": [],
        "input": ""
    },
    {
        "name": "gcd",
        "executeable": "../../evaluation_programs/libtommath/.build/gcd",
        "args": [],
        "input": ""
    },
    # cJSON
    {
        "name": "createJson",
        "executeable": "../../evaluation_programs/cJSON/.build/createJson",
        "args": [],
        "input": ""
    },
    {
        "name": "parseJson",
        "executeable": "../../evaluation_programs/cJSON/.build/parseJson",
        "args": [],
        "input": ""
    },
    {
        "name": "searchJson",
        "executeable": "../../evaluation_programs/cJSON/.build/searchJson",
        "args": [],
        "input": ""
    },
    {
        "name": "malformedInput",
        "executeable": "../../evaluation_programs/cJSON/.build/malformedInput",
        "args": [],
        "input": ""
    },
    {
        "name": "mergeJson",
        "executeable": "../../evaluation_programs/cJSON/.build/mergeJson",
        "args": [],
        "input": ""
    },
    # Coreutils
    {
        "name": "wc",
        "executeable": "../../evaluation_programs/coreutils/.build/wc",
        "args": ["../../evaluation_programs/coreutils/input/example.csv"],
        "input": ""
    },
    {
        "name": "cat",
        "executeable": "../../evaluation_programs/coreutils/.build/cat",
        "args": ["../../evaluation_programs/coreutils/input/text.md"],
        "input": ""
    },
    {
        "name": "sort",
        "executeable": "../../evaluation_programs/coreutils/.build/sort",
        "args": ["-g", "-r", "../../evaluation_programs/coreutils/input/example.csv"],
        "input": ""
    },
    {
        "name": "uniq",
        "executeable": "../../evaluation_programs/coreutils/.build/uniq",
        "args": ["-D", "../../evaluation_programs/coreutils/input/example.csv"],
        "input": ""
    },
    {
        "name": "tail",
        "executeable": "../../evaluation_programs/coreutils/.build/tail",
        "args": ["-n", "10", "../../evaluation_programs/coreutils/input/example.csv"],
        "input": ""
    },
]