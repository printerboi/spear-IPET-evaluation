/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <sqlite3.h>
#include <iostream>

bool execSQL(sqlite3 *dbHandle, const std::string &query) {
    char *errormsg = nullptr;

    const int resultCode = sqlite3_exec(dbHandle, query.c_str(), nullptr, nullptr, &errormsg);

    if (resultCode != SQLITE_OK) {
        std::cerr << "SQLite error: "
                  << (errormsg != nullptr ? errormsg : "unknown")
                  << "\n";
        sqlite3_free(errormsg);
        return false;
    }

    return true;
}


int main() {
    // Create a new DB handle
    sqlite3 *databaseHandle = nullptr;

    if(sqlite3_open("test.db", &databaseHandle) != SQLITE_OK) {
        std::cerr << "Failed to open DB" << std::endl;
    }

    bool createTable = execSQL(databaseHandle,
        "CREATE TABLE IF NOT EXISTS test ("
        "id INTEGER PRIMARY KEY, "
        "value TEXT"
        ");"
    );

    if (!createTable) {
        sqlite3_close(databaseHandle);
        return 1;
    }

    bool insertData = execSQL(databaseHandle,
        "INSERT INTO test (value) VALUES ('hello world');"
    );

    if (!insertData) {
        sqlite3_close(databaseHandle);
        return 1;
    }

    sqlite3_close(databaseHandle);

    std::cout << "Execution finished!" << std::endl;
    return 0;
}