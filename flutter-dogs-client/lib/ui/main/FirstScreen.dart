import 'package:dogs_client_application/ui/main/BreedList.dart';
import 'package:dogs_client_application/ui/profile/ProfileScreen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FirstScreenState();
  }

}

class FirstScreenState extends State<FirstScreen> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Breeds',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Breeds'),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                _openProfile();
              },
            )
          ],
        ),
        body: Center(
          child: BreedList(),
        ),
      ),
    );
  }

  Future<Object> _openProfile() {
    // переход на следующий экран
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ProfileScreen();
        },
      ),
    );
  }

}
