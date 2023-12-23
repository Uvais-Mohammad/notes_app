# Notes App
### _Seamlessly manage your notes anytime, anywhere_

![Build Status](https://img.shields.io/badge/Flutter-white.svg?logo=Flutter&logoColor=blue) ![Build Status](https://img.shields.io/badge/Firestore%20Database-white.svg?logo=Firebase&logoColor=yellow) ![Build Status](https://img.shields.io/badge/Sqflite-white.svg?logo=sqlite&logoColor=blue) ![Build Status](https://img.shields.io/badge/Riverpod-white.svg?logoColor=blue) 

This Flutter project is designed as a notes app, prioritizing offline functionality. 
<!-- Users have the capability to perform create, read, update, and delete operations on notes effortlessly, ensuring a smooth experience regardless of the device's online or offline state. The application features a synchronization mechanism that efficiently updates the server when the device is online. Additionally, it gracefully manages conflicts that may arise when a note is edited both online and offline. -->
### Features
- Create, read, update, and delete notes
- Offline-first functionality
- Synchronization mechanism
- Conflict resolution



### Project Structure
The codebase adheres to a feature-level architecture, promoting a clean and modular organization that systematically separates concerns for UI components, data storage, and synchronization. The project encompasses the following 

- lib/
  - features/ 
    - note/
        - models/
        - screens/
        - repository/
        - providers/
        - logic/
    - splash/
        - screens/
        - logic/
  - shared/
    - components/
    - constants/
    - themes/
    - utils/
  - main.dart



### Screenshots 
<p>
  <img height="400" src="https://github.com/Uvais-Mohammad/notes_app/assets/63300484/e5e2a9f6-abef-4c2e-9aea-8a6903594108">
  <img height="400" src="https://github.com/Uvais-Mohammad/notes_app/assets/63300484/91fea16d-0c62-48a9-a2bb-6e40cf9d86ab">
  <img height="400" src="https://github.com/Uvais-Mohammad/notes_app/assets/63300484/24602c49-09bd-4a8e-8481-842067bc8098">
</p>

<p>
  <img height="400" src="https://github.com/Uvais-Mohammad/notes_app/assets/63300484/cdf2e48b-432f-47eb-926c-638ea05f4898">  
  <img height="400" src="https://github.com/Uvais-Mohammad/notes_app/assets/63300484/09f6b38f-b0fd-4b6e-82fc-55a330f30300">  
</p>



### How to Run the app
1. Clone the repository
```sh
git clone https://github.com/Uvais-Mohammad/notes_app
```
2. Install dependencies


```sh
flutter pub get
```

3. Run the app
```sh
flutter run
```

### How to Run the tests
1. Run the tests
```sh
flutter test
```
