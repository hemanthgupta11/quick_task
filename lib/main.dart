import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quick_task/login_screen.dart';
import 'package:quick_task/signup_screen.dart';
import 'package:quick_task/task_list_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'sWBmaFIV6qcYgOUvhq0VZtzzG8gUkn85XwOfPQrg';
  const keyClientKey = '7NunAt3qabGa6x9GBzwimRhXUg9ybjWLR1NRsxOj';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/tasks': (context) => TaskListScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}