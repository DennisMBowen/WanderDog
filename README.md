# WanderDog 🐾
 * This project was last updated June 2026

Developed by Dennis Bowen

WanderDog is an iOS that allows dog owners the ability to track the daily walk habits of their dog. 

It is written using Swift, SwiftUI, MapKit, Core Location, and HTTP requests to microservices.


## Key Screens and Features

### Home Screen
____________________
The home screen lists the data from all previously recorded walks.

<img width="355" height="727" alt="Home Screen" src="https://github.com/user-attachments/assets/35543d7b-b52d-4096-b9da-17c4fa84f95c" />

### Track Walk Feature
_____________________

This feature uses Core Location from Swift to track a user's location while they are out on a walk with their dog. The feature UI will show the walk route in real time while it is activated.

<img width="361" height="744" alt="OnAWalkAdditional" src="https://github.com/user-attachments/assets/5cc1acb1-a06a-40e6-94de-4a300d99afa2" />

Once a user has finished their walk, they have the ability to save the walk. This will then store the walk data on the home page.

<img width="348" height="723" alt="OnAWalkPaused" src="https://github.com/user-attachments/assets/c13b24da-7f3b-47c3-bd49-a0f0468268e1" />

### Add Walk Feature
_____________________

This feature allows users to manually input information from a previous walk. This method also stores the previous walk on the home screen.

<img width="341" height="730" alt="AddNewWalkScreen" src="https://github.com/user-attachments/assets/6f15f042-1279-4007-a758-4cd543cc30f8" />

### Dog Spots Feature
____________________

This feature allows users to find dog friendly establishments within a selected radius of their current location. Currently, an establishment is defined as a bar or restaurant. This feature generates a route from their current location to the selected establishment, and lets the user know how many miles they would cover by walking to the establishment.

<img width="404" height="882" alt="FindDogSpots" src="https://github.com/user-attachments/assets/c00e0165-9152-4b3d-aa1d-ae30e8e6fc4e" />

The four microservices being used for this feature are:
+ find_dog_friendly_establishments: Uses the Overpass API with data from OpenStreetMap to locate dog friendly establishments within a certain radius of a user's location
+ find_route: Provides a route between two latitude and longitude coordinates. This microservice utilizes the OpenRouteServiceAPI from OpenStreetMap.
+ duration_conversion: Converts a duration in seconds to a human-usable duration in hours/minutes/seconds
+ convert_length_units: Converts length units between USA customary units and metro length units 

*** Note: The Dog Spots feature is currently using microservices that were built by other students at Oregon State University, and the microservices themselves are all deployed as API endpoints on Oregon State's ENGR server. As such, this feature will not be sustainable long term.

## Future Goals
### Refactoring
- [ ] Rebuild the Dog Spots feature so it is no longer dependable on the microservices housed on Oregon State's ENGR server
- [ ] Update the method for saving walk data to use Core Data or Swift Data rather than AppStorage

### Enhancements
- [ ] Spruce up the UI - use a color palette with unique color shades rather than the default colors from Swift
- [ ] Add additional features to the saved walk data, such as displaying walk distance and walk time averages per day, week, and month;  and allowing a user filter the walk data results based on a previous date range
- [ ] Add a login for the user
- [ ] Allow multiple users to save walk data for a specific dog, rather than just the dog owner
- [ ] Allow users to separate and track data for multiple dogs
- [ ] Let the dog owner upload a picture of their dog!

## Shoutouts 
- [@aliyarahman](https://github.com/aliyarahman) for introducing me to the Overpass API and OpenStreetMap as well as providing a template for setting up Flask API endpoints
- [@cdelta27](https://github.com/cdelta27) for building the find_route and duration_conversion microservices that this project uses
- [Swiftful Thinking](https://www.youtube.com/@SwiftfulThinking) whose videos taught me the basics of SwiftUI and how build an iOS app using MVVM architecture
- [Sean Allen](https://www.youtube.com/@seanallen) whose videos taught me how to make HTTP requests in Swift as well as how to use MapKit and Core Location.
- [Karin Prater](https://www.youtube.com/@SwiftyPlace) whose videos taught me how to set up the TabView menu for easy user navigation


