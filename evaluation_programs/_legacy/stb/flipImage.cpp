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
    const std::string outputPath = "flipped.png";

    // Image storage parameter
    int imageWidth = 0;
    int imageHeight = 0;
    int imageChannels = 0;

    // Enable flip on load
    stbi_set_flip_vertically_on_load(1);

    // Load the image
    unsigned char* imageData = stbi_load(inputPath.c_str(), &imageWidth, &imageHeight, &imageChannels, 0);

    // Error handling
    if (imageData == nullptr) {
        std::cerr << "Failed to load image: " << stbi_failure_reason() << std::endl;
        return 1;
    }

    std::cout << "Loaded flipped image\n";
    std::cout << "Width: " << imageWidth << ", Height: " << imageHeight
              << ", Channels: " << imageChannels << std::endl;

    // Calculate stride
    int strideInBytes = imageWidth * imageChannels;

    // Write the image
    if (!stbi_write_png(outputPath.c_str(), imageWidth, imageHeight, imageChannels, imageData, strideInBytes)) {
        std::cerr << "Failed to write PNG\n";
        stbi_image_free(imageData);
        return 1;
    }

    std::cout << "Saved flipped image to " << outputPath << std::endl;

    // Free the image memory
    stbi_image_free(imageData);

    return 0;
}