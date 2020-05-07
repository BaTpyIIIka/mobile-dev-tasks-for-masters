import 'package:dogs_client_application/interactors/auth_repository.dart';
import 'package:dogs_client_application/ui/main/FirstScreen.dart';
import 'package:flutter/material.dart';

//Экран авторизации
class LoginSignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((value) {
          // переход на следующий экран, авторизация исключается из стека экранов
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return FirstScreen();
              },
            ),
          );
        }).catchError((e) {
          handleError(e);
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleError(Exception e) {
    final snackBar = SnackBar(
        content: Text('An error occurred, please try later'),
        backgroundColor: Colors.red);
    print(e);
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }
}
