import 'package:flutter/material.dart';
import '../helper/functions.dart';
import '../views/home.dart';
import '../services/auth.dart';
import '../widgets/wid.dart';
import './signin.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  final screenHeight;

  SignUp(this.screenHeight);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password, _confirmpassword;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupconfirmation = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthService authService = new AuthService();
  bool _isLoading = false;
  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .signUpWithEmailAndPassword(_email, _password)
          .then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
        }
      });
      HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupconfirm() {
    setState(() {
      _obscureTextSignupconfirmation = !_obscureTextSignupconfirmation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _isLoading
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
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Create Account",
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
                                FontAwesomeIcons.user,
                                color: Colors.lightBlueAccent,
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
                          obscureText: _obscureTextSignup,
                          decoration: InputDecoration(
                            labelText: "Password",
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.lightBlueAccent,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignup,
                              child: Icon(
                                _obscureTextSignup
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
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
                        TextFormField(
                          obscureText: _obscureTextSignupconfirmation,
                          decoration: InputDecoration(
                            labelText: "Password confirmation",
                            icon: Icon(FontAwesomeIcons.lock,
                                color: Colors.lightBlueAccent),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignupconfirm,
                              child: Icon(
                                _obscureTextSignupconfirmation
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (val) {
                            if (val != _password) {
                              return "Not Matched";
                            }
                          },
                          onChanged: (val) {
                            setState(() => _confirmpassword = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Password must be at least 8 characters and include a special character and number",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            FlatButton(
                                child: Text("Sign Up"),
                                color: Color(0xFF4B9DFE),
                                textColor: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 38, right: 38, top: 15, bottom: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  signUp();
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
