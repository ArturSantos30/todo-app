import 'package:flutter/material.dart';
import 'package:todoapp_mobile/screens/create_todo_page.dart';
import 'package:todoapp_mobile/screens/create_user_screen.dart';
import 'package:todoapp_mobile/screens/home_page.dart';
import 'package:todoapp_mobile/screens/login_screen.dart';
import 'package:todoapp_mobile/screens/splash_screen.dart';
import 'package:todoapp_mobile/screens/view_todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/splash",
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(),
        '/signup': (context) => const CreateUserScreen(),
        "/create_todo": (context) => CreateTodoPage(),
        "/view": (context) => const ViewTodoPage(),
      },
    );
  }
}