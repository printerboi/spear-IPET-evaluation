/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <iostream>
#include <string>
#include "cJSON.h"

/**
 * Recursively search for a key in a given JSON object
 * @param currentNode Current node to start the search from
 * @param targetKey Key to search for
 * 
 */
void findKeyInJsonTree(const cJSON* currentNode, const std::string& targetKey) {
    // Recursion kill if encountering a null value
    if (currentNode == nullptr) {
        return;
    }

    // Iterate over all siblings at this level
    const cJSON* element = currentNode;
    while (element != nullptr) {
        // Check if this node has the desired key
        if (element->string != nullptr && targetKey == element->string) {
            std::cout << "Found key: " << targetKey;

            // Print value depending on type
            if (cJSON_IsString(element)) {
                std::cout << " -> " << element->valuestring;
            } else if (cJSON_IsNumber(element)) {
                std::cout << " -> " << element->valuedouble;
            } else if (cJSON_IsBool(element)) {
                std::cout << " -> " << (cJSON_IsTrue(element) ? "true" : "false");
            } else {
                std::cout << " -> [complex type]";
            }

            std::cout << std::endl;
        }

        // Recurse into children (for objects/arrays)
        findKeyInJsonTree(element->child, targetKey);

        element = element->next;
    }
}

int main() {
    // Json string to search in
    const char* jsonString = R"({
        "user": {
            "id": 1,
            "name": "Max",
            "orders": [
                {"id": 100, "price": 9.99},
                {"id": 101, "price": 19.99}
            ]
        },
        "metadata": {
            "id": 999,
            "timestamp": "2026-04-23"
        }
    })";

    // Parse the json string
    cJSON* rootObject = cJSON_Parse(jsonString);
    if (!rootObject) {
        std::cerr << "Parse error" << std::endl;
        return 1;
    }

    std::cout << "Searching for key 'id':" << std::endl;
    // Call the search method
    findKeyInJsonTree(rootObject, "id");

    cJSON_Delete(rootObject);
    return 0;
}