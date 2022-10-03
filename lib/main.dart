import 'package:flutter/material.dart';
import 'package:one_big_car/login_page.dart';
import 'package:one_big_car/user_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Big Car!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LogIn(),
        '/UserProfile': (context) => const UserProfile(),
      },
    );
  }
}
