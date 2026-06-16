# WanderDog
 * This project was last updated June 2026

Developed by Dennis Bowen

WanderDog is an iOS that allows dog owners the ability to track the daily walk habits of their dog. 

It is written using Swift, SwiftUI, MapKit, Core Location, and HTTP requests to microservices.


## Key Screens and Features

### Home Screen
____________________
The home screen will list the data all previously recorded walks.

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

* Note: The Dog Spots feature is currently using microservices that were built by other students at Oregon State University, and the microservices themselves are all deployed on Oregon State's ENGR server. As such, this feature will not be sustainable long term.


