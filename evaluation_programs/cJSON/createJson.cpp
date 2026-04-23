
#include <iostream>
#include "cJSON.h"



int main() {
    // Create the object
    cJSON *obj = cJSON_CreateObject();
    
    if (!obj) {
        std::cerr << "JSON Object creation failed!" << std::endl;
    }

    // create sub objects
    // Sun
    cJSON* sunObj = cJSON_CreateObject();
    cJSON_AddNumberToObject(sunObj, "radius", 1.0);
    cJSON_AddNumberToObject(sunObj, "mass", 1.0);
    cJSON_AddStringToObject(sunObj, "class", "yellow dwarf");

    cJSON_AddItemToObject(obj, "sun", sunObj);

    // Proxima Centauri
    cJSON* alphaCentObj = cJSON_CreateObject();
    cJSON_AddNumberToObject(alphaCentObj, "radius", 0.1542);
    cJSON_AddNumberToObject(alphaCentObj, "mass", 0.1221);
    cJSON_AddStringToObject(alphaCentObj, "class", "red dwarf");

    cJSON_AddItemToObject(obj, "Proxima Centauri", alphaCentObj);

    // Barnards Star
    cJSON* barnardObj = cJSON_CreateObject();
    cJSON_AddNumberToObject(barnardObj, "radius", 0.187);
    cJSON_AddNumberToObject(barnardObj, "mass", 0.162);
    cJSON_AddStringToObject(barnardObj, "class", "red dwarf");

    cJSON_AddItemToObject(obj, "Barnards Star", barnardObj);

    // Print the JSON
    char* jsonString = cJSON_Print(obj);
    std::cout << jsonString << std::endl;

    cJSON_Delete(barnardObj);
    cJSON_Delete(alphaCentObj);
    cJSON_Delete(sunObj);
    cJSON_Delete(obj);

    return 0;
}