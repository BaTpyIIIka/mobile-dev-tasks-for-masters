import 'package:dogs_client_application/interactors/auth_repository.dart';
import 'package:dogs_client_application/ui/auth/LoginSignupPage.dart';
import 'package:flutter/material.dart';

//Экран профиля
class ProfileScreen extends StatelessWidget {
  String avatarPlaceholder =
      "https://lh3.googleusercontent.com/a-/AOh14Gi7pJ6lEtInpImF0Hckiz_OHPAcC84guXClo7dA=s96-c";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Profile",
          style: new TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        imageUrl ?? avatarPlaceholder,
                      ),
                      radius: 60,
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'NAME',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Text(
                      name ?? "Unknown",
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'EMAIL',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Text(
                      email ?? "Unknown",
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40),
                    RaisedButton(
                      onPressed: () {
                        signOutGoogle();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) {
                          return LoginSignupPage();
                        }), ModalRoute.withName('/'));
                      },
                      color: Colors.deepPurpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                    )
                  ])),
        ),
      ),
    );
  }
}
