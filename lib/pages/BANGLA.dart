// import 'dart:async';
// import 'dart:html';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kandy/util/appbar.dart';
import 'package:kandy/util/button/button_dpad.dart';

import 'package:kandy/util/player/internal_videoplayer.dart';
import 'package:optimized_cached_image/image_cache_manager.dart';
import 'package:optimized_cached_image/widgets.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wakelock/wakelock.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FirestoreExampleApp extends StatelessWidget {
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

  @override
  void initState() {
    _scrollcontroller = ScrollController();
    _scrollcontroller2 = ScrollController();

    Wakelock.enable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection('BANGLA');

    void handlehide(BuildContext context) {
      setState(() {
        _barhide = !_barhide;
        print(_barhide);
      });
      print("object");
    }

    void handleuser(BuildContext context) {
      showDialog(
        barrierColor: Colors.black87,
        context: context,
        builder: (context) => CustomDialouge(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: aioAppBar(
        handlehide,
        handleuser,
      ),
      body: SingleChildScrollView(
        controller: _scrollcontroller2,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Visibility(visible: _barhide ? false : true, child: sidebar()),
            SizedBox(
              width: _barhide
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width - 56,
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder<QuerySnapshot>(
                stream: query.snapshots(),
                builder: (context, stream) {
                  if (stream.connectionState == ConnectionState.waiting) {
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
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          childAspectRatio: 3 / 4,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: querySnapshot!.size,
                        itemBuilder: (context, index) =>
                            Movie(querySnapshot.docs[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(Icons.home_outlined),
                title: Text("Home"),
              ),
            ),
            SidebarTv(
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
  const SidebarTv({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return FuchsiaSidebarButton(
      focusedBackgroundColor: Colors.red,
      nonFocusedBackgroundColor: Color(0xff323232),
      height: 50,
      focussedwidth: 250,
      nonfocussedwidth: 56,
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

  /// Initialize a [Move] instance with a given [DocumentSnapshot].
  Movie(this.snapshot);

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
            imageUrl: movie['a']),
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
      navigatetoplayerdetails(movie["aa"]);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: FuchsiaMainButton(
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
