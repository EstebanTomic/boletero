import 'package:boletero/pages/pages.dart';
import 'package:boletero/pages/sign_up.dart';
import 'package:boletero/pages/splash_screen.dart';
import 'package:boletero/providers/firebase_auth_provider.dart';
import 'package:boletero/providers/scan_list_provider.dart';
import 'package:boletero/providers/ui_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:boletero/pages/boletas_page.dart';
import 'package:boletero/pages/home_page.dart';
import 'package:boletero/pages/ticket_register_page.dart';

void main() async {
  // Habilitar Lineas debug
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  //FlutterSecureStorage.setMockInitialValues({});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Boletero',
        initialRoute: '/',
        routes: {
          '/': (_) => SplashScreen(
                // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
                child: LoginPage(),
              ),
          LoginPage.routerName : (_) => LoginPage(),
          SignUpPage.routerName: (_) => SignUpPage(),
          HomePage.routerName: (_) => HomePage(),
          TicketRegisterPage.routerName: (_) => const TicketRegisterPage(),
          BoletasPage.routerName: (_) => const BoletasPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.black87,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.black87),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            color: Colors.black87, //<-- SEE HERE
          ),
        ),
      ),
    );
  }
}
