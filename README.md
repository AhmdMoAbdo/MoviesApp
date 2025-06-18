# Voyage Cenimatics (MoviesApp)

## App Description
Simple Mini Movies App that has 2 Main Screens + Splash Screen + a webView<br>

## Splash Screen
The initial splash screen is very simple, containing the app name, slogan and a lottie animation that plays then transitions to the Home Screen<br>
<img src="https://github.com/user-attachments/assets/68ae3ec7-e1dd-4941-917b-9cabe104515a" width="200" height="435"/>

## Home Screen:
The first one of the 2 main screens is the Home Screen which displays a paginated movies list in 2 different view options:<br>
1- Grid View<br>
2- List View<br>
Both cells have a favorite button to add or remove the movie from our favorites list.<br>
<img src="https://github.com/user-attachments/assets/d661483e-d41f-47af-91e3-df6bca181b32" width="200" height="435"/>
<img src="https://github.com/user-attachments/assets/3504d197-06a8-40a7-a1c9-c84ed7303426" width="200" height="435"/>

## Details Screen:
The second one is the details screen that displays all available movie details and also the heart icon indicating whether the movie is in our favorite list or not and also to add the movie to/  remove it from the favorite list.<br>
<img src="https://github.com/user-attachments/assets/f032fa00-7386-417f-86c2-7489f44ccb41" width="200" height="435"/>
<img src="https://github.com/user-attachments/assets/538f3271-3425-4aac-872a-7a0ecc3a6276" width="200" height="435"/>

The details screen contains a watch button that is displayed only when a watch link is available<br>
Clicking that watch button opens the WebView Screen navigating to the available URL for that movie.<br>
<img src="https://github.com/user-attachments/assets/9cb407de-eb5a-4328-9fd5-8cb39880cd20" width="200" height="435"/>

## Technologies used in the app<br>
1- Swift<br>
2- UIKit<br>
3- Clean Architecture using MVVM + Router<br>
4- Alamofire for network handling<br>
5- SDWebImage for image loading<br>
6- SPM<br>

## App Architecture:<br>
As mentioned, Clean Architecture was used with MVVM but Router was incorporated for 2 reasons:<br>
1- Inject dependencies into its relative module<br>
2- Encapsulate navigation related logic between screens into one place.<br>

## dependency injection
Preferred to use the router to inject required dependencies into different module classes rather than a classic dependency container<br>

## caching
An array of favorite movies IDs was cached in a file, rather than using UserDefaults, to be used for persistence when the app is re-opened <br>

## Error Handling<br>
Handling network calls error by showing a center screen error with a retry button.<br>
Losing internet connection shows a top banner indicating reachability changes.<br>
<img src="https://github.com/user-attachments/assets/f143d388-4de8-45d6-ad79-c52bb6b716a1" width="200" height="435"/>
<img src="https://github.com/user-attachments/assets/acf90cee-f1c4-4c4e-9073-46b19e8f23d9" width="200" height="435"/>

## App Preview<br>
Finally, Here is a very quick app walkthrough video.<br>
https://drive.google.com/file/d/1iQ26vot92ud0UHImr7EZIS9pSj1SM_0S/view?usp=sharing
