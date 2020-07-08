import 'package:flutter/material.dart';
import '../helper/functions.dart';
import '../services/auth.dart';
import '../widgets/wid.dart';
import './signup.dart';
import './home.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  final screenHeight;
  SignIn(this.screenHeight);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  String _email, _password;
  bool _obscureTextLogin = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthService authService = new AuthService();
  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await authService.signInEmailAndPass(_email, _password).then((value) {
        if (value != null) {
          setState(() {
            isLoading = false;
          });
        }
      });
      HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: widget.screenHeight / 4),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "UserName",
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.lightBlueAccent,
                              size: 22.0,
                            )),
                        validator: (input) {
                          if (input.isEmpty) {
                            return "please type email";
                          }
                        },
                        onChanged: (val) {
                          setState(() => _email = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: _obscureTextLogin,
                        decoration: InputDecoration(
                            labelText: "Password",
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.lightBlueAccent,
                              size: 22.0,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                  _obscureTextLogin
                                      ? FontAwesomeIcons.eyeSlash
                                      : FontAwesomeIcons.eye,
                                  size: 15.0,
                                  color: Colors.lightBlueAccent),
                            )),
                        validator: (input) {
                          if (input.length < 8) {
                            return "Your password needs to be atleast 8";
                          }
                        },
                        onChanged: (val) {
                          setState(() => _password = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {},
                            child: Text("Forgot Password ?"),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          FlatButton(
                            child: Text("Login"),
                            color: Color(0xFF4B9DFE),
                            textColor: Colors.white,
                            padding: EdgeInsets.only(
                                left: 38, right: 38, top: 15, bottom: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              signIn();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
