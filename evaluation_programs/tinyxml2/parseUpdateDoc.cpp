/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <iostream>
#include <string>

#include <tinyxml2.h>

using namespace tinyxml2;

int main() {
    XMLDocument document;

    // Load XML document
    if (document.LoadFile("books.xml") != XML_SUCCESS) {
        std::cerr << "Failed to load books.xml\n";
        return 1;
    }

    // Get root element
    XMLElement* libraryElement = document.FirstChildElement("Library");
    if (libraryElement == nullptr) {
        std::cerr << "Missing <Library> root element\n";
        return 1;
    }

    int updatedBooks = 0;
    int recommendedBooks = 0;
    int notRecommendedBooks = 0;

    // Traverse all books
    for (XMLElement* bookElement = libraryElement->FirstChildElement("Book");
        bookElement != nullptr; bookElement = bookElement->NextSiblingElement("Book")) {
        // Get the rating element
        XMLElement* ratingElement = bookElement->FirstChildElement("Rating");

        double rating = 0.0;
        // Parse the rating from string to double
        if (ratingElement == nullptr || ratingElement->QueryDoubleText(&rating) != XML_SUCCESS) {
            // Handle parsing error
            bookElement->SetAttribute("recommended", "unknown");
            ++updatedBooks;
            continue;
        }

        // Check the rating number. Recommend the book if it has a rating >= 3
        if (rating >= 3.0) {
            bookElement->SetAttribute("recommended", "true");
            ++recommendedBooks;
        } else {
            bookElement->SetAttribute("recommended", "false");
            ++notRecommendedBooks;
        }

        ++updatedBooks;
    }

    // Save modified XML document
    if (document.SaveFile("books_updated.xml") != XML_SUCCESS) {
        std::cerr << "Failed to write books_updated.xml\n";
        return 1;
    }

    std::cout << "Updated books: " << updatedBooks << "\n";
    std::cout << "Recommended books: " << recommendedBooks << "\n";
    std::cout << "Not recommended books: " << notRecommendedBooks << "\n";
    std::cout << "Written books_updated.xml\n";

    return 0;
}