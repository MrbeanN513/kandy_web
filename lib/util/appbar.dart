// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kandy/util/button/button_dpad.dart';

PreferredSizeWidget aioAppBar(
  VoidBuildContext? _handleEnterTapActionhide,
  VoidBuildContext? _handleEnterTapActionuser,
) {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: FuchsiaAppbarButton(
          focusedBackgroundColor: Colors.white,
          nonFocusedBackgroundColor: Colors.transparent,
          height: 40.0,
          width: 50.0,
          focusedchild: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {}),
          nonFocusedchild: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: FuchsiaAppbarButton(
          focusedBackgroundColor: Colors.white,
          nonFocusedBackgroundColor: Colors.transparent,
          height: 40.0,
          width: 50.0,
          focusedchild: IconButton(
              icon: Icon(
                Icons.tv,
                color: Colors.black,
              ),
              onPressed: () {}),
          nonFocusedchild: IconButton(
              icon: Icon(
                Icons.tv,
                color: Colors.white,
              ),
              onPressed: () {}),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: FuchsiaAppbarButton(
          handleEnterTapAction: _handleEnterTapActionuser,
          focusedBackgroundColor: Colors.white,
          nonFocusedBackgroundColor: Colors.transparent,
          // autoFocus: true,
          height: 40.0,
          width: 50.0,
          nonFocusedchild: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
            ),
          ),
          focusedchild: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
            ),
          ),
        ),
      ),
    ],
    leading: FuchsiaAppbarButton(
        handleEnterTapAction: _handleEnterTapActionhide,
        nonFocusedBackgroundColor: Colors.transparent,
        focusedBackgroundColor: Colors.white,
        nonFocusedchild: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        focusedchild: Icon(
          Icons.menu,
          color: Colors.black,
        )),
    backgroundColor: Colors.black,
    // centerTitle: true,
    title: SizedBox(height: 50.0, child: Image.asset('assets/images/logo.png')),
  );
}

class CustomDialouge extends StatefulWidget {
  CustomDialouge({Key? key}) : super(key: key);

  @override
  _CustomDialougeState createState() => _CustomDialougeState();
}

class _CustomDialougeState extends State<CustomDialouge> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    return Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = _auth.currentUser;
    setState(() {});
  }

  void _logout(BuildContext context) {
    _signOut();
  }

  void _back(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    String name = "${user?.email}";
    String result = name.replaceAll(RegExp("@[a-zA-Z0-9]+\.[a-zA-Z]+"), (""));
    return Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff2e2d40),
          border: Border.all(width: 3.0, color: Colors.white),
          borderRadius: BorderRadius.all(
              Radius.circular(15.0) //                 <--- border radius here
              ),
        ),
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/pro_pic.png'))),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "UserName:",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  TextSpan(
                      text: " $result",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FuchsiaAppbarButton(
                handleEnterTapAction: _back,
                focusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xff4d4dff),
                  border: Border.all(width: 3.0, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                nonFocusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xff5a5a5a),
                  border: Border.all(width: 3.0, color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                height: 50,
                width: 150,
                autoFocus: true,
                nonFocusedchild: Center(
                  child: Text("Back",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                focusedchild: Center(
                  child: Text("Back",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: FuchsiaAppbarButton(
                  handleEnterTapAction: _logout,
                  focusedBackgroundDecoration: BoxDecoration(
                    color: Color(0xffFF0000),
                    border: Border.all(width: 3.0, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(
                            15.0) //                 <--- border radius here
                        ),
                  ),
                  nonFocusedBackgroundDecoration: BoxDecoration(
                    color: Color(0xff5a5a5a),
                    border: Border.all(width: 3.0, color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(
                            15.0) //                 <--- border radius here
                        ),
                  ),
                  height: 50,
                  width: 150,
                  nonFocusedchild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Logout",
                          style: TextStyle(color: Colors.white, fontSize: 15))
                    ],
                  ),
                  focusedchild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Logout",
                          style: TextStyle(color: Colors.white, fontSize: 15))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
