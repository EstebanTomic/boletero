import 'package:boletero/pages/pages.dart';
import 'package:boletero/pages/sign_up.dart';
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
    const bgColor = Color.fromARGB(205, 0, 115, 198);
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
          '/': (_) =>  const LoginPage(),
          LoginPage.routerName : (_) => LoginPage(),
          SignUpPage.routerName: (_) => SignUpPage(),
          HomePage.routerName: (_) => HomePage(),
          TicketRegisterPage.routerName: (_) => const TicketRegisterPage(),
          BoletasPage.routerName: (_) => const BoletasPage(),
        },
        theme: ThemeData(
          primaryColor: bgColor,
          scaffoldBackgroundColor: Colors.white,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: bgColor),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            color: bgColor, //<-- SEE HERE
          ),
        ),
      ),
    );
  }
}
