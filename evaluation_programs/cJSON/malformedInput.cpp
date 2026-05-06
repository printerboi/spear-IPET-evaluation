/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <iostream>
#include "cJSON.h"

int main() {
    // Malformed input. Notice the missing "" around Lionel Boyce
    const char* inputJson = R"({
        "movie": {
            "id": 1337,
            "title": "Project Hail Mary",
            "actors": [
                "Ryan Gosling",
                "Sandra Hüller",
                "James Ortiz",
                Lionel Boyce
            ],
            "runtime": 156,
            "year": 2026,
            "director": "Phil Lord, Christopher Miller",
            "imdb_rating": 8.3,
            "rotten_tomatoes": 94
        }
    })";

    // Call the parser
    cJSON* parsedObject = cJSON_Parse(inputJson);

    // Validate that parsing was successfull
    if (!parsedObject) {
        std::cerr << "JSON parsing failed!" << std::endl;
        return 1;
    }

    // Get movie object
    cJSON* movieObject = cJSON_GetObjectItem(parsedObject, "movie");

    // Read values
    cJSON* title = cJSON_GetObjectItem(movieObject, "title");
    cJSON* year = cJSON_GetObjectItem(movieObject, "year");
    cJSON* imdbRating = cJSON_GetObjectItem(movieObject, "imdb_rating");

    std::cout << "Title: " << title->valuestring << std::endl;
    std::cout << "Year: " << year->valueint << std::endl;
    std::cout << "IMDb Rating: " << imdbRating->valuedouble << std::endl;

    // Read actors array
    cJSON* actorsArray = cJSON_GetObjectItem(movieObject, "actors");

    std::cout << "\nActors:" << std::endl;

    cJSON* actor = nullptr;

    cJSON_ArrayForEach(actor, actorsArray) {
        std::cout << "- " << actor->valuestring << std::endl;
    }

    cJSON_Delete(parsedObject);

    return 0;
}