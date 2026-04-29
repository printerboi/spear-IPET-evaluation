/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <iostream>
#include <string>

#define STB_IMAGE_IMPLEMENTATION
#include <stb_image.h>

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include <stb_image_write.h>


int main() {
    // Path variables
    const std::string inputPath = "image.png";
    const std::string outputPath = "grayscale.png";

    // Image storage parameter
    int imageWidth = 0;
    int imageHeight = 0;
    int originalChannels = 0;

    // Channels we are converting to
    const int desiredChannels = 1;

    // Load the image
    unsigned char* grayscaleData = stbi_load(inputPath.c_str(), &imageWidth, &imageHeight, &originalChannels, desiredChannels);

    // Loading error handling
    if (grayscaleData == nullptr) {
        std::cerr << "Failed to load image: " << stbi_failure_reason() << std::endl;
        return 1;
    }

    // Loading information
    std::cout << "Loaded grayscale image\n";
    std::cout << "Width: " << imageWidth << ", Height: " << imageHeight
              << ", Original Channels: " << originalChannels
              << ", New Channels: " << desiredChannels << std::endl;

    // Convert the image to grayscale
    int strideInBytes = imageWidth * desiredChannels;

    // Write the image
    if (!stbi_write_png(outputPath.c_str(), imageWidth, imageHeight, desiredChannels, grayscaleData, strideInBytes)) {
        std::cerr << "Failed to write PNG\n";
        stbi_image_free(grayscaleData);
        return 1;
    }

    std::cout << "Saved grayscale image to " << outputPath << std::endl;

    // Free the image memory
    stbi_image_free(grayscaleData);

    return 0;
}