/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <iostream>
#include <vector>
#include <string>

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include <stb_image_write.h>

/**
 * Generate a simple RGB gradient image and write it as PNG.
 * @param outputPath Path to the output PNG file
 * @param imageWidth Width of the image
 * @param imageHeight Height of the image
 */
void generateAndSaveGradientImage(const std::string& outputPath, int imageWidth, int imageHeight) {
     // RGB image chanels
    const int numberOfChannels = 3;
    // Creat the image buffer
    std::vector<unsigned char> imageBuffer(imageWidth * imageHeight * numberOfChannels);

    // Fill image with a gradient pattern
    for (int y = 0; y < imageHeight; ++y) {
        for (int x = 0; x < imageWidth; ++x) {
            const int pixelIndex = (y * imageWidth + x) * numberOfChannels;

            // Red channel: horizontal gradient
            imageBuffer[pixelIndex + 0] = static_cast<unsigned char>((x * 255) / imageWidth);

            // Green channel: vertical gradient
            imageBuffer[pixelIndex + 1] = static_cast<unsigned char>((y * 255) / imageHeight);

            // Blue channel: mix of both
            imageBuffer[pixelIndex + 2] = static_cast<unsigned char>(((x + y) * 255) / (imageWidth + imageHeight));
        }
    }

    // Create stride
    const int strideInBytes = imageWidth * numberOfChannels;

    // Write the image
    int result = stbi_write_png(outputPath.c_str(), imageWidth, imageHeight, numberOfChannels, imageBuffer.data(), strideInBytes);

    // Error handling
    if (result == 0) {
        std::cerr << "Failed to write PNG: " << outputPath << std::endl;
        return;
    }

    std::cout << "PNG successfully written to: " << outputPath << std::endl;
}

int main() {
    // Define output image parameters
    const std::string outputPath = "gradient.png";
    const int imageWidth = 1920;
    const int imageHeight = 1080;

    // Create the image
    generateAndSaveGradientImage(outputPath, imageWidth, imageHeight);

    return 0;
}