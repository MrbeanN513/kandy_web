part of kandy;

class FirestoreExampleApp extends StatelessWidget {
  const FirestoreExampleApp({Key? key}) : super(key: key);
  MaterialApp withMaterialApp(Widget body) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firestore Example App',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: body,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return withMaterialApp(Center(child: FilmList()));
  }
}

class FilmList extends StatefulWidget {
  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  ScrollController? _scrollcontroller;
  ScrollController? _scrollcontroller2;
  bool _barhide = false;
  String catargory = 'BANGLA';
  String imagEurl = 'a';
  String videOurl = 'aa';

  @override
  void initState() {
    _scrollcontroller = ScrollController();
    _scrollcontroller2 = ScrollController();

    Wakelock.enable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection(catargory);

    void handlehide(BuildContext context) {
      setState(() {
        _barhide = !_barhide;
        print(_barhide);
      });
      print("object");
    }

    void handleTaphide() {
      setState(() {
        _barhide = !_barhide;
        print(_barhide);
      });
      print("object");
    }

    void handlesearchontap() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CloudFirestoreSearch()));
    }

    void handletv(BuildContext context) {
      showDialog(
        barrierColor: Colors.black87,
        context: context,
        builder: (context) => PageDialouge(
          onEnterpage1: (BuildContext context) {
            setState(() {
              Navigator.of(context).pop();
              imagEurl = 'a';
              videOurl = 'aa';
            });
          },
          onEnterpage2: (BuildContext context) {
            setState(() {
              Navigator.of(context).pop();
              imagEurl = 'b';
              videOurl = 'bb';
            });
          },
          onEnterpage3: (BuildContext context) {
            setState(() {
              Navigator.of(context).pop();
              imagEurl = 'c';
              videOurl = 'cc';
            });
          },
          onEnterpage4: (BuildContext context) {
            setState(() {
              Navigator.of(context).pop();
              imagEurl = 'd';
              videOurl = 'dd';
            });
          },
          ontappage1: () {
            setState(() {
              Navigator.of(context).pop();
              imagEurl = 'a';
              videOurl = 'aa';
            });
          },
          ontappage2: () {
            setState(() {
              Navigator.of(context).pop();
              imagEurl = 'b';
              videOurl = 'bb';
            });
          },
          ontappage3: () {
            setState(() {
              Navigator.of(context).pop();
              imagEurl = 'c';
              videOurl = 'cc';
            });
          },
          ontappage4: () {
            setState(() {
              Navigator.of(context).pop();
              imagEurl = 'd';
              videOurl = 'dd';
            });
          },
        ),
      );
    }

    void handletvontap() {
      showDialog(
        barrierColor: Colors.black87,
        context: context,
        builder: (context) => PageDialouge(
          ontappage1: () {
            setState(() {
              Navigator.of(context).pop();
              imagEurl = 'a';
              videOurl = 'aa';
            });
          },
          ontappage2: () {
            setState(() {
              Navigator.of(context).pop();
              imagEurl = 'b';
              videOurl = 'bb';
            });
          },
          ontappage3: () {
            setState(() {
              Navigator.of(context).pop();
              imagEurl = 'c';
              videOurl = 'cc';
            });
          },
          ontappage4: () {
            setState(() {
              Navigator.of(context).pop();
              imagEurl = 'd';
              videOurl = 'dd';
            });
          },
        ),
      );
    }

    void handleuserontap() {
      showDialog(
        barrierColor: Colors.black87,
        context: context,
        builder: (context) => CustomDialouge(),
      );
    }

    void handleuser(BuildContext context) {
      showDialog(
        barrierColor: Colors.black87,
        context: context,
        builder: (context) => CustomDialouge(),
      );
    }

    void handlesearch(BuildContext context) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CloudFirestoreSearch()));
    }

    return ConnectivityBuilder(
      builder: (context, isConnected, status) => Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.black,
            appBar: aioAppBar(
              handlehide,
              handlesearch,
              handletv,
              handleuser,
              handleTaphide,
              handlesearchontap,
              handletvontap,
              handleuserontap,
            ),
            body: SingleChildScrollView(
              controller: _scrollcontroller2,
              scrollDirection: Axis.horizontal,
              child: ConnectivityBuilder(
                builder: (context, isConnected, status) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                        visible: _barhide ? false : true, child: sidebar()),
                    SizedBox(
                      width: _barhide
                          ? MediaQuery.of(context).size.width
                          : MediaQuery.of(context).size.width - 56,
                      height: MediaQuery.of(context).size.height,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: query.snapshots(),
                        builder: (context, stream) {
                          if (stream.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SpinKitCircle(
                                color: Color(0xffFF0000),
                                size: 50.0,
                              ),
                            );
                          }

                          if (stream.hasError) {
                            return Center(child: Text(stream.error.toString()));
                          }

                          QuerySnapshot? querySnapshot = stream.data;

                          return Scaffold(
                            backgroundColor: Colors.black,
                            resizeToAvoidBottomInset: true,
                            body: Scrollbar(
                              isAlwaysShown: false,
                              controller: _scrollcontroller,
                              child: GridView.builder(
                                controller: _scrollcontroller,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250,
                                  childAspectRatio: 3 / 4,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                ),
                                itemCount: querySnapshot!.size,
                                itemBuilder: (context, index) => Movie(
                                  querySnapshot.docs[index],
                                  imagEurl,
                                  videOurl,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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

  void sidebarMoviesOnTap() {
    showDialog(
      barrierColor: Colors.black87,
      context: context,
      builder: (context) => CatagoryDialouge(
        ontapBangla: () {
          setState(() {
            Navigator.of(context).pop();
            catargory = 'BANGLA';
          });
        },
        ontapBollywood: () {
          setState(() {
            Navigator.of(context).pop();
            catargory = 'BOLLYWOOD';
          });
        },
        ontapEnglish: () {
          setState(() {
            Navigator.of(context).pop();
            catargory = 'ENGLISH';
          });
        },
        ontapHindiDubbed: () {
          setState(() {
            Navigator.of(context).pop();
            catargory = 'HINDI_DUBBED';
          });
        },
        ontapSouth: () {
          setState(() {
            Navigator.of(context).pop();
            catargory = 'SOUTH';
          });
        },
      ),
    );
  }

  void handleEnterTapActionMoviessidebar(BuildContext context) {
    showDialog(
      barrierColor: Colors.black87,
      context: context,
      builder: (context) => CatagoryDialouge(
        handleEnterTapActionBangla: (BuildContext context) {
          setState(() {
            Navigator.of(context).pop();
            catargory = 'BANGLA';
          });
        },
        handleEnterTapActionBollywood: (BuildContext context) {
          setState(() {
            Navigator.of(context).pop();
            catargory = 'BOLLYWOOD';
          });
        },
        handleEnterTapActionEnglish: (BuildContext context) {
          setState(() {
            Navigator.of(context).pop();
            catargory = 'ENGLISH';
          });
        },
        handleEnterTapActionHindiDubbed: (BuildContext context) {
          setState(() {
            Navigator.of(context).pop();
            catargory = 'HINDI_DUBBED';
          });
        },
        handleEnterTapActionSouth: (BuildContext context) {
          setState(() {
            Navigator.of(context).pop();
            catargory = 'SOUTH';
          });
        },
      ),
    );
  }

  Widget sidebar() {
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height,
      duration: Duration(seconds: 1),
      curve: Curves.decelerate,
      color: Colors.transparent,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SidebarTv(
              ontap: () {},
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(Icons.home_outlined),
                title: Text("Home"),
              ),
            ),
            SidebarTv(
              ontap: () {
                sidebarMoviesOnTap();
              },
              handleEnterTapAction: handleEnterTapActionMoviessidebar,
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(Icons.local_movies_outlined),
                title: Text("Movies"),
              ),
            ),
            SidebarTv(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(Icons.tv_outlined),
                title: Text("Tvshow"),
              ),
            ),
            SidebarTv(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(Icons.person_outline),
                title: Text("Profile"),
              ),
            ),
            SidebarTv(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(Icons.settings_outlined),
                title: Text("Settings"),
              ),
            ),
            SidebarTv(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(Icons.notifications_active_outlined),
                title: Text("Notification"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollcontroller = ScrollController();
    _scrollcontroller2 = ScrollController();
    Wakelock.disable();

    super.dispose();
  }
}

class SidebarTv extends StatelessWidget {
  const SidebarTv({Key? key, this.child, this.ontap, this.handleEnterTapAction})
      : super(key: key);
  final Widget? child;
  final GestureTapCallback? ontap;
  final VoidBuildContext? handleEnterTapAction;
  @override
  Widget build(BuildContext context) {
    return FuchsiaSidebarButton(
      handleEnterTapAction: handleEnterTapAction,
      focusedBackgroundColor: Colors.red,
      nonFocusedBackgroundColor: Color(0xff323232),
      height: 50,
      focussedwidth: 250,
      nonfocussedwidth: 56,
      ontap: ontap,
      child: OverflowBox(
        alignment: Alignment.centerLeft,
        maxWidth: 250,
        child: SizedBox(
          width: 250,
          height: 50,
          child: child,
        ),
      ),
    );
  }
}

/// A single movie row.
class Movie extends StatelessWidget {
  /// Contains all snapshot data for a given movie.
  final DocumentSnapshot snapshot;
  final String imageurl;
  final String videourl;

  /// Initialize a [Move] instance with a given [DocumentSnapshot].
  Movie(this.snapshot, this.imageurl, this.videourl);

  /// Returns the [DocumentSnapshot] data as a a [Map].
  Map<String, dynamic> get movie {
    return snapshot.data();
  }

  /// Returns the movie poster.
  Widget get poster {
    return FittedBox(
      fit: BoxFit.fill,
      child: Center(
        child: OptimizedCacheImage(
            placeholder: (context, url) => Container(
                  height: 250,
                  width: 100,
                  color: Color(0xff323232),
                ),
            errorWidget: (context, url, error) => Container(
                  height: 250,
                  width: 400,
                  child: Center(
                      child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Center(
                      child: SpinKitCircle(
                        color: Color(0xffFF0000),
                        size: 50.0,
                      ),
                    ),
                  )),
                  color: Color(0xff323232),
                ),
            height: 250,
            imageUrl: movie[imageurl]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    navigatetoplayerdetails(String url) {
      String result = url.replaceAll("vlc://", "");

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => VideoApp(url: result)));
    }

    void _movielink(BuildContext context) {
      navigatetoplayerdetails(movie[videourl]);
    }

    void _launchwindows() {
      String windowsurl =
          "https://github.com/MrbeanN513/vlc-protocol/tree/master/windows";
      launch(windowsurl);
    }

    void _launchvlcURL() {
      String windowsurl =
          "https://github.com/MrbeanN513/vlc-protocol/tree/master/windows";
      String url = movie[videourl];
      // String result = url.replaceAll("vlc://", "");
      platform.when(
        android: () => launch(url),
      );
      platform.when(linux: () => launch(url));
      platform.when(
        windows: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xffFF0000),
          content: TextButton(
            onPressed: _launchwindows,
            child: RichText(text: TextSpan(children: [
             TextSpan(
              text:
              'Double click or enter to play....... ',
              style: TextStyle(color: Colors.white, fontSize: 12),),
              TextSpan(
              text:
              'if you want to run on vlc please visit-',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            TextSpan(
              text:
              ' $windowsurl',
              style: TextStyle(color: Color(0xff00008b), fontSize: 15),
            ),
            ])),
            // Text(
            //   'Double click or enter to play.....if you want to run on vlc please visit -$windowsurl',
            //   style: TextStyle(color: Colors.white, fontSize: 12),
            // ),
          ),
        )),
      );
    }
    // void _launchvlcURL() async =>
    // await canLaunch("/bin/"+movie[videourl]) ? await launch("/bin/"+movie[videourl]) : throw 'Could not launch "/bin/"+$movie[videourl]';

    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: FuchsiaMainButton(
        ontap: _launchvlcURL,
        autoFocus: true,
        height: double.maxFinite,
        width: double.maxFinite,
        focusedBackgroundDecoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(width: 10.0, color: Color(0xffFF0000)),
          borderRadius: BorderRadius.all(
              Radius.circular(15.0) //                 <--- border radius here
              ),
        ),
        nonFocusedBackgroundDecoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(width: 3.0, color: Colors.transparent),
          borderRadius: BorderRadius.all(
              Radius.circular(15.0) //                 <--- border radius here
              ),
        ),
        handleEnterTapAction: _movielink,
        focusedchild: poster,
        nonFocusedchild: poster,
      ),
    );
  }
}
