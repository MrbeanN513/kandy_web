part of kandy;

PreferredSizeWidget aioAppBar(
  VoidBuildContext? _handleEnterTapActionhide,
  VoidBuildContext? _handleEnterTapActionSearch,
  VoidBuildContext? _handleEnterTapActionTv,
  VoidBuildContext? _handleEnterTapActionuser,
  GestureTapCallback? hideontap,
  GestureTapCallback? searchonTap,
  GestureTapCallback? pageonTap,
  GestureTapCallback? useronTap,
) {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: FuchsiaAppbarButton(
          ontap: searchonTap,
          handleEnterTapAction: _handleEnterTapActionSearch,
          focusedBackgroundColor: Colors.white,
          nonFocusedBackgroundColor: Colors.transparent,
          height: 40.0,
          width: 50.0,
          focusedchild: Icon(
            Icons.search,
            color: Colors.black,
          ),
          nonFocusedchild: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: FuchsiaAppbarButton(
          handleEnterTapAction: _handleEnterTapActionTv,
          ontap: pageonTap,
          focusedBackgroundColor: Colors.white,
          nonFocusedBackgroundColor: Colors.transparent,
          height: 40.0,
          width: 50.0,
          focusedchild: Icon(
            Icons.tv,
            color: Colors.black,
          ),
          nonFocusedchild: Icon(
            Icons.tv,
            color: Colors.white,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: FuchsiaAppbarButton(
          ontap: useronTap,
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
        ontap: hideontap,
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
                ontap: () {
                  Navigator.of(context).pop();
                },
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
                  ontap: () {
                    _signOut();
                  },
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

class CatagoryDialouge extends StatefulWidget {
  final GestureTapCallback? ontapBollywood;
  final GestureTapCallback? ontapBangla;
  final GestureTapCallback? ontapHindiDubbed;
  final GestureTapCallback? ontapSouth;
  final GestureTapCallback? ontapEnglish;
  final VoidBuildContext? handleEnterTapActionBollywood;
  final VoidBuildContext? handleEnterTapActionBangla;
  final VoidBuildContext? handleEnterTapActionHindiDubbed;
  final VoidBuildContext? handleEnterTapActionSouth;
  final VoidBuildContext? handleEnterTapActionEnglish;
  CatagoryDialouge(
      {Key? key,
      this.ontapBangla,
      this.ontapBollywood,
      this.ontapEnglish,
      this.ontapHindiDubbed,
      this.handleEnterTapActionBollywood,
      this.handleEnterTapActionEnglish,
      this.handleEnterTapActionBangla,
      this.handleEnterTapActionSouth,
      this.handleEnterTapActionHindiDubbed,
      this.ontapSouth})
      : super(key: key);

  @override
  _CatagoryDialougeState createState() => _CatagoryDialougeState();
}

class _CatagoryDialougeState extends State<CatagoryDialouge> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black38,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x592E2D40),
          border: Border.all(width: 3.0, color: Colors.white),
          borderRadius: BorderRadius.all(
              Radius.circular(15.0) //                 <--- border radius here
              ),
        ),
        height: 400.0,
        width: 250.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FuchsiaAppbarButton(
                handleEnterTapAction: widget.handleEnterTapActionEnglish,
                ontap: widget.ontapEnglish,
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
                  child: Text("English",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                focusedchild: Center(
                  child: Text("English",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FuchsiaAppbarButton(
                handleEnterTapAction: widget.handleEnterTapActionHindiDubbed,
                ontap: widget.ontapHindiDubbed,
                focusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xff4d4dff),
                  border: Border.all(width: 3.0, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                nonFocusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xCD5A5A5A),
                  border: Border.all(width: 3.0, color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                height: 50,
                width: 150,
                autoFocus: true,
                nonFocusedchild: Center(
                  child: Text("Hindi_Dubbed",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                focusedchild: Center(
                  child: Text("Hindi_Dubbed",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FuchsiaAppbarButton(
                handleEnterTapAction: widget.handleEnterTapActionBollywood,
                ontap: widget.ontapBollywood,
                focusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xff4d4dff),
                  border: Border.all(width: 3.0, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                nonFocusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xAA5A5A5A),
                  border: Border.all(width: 3.0, color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                height: 50,
                width: 150,
                autoFocus: true,
                nonFocusedchild: Center(
                  child: Text("Bollywood",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                focusedchild: Center(
                  child: Text("Bollywood",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FuchsiaAppbarButton(
                handleEnterTapAction: widget.handleEnterTapActionSouth,
                ontap: widget.ontapSouth,
                focusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xff4d4dff),
                  border: Border.all(width: 3.0, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                nonFocusedBackgroundDecoration: BoxDecoration(
                  color: Color(0x805A5A5A),
                  border: Border.all(width: 3.0, color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                height: 50,
                width: 150,
                autoFocus: true,
                nonFocusedchild: Center(
                  child: Text("South",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                focusedchild: Center(
                  child: Text("South",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FuchsiaAppbarButton(
                handleEnterTapAction: widget.handleEnterTapActionBangla,
                ontap: widget.ontapBangla,
                focusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xff4d4dff),
                  border: Border.all(width: 3.0, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                nonFocusedBackgroundDecoration: BoxDecoration(
                  color: Color(0x5D5A5A5A),
                  border: Border.all(width: 3.0, color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                height: 50,
                width: 150,
                autoFocus: true,
                nonFocusedchild: Center(
                  child: Text("Bangla",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                focusedchild: Center(
                  child: Text("Bangla",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageDialouge extends StatefulWidget {
  final GestureTapCallback? ontappage1;
  final GestureTapCallback? ontappage2;
  final GestureTapCallback? ontappage3;
  final GestureTapCallback? ontappage4;
  final VoidBuildContext? onEnterpage1;
  final VoidBuildContext? onEnterpage2;
  final VoidBuildContext? onEnterpage3;
  final VoidBuildContext? onEnterpage4;

  PageDialouge({
    Key? key,
    this.ontappage1,
    this.ontappage2,
    this.ontappage3,
    this.ontappage4,
    this.onEnterpage1,
    this.onEnterpage2,
    this.onEnterpage3,
    this.onEnterpage4,
  }) : super(key: key);

  @override
  _PageDialougeState createState() => _PageDialougeState();
}

class _PageDialougeState extends State<PageDialouge> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black38,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x592E2D40),
          border: Border.all(width: 3.0, color: Colors.white),
          borderRadius: BorderRadius.all(
              Radius.circular(15.0) //                 <--- border radius here
              ),
        ),
        height: 400.0,
        width: 250.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FuchsiaAppbarButton(
                handleEnterTapAction: widget.onEnterpage1,
                ontap: widget.ontappage1,
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
                  child: Text("Page1",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                focusedchild: Center(
                  child: Text("Page1",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FuchsiaAppbarButton(
                handleEnterTapAction: widget.onEnterpage2,
                ontap: widget.ontappage2,
                focusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xff4d4dff),
                  border: Border.all(width: 3.0, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                nonFocusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xCD5A5A5A),
                  border: Border.all(width: 3.0, color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                height: 50,
                width: 150,
                autoFocus: true,
                nonFocusedchild: Center(
                  child: Text("Page2",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                focusedchild: Center(
                  child: Text("Page2",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FuchsiaAppbarButton(
                handleEnterTapAction: widget.onEnterpage3,
                ontap: widget.ontappage3,
                focusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xff4d4dff),
                  border: Border.all(width: 3.0, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                nonFocusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xAA5A5A5A),
                  border: Border.all(width: 3.0, color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                height: 50,
                width: 150,
                autoFocus: true,
                nonFocusedchild: Center(
                  child: Text("Page3",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                focusedchild: Center(
                  child: Text("Page3",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FuchsiaAppbarButton(
                handleEnterTapAction: widget.onEnterpage4,
                ontap: widget.ontappage4,
                focusedBackgroundDecoration: BoxDecoration(
                  color: Color(0xff4d4dff),
                  border: Border.all(width: 3.0, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                nonFocusedBackgroundDecoration: BoxDecoration(
                  color: Color(0x805A5A5A),
                  border: Border.all(width: 3.0, color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                ),
                height: 50,
                width: 150,
                autoFocus: true,
                nonFocusedchild: Center(
                  child: Text("Page4",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                focusedchild: Center(
                  child: Text("Page4",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
