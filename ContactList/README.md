#  Contact List
A 2-view app that fetches contacts from a public endpoint and diplays their info on a tableview.

This project showcases: 

### Dependencies
Via cocoapods:
- RxSwift
- AlamoFire for requests (no rx alamofire though)
- ProgressHUD (simple loading view library)

### Architecture
- MVVM + Coordinators

### Project Structure
- ContactList - Root directory
    - Service layer - All the networking classes belong here
    - App Layer - General app classes. App & Scene delegates. App Coordinator
    - Data Layer - Models & data-related classes go here
    - Modules - All user flows are contained here
        - Employees - The employees module. which is the only module of this app
    - Utilities - A place for general utility classes
    - Extensions - A place where generic extensions belong
    - Storyboards - The project's storyboard & LaunchScreen
    - ContactListTests - Unit tests. This is where I tested the Cell's rating label


### Tests
- We're testing the model & JSON deserialization with several scenarios
