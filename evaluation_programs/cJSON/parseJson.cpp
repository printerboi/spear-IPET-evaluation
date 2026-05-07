/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <iostream>
#include "cJSON.h"



int main() {
    const char* inputJson = R"({
    "solarSystemPlanets": [
        {
        "name": "Mercury",
        "orderFromSun": 1,
        "type": "Terrestrial",
        "averageTemperatureCelsius": 167
        },
        {
        "name": "Venus",
        "orderFromSun": 2,
        "type": "Terrestrial",
        "averageTemperatureCelsius": 464
        },
        {
        "name": "Earth",
        "orderFromSun": 3,
        "type": "Terrestrial",
        "averageTemperatureCelsius": 15
        },
        {
        "name": "Mars",
        "orderFromSun": 4,
        "type": "Terrestrial",
        "averageTemperatureCelsius": -65
        },
        {
        "name": "Jupiter",
        "orderFromSun": 5,
        "type": "Gas Giant",
        "averageTemperatureCelsius": -110
        },
        {
        "name": "Saturn",
        "orderFromSun": 6,
        "type": "Gas Giant",
        "averageTemperatureCelsius": -140
        },
        {
        "name": "Uranus",
        "orderFromSun": 7,
        "type": "Ice Giant",
        "averageTemperatureCelsius": -195
        },
        {
        "name": "Neptune",
        "orderFromSun": 8,
        "type": "Ice Giant",
        "averageTemperatureCelsius": -200
        }
    ]
    })";

    cJSON *parsedObj = cJSON_Parse(inputJson);
    if(!parsedObj) {
        std::cerr << "JSON parsing failed" << std::endl;
    }

    // Access planets
    const cJSON *planetsArr = cJSON_GetObjectItemCaseSensitive(parsedObj, "solarSystemPlanets");

    // Get earth
    const cJSON *earthObj = cJSON_GetArrayItem(planetsArr, 2);

    const cJSON* name = cJSON_GetObjectItemCaseSensitive(earthObj, "name");
    const cJSON* order = cJSON_GetObjectItemCaseSensitive(earthObj, "orderFromSun");
    const cJSON* type = cJSON_GetObjectItemCaseSensitive(earthObj, "type");
    const cJSON* temp = cJSON_GetObjectItemCaseSensitive(earthObj, "averageTemperatureCelsius");

    // Print the JSON
    std::cout << "Planet info:" << std::endl;
    std::cout << "  Name: " << cJSON_Print(name) << std::endl;
    std::cout << "  Order: " << cJSON_Print(order) << std::endl;
    std::cout << "  Type: " << cJSON_Print(type) << std::endl;
    std::cout << "  Temp: " << cJSON_Print(temp) << std::endl;

    return 0;
}