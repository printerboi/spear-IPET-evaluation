/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <iostream>
#include "cJSON.h"

void mergeJsonObjects(cJSON *baseObject, const cJSON *overrideObject) {
    const cJSON *overrideItem = nullptr;

    cJSON_ArrayForEach(overrideItem, overrideObject) {
        cJSON *baseItem = cJSON_GetObjectItemCaseSensitive(baseObject, overrideItem->string);

        if (cJSON_IsObject(baseItem) && cJSON_IsObject(overrideItem)) {
            mergeJsonObjects(baseItem, overrideItem);
            continue;
        }

        if (cJSON_IsArray(baseItem) && cJSON_IsArray(overrideItem)) {
            const cJSON *overrideArrayItem = nullptr;

            cJSON_ArrayForEach(overrideArrayItem, overrideItem) {
                cJSON *copiedArrayItem = cJSON_Duplicate(overrideArrayItem, 1);
                if (copiedArrayItem != nullptr) {
                    cJSON_AddItemToArray(baseItem, copiedArrayItem);
                }
            }

            continue;
        }

        cJSON *copiedOverrideItem = cJSON_Duplicate(overrideItem, 1);
        if (copiedOverrideItem == nullptr) {
            continue;
        }

        if (baseItem != nullptr) {
            cJSON_ReplaceItemInObjectCaseSensitive(baseObject, overrideItem->string, copiedOverrideItem);
        } else {
            cJSON_AddItemToObject(baseObject, overrideItem->string, copiedOverrideItem);
        }
    }
}

int main() {
    // Default json
    const char* inputJson = R"({
        "movie": {
            "id": 1337,
            "title": "Project Hail Mary",
            "actors": [
                "Ryan Gosling",
                "Sandra Hüller"
            ],
            "runtime": 156,
            "year": 2026,
            "director": "Phil Lord, Christopher Miller",
            "imdb_rating": 8.3,
            "rotten_tomatoes": 94
        }
    })";

    // Other json
    const char* mergeJson = R"({
        "movie": {
            "actors": [
                "James Ortiz",
                "Lionel Boyce"
            ],
            "imdb_rating": 8.7,
            "language": "English"
        }
    })";

    // Call the parser
    cJSON* defaultObject = cJSON_Parse(inputJson);
    cJSON* mergeObject = cJSON_Parse(mergeJson);

    // Validate that parsing was successful
    if (!defaultObject || !mergeObject) {
        std::cerr << "JSON parsing failed!" << std::endl;
        cJSON_Delete(defaultObject);
        cJSON_Delete(mergeObject);
        return 1;
    }

    // Call Merge method
    mergeJsonObjects(defaultObject, mergeObject);

    // Conver the merged json back to ls
    char *mergedJsonText = cJSON_Print(defaultObject);
    if (mergedJsonText == nullptr) {
        std::cerr << "Failed to serialize merged JSON." << std::endl;
        cJSON_Delete(defaultObject);
        cJSON_Delete(mergeObject);
        return 1;
    }

    std::cout << mergedJsonText << std::endl;

    cJSON_free(mergedJsonText);
    cJSON_Delete(defaultObject);
    cJSON_Delete(mergeObject);

    return 0;
}