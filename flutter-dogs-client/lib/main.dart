import 'package:dogs_client_application/ui/auth/LoginSignupPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dogs App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignupPage(),
    );
  }
}
