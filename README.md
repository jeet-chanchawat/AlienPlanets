# AlienPlanets

# Features

- Supports a minimum application version of iOS 15.0
- App consumes API: https://swapi.co/api/planets and download the list of planets
- Response is cached in JSON file
- Code is Unit-tested at business logics 
- App will work on both iPhones and iPads
- App consumes Apple frameworks only
- Home Screen displays a list of planets received
- Code is appropiately documented

# How to Use

1. Install the app
2. Open the app to download and cache the planet information
3. The app will display list of planets.

# Future Features and Improvements

1. Implement pagination to display more planets using next API
2. If BE provides API to get hash of data, it can be used to check the local data and update cache only when required
3. Images can be displayed if image URL is provided
4. The stored JSON can be encrypted format in AES-256 (symmetrical)
5. On tapping planet, user can be navigated to Planet details screen where entire information can be displayed
6. Add loader for all the API calls
7. A local/API based search feature can be implemented
8. Add dark/light mode or theme support
