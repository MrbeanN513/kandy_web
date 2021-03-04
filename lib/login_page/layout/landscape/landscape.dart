import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kandy/login_page/util/authentication_service.dart';
import 'package:kandy/login_page/util/screensize.dart';
import 'package:provider/provider.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class MylandscapeHomePage extends StatefulWidget {
  MylandscapeHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MylandscapeHomePageState createState() => _MylandscapeHomePageState();
}

class _MylandscapeHomePageState extends State<MylandscapeHomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.jpeg"), fit: BoxFit.cover)),
        child: Stack(
          children: [
            buttomBar(
              scaler.getWidth(5),
            ),
            Loginlayout(),
          ],
        ),
      ),
    );
  }
}

Widget buttomBar(double? height) {
  return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: height,
        color: Colors.black.withAlpha(235),
        child: ListTile(
          trailing: Text("Need Help?",
              style: TextStyle(color: Colors.white, fontSize: 13)),
          title: Text("© Copyright 2021 - unlimited \nMade by Goutam & Tapos",
              style: TextStyle(color: Colors.white, fontSize: 13)),
          
        ),
      ));
}

class Loginlayout extends StatefulWidget {
  Loginlayout({Key? key}) : super(key: key);

  @override
  _LoginlayoutState createState() => _LoginlayoutState();
}

class _LoginlayoutState extends State<Loginlayout> {
  bool _obscureText = true;
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  FocusNode currentNode = FocusNode();
  FocusNode nextFocus = FocusNode();
  FocusNode button = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Example code of how to sign in with email and password.
  Future<void> _signInWithEmailAndPassword() async {
    try {
      final User user = (await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ))
          .user;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${user.email} signed in'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xffFF0000),
          content: Text(
            'Failed to sign in with Email & Password',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Container(
      child: Center(
        child: Container(
            // color: Colors.orange,
            width: scaler.getHeight(75),
            height: scaler.getWidth(75),
            child: Card(
              // color: Colors.transparent,
              color: Colors.black.withAlpha(175),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // color: Colors.orange,
                        width: scaler.getHeight(20),
                        height: scaler.getHeight(20),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                _formKey.currentState!.reset();
                              });
                            },
                            child: Image.asset('assets/images/logo.png')),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(scaler.getWidth(2), 0,
                            scaler.getWidth(2), scaler.getWidth(2)),
                        child: TextFormField(
                          controller: emailController,
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onFieldSubmitted: (value) {
                            currentNode.unfocus();
                            FocusScope.of(context).requestFocus(nextFocus);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'UserName Required!';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'Use Valid Email like-"johndoe@email.com"';
                            }

                            return null;
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          cursorColor: Colors.redAccent[700],
                          decoration: InputDecoration(
                            fillColor: Colors.redAccent[700],
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xffFF0000), width: 2.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: 'User Name',
                            suffixIcon: InkWell(focusColor: Color(0xff2e2d40),
                              onTap: () {
                                setState(() {
                                  _formKey.currentState!.reset();
                                });
                              },
                              child: Icon(
                                Icons.keyboard_backspace,
                                size: 25.0,
                                color: Colors.white,
                              ),
                            ),
                            prefixIcon: Icon(Icons.person, color: Colors.grey),
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            scaler.getWidth(2), 0, scaler.getWidth(2), 0),
                        child: TextFormField(
                          controller: passwordController,
                          textInputAction: TextInputAction.next,
                          focusNode: nextFocus,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onFieldSubmitted: (value) {
                            nextFocus.unfocus();
                            FocusScope.of(context).requestFocus(button);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Password Required!';
                            }
                            if (value.length < 6) {
                              return 'Password Must be 6 Digit Long!';
                            }
                            return null;
                          },
                          obscuringCharacter: "*",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          cursorColor: Colors.redAccent[700],
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            fillColor: Colors.redAccent[700],
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xffFF0000), width: 2.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            prefixIcon:
                                Icon(Icons.lock_open, color: Colors.grey),
                            suffixIcon: InkWell(focusColor: Color(0xff2e2d40),
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                                size: 25.0,
                                color: Colors.white,
                              ),
                            ),
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(scaler.getWidth(2)),
                        child: ElevatedButton(
                          focusNode: button,
                          child: Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            primary: Colors.redAccent[700],
                            onSurface: Colors.grey,
                            side: BorderSide(color: Colors.black, width: 1),
                            elevation: 20,
                            minimumSize: Size(400, 50),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await _signInWithEmailAndPassword();
                            }
                          },
                        ),
                      ),
                      TextButton(
                          onPressed: null,
                          child: Text(
                            "Forgot password",
                            style: TextStyle(color: Colors.white60),
                          )),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
