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

    // Load XML file
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

    int bookCount = 0;

    // Iterate over all Book elements
    for (XMLElement* bookElement = libraryElement->FirstChildElement("Book");
         bookElement != nullptr;
         bookElement = bookElement->NextSiblingElement("Book")) {

        int bookId = 0;
        bookElement->QueryIntAttribute("id", &bookId);

        const char* titleText = nullptr;
        const char* authorText = nullptr;
        int yearValue = 0;

        XMLElement* titleElement = bookElement->FirstChildElement("Title");
        if (titleElement != nullptr) {
            titleText = titleElement->GetText();
        }

        XMLElement* authorElement = bookElement->FirstChildElement("Author");
        if (authorElement != nullptr) {
            authorText = authorElement->GetText();
        }

        XMLElement* yearElement = bookElement->FirstChildElement("Year");
        if (yearElement != nullptr) {
            yearElement->QueryIntText(&yearValue);
        }

        // Output
        std::cout << "Book #" << bookId << ": "
                  << (titleText ? titleText : "N/A")
                  << " by "
                  << (authorText ? authorText : "N/A")
                  << " (" << yearValue << ")\n";

        ++bookCount;
    }

    std::cout << "\nTotal books parsed: " << bookCount << "\n";
    return 0;
}