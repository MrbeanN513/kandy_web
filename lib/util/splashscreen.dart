import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/RootPage');
  }

void initState() {
    super.initState();
    startTime();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
     DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
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
    return new Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: <Widget>[
        Center(child: new Image.asset('assets/images/launch_image.png')),
        Padding(
          padding: const EdgeInsets.only(top: 250.0),
          child: Center(
            child: Container(
              width: 500,
              child: Align(
                alignment: Alignment.center,
                child: SpinKitCircle(
                  color: Color(0xffFF0000),
                  size: 50.0,
                ),
                // CircularProgressIndicator(
                //   valueColor:
                //       new AlwaysStoppedAnimation<Color>(Color(0xffFF0000)),
                // ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
