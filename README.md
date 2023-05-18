# iStarWars

## Table of contents
* [Introduction](#introduction)
* [Features](#features)
* [Technologies](#technologies)
* [Approach](#approach)
* [Unit Testing](#unit-testing)
* [Future Features And Improvements](#future-features-and-improvements)


## Introduction:
An iOS application built with Swift, UIKit, and CoreData that displays a list of planets and their details.

## Features:
1.	Consumption of API (https://swapi.dev/api/planets/) to fetch the Planet records. (URL Session)
2.	Display the records in a List View.
3.	Persist the planet list to enable offline viewing. (Core Data)
4.	Universal application.

#### Upcoming Features
5.	Upon clicking each planet item from the list, a details screen will be displayed, showcasing relevant information about the selected planet.
6.	Persist the planet details to enable offline viewing. (Core Data)


## Technologies:
* Xcode: 13.2
* Minimum iOS version: 15.2
* Swift: 5
* UIKit
* CoreData

## Approach:
1.	On the initial launch of the app, retrieve planet records from the planets API by utilizing a **URLSession** data task.
2.	Create the JSON object from API response data using **JSONSerialization**.
3.	Save the object obtained from JSON data into **Core Data**.
4.	Display the planet records in a List View.
5.	On subsequent launches of the app, check if the data is available in offline storage. If it is, fetch the data from offline and display it. Otherwise, fetch the data from the planet API.

## Unit Testing: 
1. Unit Testing is performed using **XCTest framework**.
2. Unit Tests for Core Data of type In Memory Story.
3. UI Testing using XCUI Tests (XCTestCase)


## Future Features And Improvements:
1.	**Load more** feature to fetch the next available records.
2.	**Search** planet functionality.
3.	The **Core Data** implementation currently supports the Planet object. However, it is important to consider including the other related objects, such as Residents and Films, in the database and supporting their corresponding relationships. For example, these objects may have relationships with other objects like Vehicles.
