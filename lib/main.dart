import 'package:boletero/providers/scan_list_provider.dart';
import 'package:boletero/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:boletero/pages/boletas_page.dart';
import 'package:boletero/pages/home_page.dart';
import 'package:boletero/pages/ticket_register_page.dart';

//import 'package:flutter/rendering.dart';

void main() {
  // Habilitar Lineas debug
  //debugPaintSizeEnabled = true;
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
        ChangeNotifierProvider(create: (_) => ScanListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Boletero',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'misBoletas': (_) => const TicketRegisterPage(),
          'boleta': (_) => const BoletasPage(),
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
