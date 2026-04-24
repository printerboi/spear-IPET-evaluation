/*
 * Copyright (c) 2026 Maximilian Krebs
 * All rights reserved.
 */

#include <iostream>
#include <string>
#include <vector>

#include <tinyxml2.h>

using namespace tinyxml2;

/**
 * Create a document root
 * @param document XMLDocument to create the root element in
 * @return Reference to the created root element
 */
XMLElement* createRoot(XMLDocument& document) {
    XMLElement* rootElement = document.NewElement("Faculties");
    document.InsertFirstChild(rootElement);

    return rootElement;
}

/**
 * Create a new faculty in the given document object
 * @param document Document to insert the faculty in
 * @param nextId ID of the object that will be created
 * @param name Name of the faculty
 * @param building Building name of the faculty
 * @param students Number of students currently enrolled at the faculty
 * @param studies Studies available at the faculty
 * @return Returns the newly created faculty object
 * 
 */
XMLElement* createFaculty(XMLDocument& document, int nextId, const std::string& name, const std::string& building, int students, const std::vector<std::string>& studies) {
    // Create faculty object
    XMLElement* facultyElement = document.NewElement("Faculty");
    facultyElement->SetAttribute("id", nextId);

    // Insert the name in the faculty object
    XMLElement* nameElement = document.NewElement("Name");
    nameElement->SetText(name.c_str());
    facultyElement->InsertEndChild(nameElement);

    // Insert the building in the faculty object
    XMLElement* buildingElement = document.NewElement("Building");
    buildingElement->SetText(building.c_str());
    facultyElement->InsertEndChild(buildingElement);

    // Insert the number of students in the faculty object
    XMLElement* studentsElement = document.NewElement("Students");
    studentsElement->SetText(students);
    facultyElement->InsertEndChild(studentsElement);

    // Insert the studies in the faculty object
    XMLElement* studiesElement = document.NewElement("Studies");
    for (const std::string& study : studies) {
        XMLElement* studyElement = document.NewElement("Study");
        studyElement->SetText(study.c_str());
        studiesElement->InsertEndChild(studyElement);
    }
    facultyElement->InsertEndChild(studiesElement);

    return facultyElement;
}

int main() {
    // Create the document
    XMLDocument xmlDocument;
    int nextId = 0;

    // Create the root element
    XMLElement* rootElement = createRoot(xmlDocument);

    // Insert a CS faculty
    rootElement->InsertEndChild(createFaculty(
        xmlDocument,
        nextId++,
        "Computer Science",
        "Building A",
        1200,
        {"Computer Science", "Data Science"}
    ));

    // Insert a Chemistry faculty
    rootElement->InsertEndChild(createFaculty(
        xmlDocument,
        nextId++,
        "Chemistry",
        "Building C",
        123,
        {"Chemistry", "Chemical Engineering", "Pharmaceutical Chemistry"}
    ));

    // Insert a Mechanical Engineering faculty
    rootElement->InsertEndChild(createFaculty(
        xmlDocument,
        nextId++,
        "Mechanical Engineering",
        "Building M",
        2048,
        {"Mechanical Engineering", "Logistics"}
    ));

    // Insert an Electrical Engineering faculty
    rootElement->InsertEndChild(createFaculty(
        xmlDocument,
        nextId++,
        "Electrical Engineering",
        "Building E",
        980,
        {"Electrical Engineering", "Information Technology", "Embedded Systems"}
    ));

    // Insert a Mathematics faculty
    rootElement->InsertEndChild(createFaculty(
        xmlDocument,
        nextId++,
        "Mathematics",
        "Building B",
        650,
        {"Mathematics", "Statistics", "Applied Mathematics"}
    ));

    // Insert a Physics faculty
    rootElement->InsertEndChild(createFaculty(
        xmlDocument,
        nextId++,
        "Physics",
        "Building P",
        540,
        {"Physics", "Astrophysics", "Quantum Science"}
    ));

    // Insert a Business faculty
    rootElement->InsertEndChild(createFaculty(
        xmlDocument,
        nextId++,
        "Business Administration",
        "Building W",
        1500,
        {"Business Administration", "Economics", "Management"}
    ));

    // Save the generated XML document
    if (xmlDocument.SaveFile("university.xml") != XML_SUCCESS) {
        std::cerr << "Error writing XML file.\n";
        return 1;
    }

    std::cout << "XML file written.\n";
    return 0;
}