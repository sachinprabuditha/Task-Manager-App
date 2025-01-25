#Task Manager App
A simple task management app built with Flutter, using Riverpod for state management and Hive for local storage. The app allows users to create, edit, delete tasks, filter them by title or description, and track progress with the ability to mark tasks as completed.

#Features
Add, edit, delete tasks.
Filter tasks by title or description.
Mark tasks as completed.
Display task priority and due date.
Progress indicator showing completed vs. total tasks.
Animated transitions and smooth UI updates.

#Requirements
Flutter 3.0 or higher
Dart 2.18 or higher
Hive for local storage
Riverpod for state management

#Assumptions
The user is familiar with Flutter and basic app development.
The app assumes that the user has a Flutter development environment already set up.
The app uses local storage (Hive), so data will persist even if the app is closed or restarted.
The tasks are saved locally and are not synced across devices or platforms.


#Step 1: Clone the Repository
Clone this repository to your local machine using the following command:

git clone https://github.com/yourusername/task_manager_app.git
cd task_manager_app

#Step 2: Install Dependencies
Make sure you have Flutter installed. Then, run the following command to install the necessary dependencies:

flutter pub get
This will fetch all the required packages, including flutter_riverpod, hive_flutter, and other dependencies.

#Step 3: Configure Hive
Ensure that you have configured Hive for local storage.

Add the hive and hive_flutter dependencies to your pubspec.yaml file.
Register Hive adapters (done in the code automatically).

#Step 4: Run the App
To run the app, make sure you have an emulator or a connected device. Then, execute the following command:

flutter run
This will compile and launch the app on your chosen device or simulator.

