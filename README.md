# Task Manager App <br>
A simple task management app built with Flutter, using Riverpod for state management and Hive for local storage. The app allows users to create, edit, delete tasks, filter them by title or description, and track progress with the ability to mark tasks as completed. <br><br>

## Features <br>
Add, edit, delete tasks.<br>
Filter tasks by title or description.<br>
Mark tasks as completed.<br>
Display task priority and due date.<br>
Progress indicator showing completed vs. total tasks.<br>
Animated transitions and smooth UI updates.<br><br>

## Requirements <br>
Flutter 3.0 or higher<br>
Dart 2.18 or higher<br>
Hive for local storage<br>
Riverpod for state management<br><br>

## Assumptions<br>
The user is familiar with Flutter and basic app development.<br>
The app assumes that the user has a Flutter development environment already set up.<br>
The app uses local storage (Hive), so data will persist even if the app is closed or restarted.<br>
The tasks are saved locally and are not synced across devices or platforms.<br><br>

## **Installation** <br><br>

To get started, follow these steps to set up the app locally:<br>

**Step 1: Clone the Repository**<br>
Clone this repository to your local machine using the following command:<br>

git clone https://github.com/sachinprabuditha/Task-Manager-App.git <br>
cd task_manager_app <br><br>

**Step 2: Install Dependencies** <br>
Make sure you have Flutter installed. Then, run the following command to install the necessary dependencies:<br><br>

flutter pub get<br>
This will fetch all the required packages, including flutter_riverpod, hive_flutter, and other dependencies.<br><br>

**Step 3: Configure Hive**<br>
Ensure that you have configured Hive for local storage.<br><br>

Add the hive and hive_flutter dependencies to your pubspec.yaml file.<br>
Register Hive adapters (done in the code automatically).<br><br>

**Step 4: Run the App** <br>
To run the app, make sure you have an emulator or a connected device. Then, execute the following command:<br><br>

flutter run<br>
This will compile and launch the app on your chosen device or simulator.<br>

