# **Task Management App (QuickTask)**

QuickTask is a simplified task management application built using Flutter and Back4App. It allows users to organize their tasks efficiently, providing features like task creation, editing, deletion, and status management.

---

## **Features**

- **User Authentication**
    - Secure login and signup using Back4App.
    - Logout functionality for users.

- **Task Management**
    - Add, view, edit, and delete tasks.
    - Mark tasks as completed or incomplete.
    - Each task is associated with the logged-in user.

- **Enhanced UI**
    - Beautiful and responsive user interface using Flutter.

- **Error Handling**
    - Comprehensive error handling for API calls and user input.

---

## **Prerequisites**

Ensure the following are installed and set up on your system:

1. **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
2. **Dart**: Installed as part of the Flutter SDK.
3. **Back4App Account**: [Sign up for Back4App](https://www.back4app.com/)
4. **IDE**: Visual Studio Code, Android Studio, or your preferred IDE with Flutter plugin.
5. **Device/Emulator**: An Android/iOS device or emulator.

---

## **Setup Instructions**

### **1. Clone the Repository**

```bash
git clone https://github.com/hemanthgupta11/quicktask.git
cd quicktask
```
### **2. Install Dependencies**
```bash
flutter pub get
```
### **3. Run the App**
- To run the app on an emulator or device:
   ```bash
   flutter run
   ```
---

## **Usage Instructions**
### **Login/Signup:**

Create a new account via the Signup screen or log in with existing credentials.
### **Add a Task:**

Use the Add Task button to create a new task. Provide a title, due date.
### **Edit a Task:**

Tap the edit icon next to a task to modify its details.
### **Delete a Task:**

Tap the delete icon next to a task and confirm deletion.
### **Manage Task Status:**

Use the checkbox to mark tasks as completed or incomplete.
### **Logout:**

Use the logout button in the AppBar to sign out.

---

## **Project Structure**
```text
lib/
├── main.dart                   # Application entry point
├── login_screen.dart           # User login screen
├── signup_screen.dart          # User signup screen
├── task_list_screen.dart       # Task listing screen
├── task_add_screen.dart        # Add task screen
├── edit_task_screen.dart       # Edit task screen
```


