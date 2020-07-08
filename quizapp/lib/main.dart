import 'package:flutter/material.dart';
import './helper/functions.dart';
import './views/home.dart';
import './views/signup.dart';
import './views/signin.dart';

void main() => runApp(MyApp());

enum AuthMode { LOGIN, SINGUP }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedin = false;
  @override
  void initState() {
    checkuserLoggedInStatus();
    super.initState();
  }

  checkuserLoggedInStatus() async {
    HelperFunctions.getuserLoggedInDetails().then((value) {
      setState(() {
        isLoggedin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (isLoggedin ?? false) ? Home() : LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  double screenHeight;

  // Set intial mode to login
  AuthMode _authMode = AuthMode.LOGIN;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                lowerHalf(context),
                upperHalf(context),
                _authMode == AuthMode.LOGIN
                    ? loginCard(context)
                    : singUpCard(context),
                pageTitle(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Icon(
          //Icons.home,
          //size: 48,
          //color: Colors.white,
          //),
          Text(
            " ",
            style: TextStyle(
                fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        SignIn(screenHeight),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Don't have an account ?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  _authMode = AuthMode.SINGUP;
                });
              },
              textColor: Colors.black87,
              child: Text("Create Account"),
            )
          ],
        )
      ],
    );
  }

  Widget singUpCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight / 5),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          SignUp(screenHeight),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text(
                "Already have an account?",
                style: TextStyle(color: Colors.grey),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _authMode = AuthMode.LOGIN;
                  });
                },
                textColor: Colors.black87,
                child: Text("Login"),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              child: Text(
                "Terms & Conditions",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'assets/images/temple.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        color: Color(0xFFECF0F3),
      ),
    );
  }
}
