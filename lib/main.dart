library kandy;
//!flutter import

// ignore: import_of_legacy_library_into_null_safe
import 'package:cross_connectivity/cross_connectivity.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:optimized_cached_image/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:optimized_cached_image/optimized_cached_image.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wakelock/wakelock.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:video_player/video_player.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import 'package:platform_info/platform_info.dart';


//* my_import
part 'package:kandy/login_page/layout/landscape/landscape.dart';
part 'package:kandy/login_page/layout/potrait/potrait.dart';
part 'package:kandy/login_page/util/authentication_service.dart';
part 'package:kandy/login_page/util/screensize.dart';
part 'package:kandy/pages/BANGLA.dart';
part 'package:kandy/util/splashscreen.dart';
part 'package:kandy/util/appbar.dart';
part 'package:kandy/util/button/button_dpad.dart';
part 'package:kandy/util/player/internal_videoplayer.dart';
part 'package:kandy/util/button/shortcut.dart';
part 'package:kandy/util/search.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Shortcuts(
      // needed for AndroidTV to be able to select
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new SplashScreen(),
          routes: <String, WidgetBuilder>{
            '/RootPage': (BuildContext context) => MyApp(),
          }),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: Shortcuts(
        // needed for AndroidTV to be able to select
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthenticationWrapper(),
        ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    // ignore: unnecessary_null_comparison
    if (firebaseUser != null) {
      return FirestoreExampleApp();
    }
    return Layout();
  }
}

class Layout extends StatefulWidget {
  Layout({Key? key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: MylandscapeHomePage());
    } else {
      return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: MypotraitHomePage());
    }
  }
}
