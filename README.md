# 🌟 User Profile Management App

Manage user profiles, update profile pictures, and sign out seamlessly with this iOS app powered by Swift and Firebase.

<p align="center">
 <img src="https://github.com/Sumayya07/SwavishSoftwareAssignment/assets/95580926/a3cfdd4c-f902-462b-9caa-4e7598e1211d" width="30%">
   <img src="https://github.com/Sumayya07/SwavishSoftwareAssignment/assets/95580926/c816b8ee-7044-4aef-813c-323c59b571e4" width="30%">
   <img src="https://github.com/Sumayya07/SwavishSoftwareAssignment/assets/95580926/27ac93b9-f5e3-4fa6-8092-297ceea986d9" width="30%">
</p>

## 🚀 Table of Contents

- [Features](#features)
- [Usage](#usage)
- [Technical Details](#technical-details)
  - [Profile Picture Management](#profile-picture-management)
  - [Firebase Integration](#firebase-integration)
- [Libraries Used](#libraries-used)
- [Contributing](#contributing)

## 🌟 Features

- **Profile Picture Management**: Upload and update your profile picture effortlessly.
- **Sign Out**: Securely sign out from your account with a single tap.
- **Personalized Greeting**: See a warm greeting with your username when you log in.

## 📖 Usage

- **Profile Picture Update**: Tap the "Update Photo" button to select a new profile picture from your photo library.
- **Sign Out**: Tap the "Sign Out" button to securely log out of your account.

## 🔧 Technical Details

### Profile Picture Management

- **Image Selection**: Utilize the image picker to select or update your profile picture.
- **Image Upload**: Upload selected images to Firebase Storage.
- **Image URL Storage**: Store profile picture URLs in Firebase Realtime Database.

### Firebase Integration

- **Authentication**: Use Firebase Authentication for user sign-in and sign-out.
- **Storage**: Store and retrieve profile pictures using Firebase Storage.
- **Realtime Database**: Store and retrieve user profile image URLs in Firebase Realtime Database.

## 📚 Libraries Used

This iOS app leverages the power of various third-party libraries to enhance functionality and user experience. Here are the key libraries utilized in this project:

### SDWebImage

[SDWebImage](https://github.com/SDWebImage/SDWebImage) is a widely-used library for efficiently downloading and caching images asynchronously in iOS apps. It provides a seamless way to load remote images, handle image caching, and display images in image views. In this app, SDWebImage is employed for fetching and displaying user profile pictures retrieved from Firebase Storage.

### Toast

[Toast](https://github.com/scalessec/Toast-Swift) is a simple library for displaying toast notifications in iOS apps. Toast notifications are non-intrusive, lightweight pop-up messages often used to provide feedback to users. In this app, Toast-Swift is used to show user-friendly messages, such as success messages upon successful actions or error messages when something goes wrong, enhancing the overall user experience.

These libraries significantly contribute to the functionality and user interface of the app, ensuring smooth image loading and providing clear and concise feedback to users during various interactions.

## 🤝 Contributing

We welcome contributions to enhance this app! Follow these steps:

- 🍴 Fork this repository.
- 👯 Clone it to your local machine.
- 🔧 Make your necessary changes and commit: `git commit -m 'Describe your changes here'`.
- 🚀 Push your branch: `git push origin your-branch-name`.
- 📝 Open a pull request.

Happy coding! 🚀

## Working video of the Assignment

<br/>
<video src="https://github.com/Sumayya07/SwavishSoftwareAssignment/assets/95580926/4c64b3db-acb8-43e0-974c-41c7e27e8e0c" width="30%">
