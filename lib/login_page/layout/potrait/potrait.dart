part of kandy;

class MypotraitHomePage extends StatefulWidget {
  MypotraitHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MypotraitHomePageState createState() => _MypotraitHomePageState();
}

class _MypotraitHomePageState extends State<MypotraitHomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
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
    ScreenScaler scaler = ScreenScaler()..init(context);
    return ConnectivityBuilder(
      builder: (context, isConnected, status) => Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.black,
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg.jpeg"),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
                  buttomBar(
                    scaler.getWidth(5),
                  ),
                  Loginlayoutp(),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isConnected == false ? true : false,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.black54,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 50,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Icon(
                          Icons.cloud_off,
                          size: 150,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xffFF0000),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Please Connect to Internet",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class Loginlayoutp extends StatefulWidget {
  Loginlayoutp({Key? key}) : super(key: key);

  @override
  _LoginlayoutpState createState() => _LoginlayoutpState();
}

class _LoginlayoutpState extends State<Loginlayoutp> {
  bool _obscureText = true;
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  FocusNode currentNode = FocusNode();
  FocusNode nextFocus = FocusNode();
  FocusNode button = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            width: scaler.getWidth(75),
            height: scaler.getHeight(55),
            child: Card(
              color: Colors.black.withAlpha(225),
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
                        width: scaler.getWidth(30),
                        height: scaler.getHeight(10),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                _formKey.currentState!.reset();
                              });
                            },
                            child: Image.asset('assets/images/logo.png')),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(scaler.getWidth(5), 0,
                            scaler.getWidth(5), scaler.getWidth(2)),
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
                            suffixIcon: InkWell(
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
                            scaler.getWidth(5), 0, scaler.getWidth(5), 0),
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
                            suffixIcon: InkWell(
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
                        padding: EdgeInsets.all(scaler.getWidth(5)),
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
