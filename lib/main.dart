import 'package:boletero_qr_reader/pages/home_page.dart';
import 'package:boletero_qr_reader/pages/ticket_register_page.dart';
import 'package:boletero_qr_reader/providers/scan_list_provider.dart';
import 'package:boletero_qr_reader/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
        title: 'Boletero QR Reader',
        initialRoute: 'home',
        routes: {
          'home': ( _ ) => const HomePage(),
          'Boleta': ( _ ) => const TicketRegisterPage()
        },
        theme: ThemeData(
          primaryColor: Colors.black87,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.black87
          ),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            color: Colors.black87, //<-- SEE HERE
          ),
        ),
      ),
    );
  }
}
