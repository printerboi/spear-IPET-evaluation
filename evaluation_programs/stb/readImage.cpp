/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <iostream>
#include <string>

#define STB_IMAGE_IMPLEMENTATION
#include <stb_image.h>

/**
 * Load an image from disk and print basic information.
 * @param imagePath Path to the image file
 */
void loadAndPrintImageInfo(const std::string& imagePath) {
    // Image parameter
    int imageWidth = 0;
    int imageHeight = 0;
    int imageChannels = 0;

    // Load image
    unsigned char* imageData = stbi_load(imagePath.c_str(), &imageWidth, &imageHeight, &imageChannels, 0);

    // Image error handling
    if (imageData == nullptr) {
        std::cerr << "Failed to load image: " << imagePath << std::endl;
        std::cerr << "Reason: " << stbi_failure_reason() << std::endl;
        return;
    }

    // Print loaded parameters
    std::cout << "Image loaded successfully!" << std::endl;
    std::cout << "Width: " << imageWidth << std::endl;
    std::cout << "Height: " << imageHeight << std::endl;
    std::cout << "Channels: " << imageChannels << std::endl;

    // Compute a simple checksum over the first few bytes
    unsigned long long checksum = 0;
    const int maxBytesToCheck = std::min(imageWidth * imageHeight * imageChannels, 1024);

    for (int i = 0; i < maxBytesToCheck; ++i) {
        checksum += imageData[i];
    }

    // Output checksum
    std::cout << "Checksum (first " << maxBytesToCheck << " bytes): " << checksum << std::endl;

    // Free image memory
    stbi_image_free(imageData);
}

int main() {
    // Path to the image
    const std::string imagePath = "image.png";

    // Call the load and print method
    loadAndPrintImageInfo(imagePath);

    return 0;
}