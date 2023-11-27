import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    var currentIndex = uiProvider.selectedMenuOpt;
    if (currentIndex >= 2) currentIndex = 0;
    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedMenuOpt = i,
      selectedItemColor: Color.fromARGB(205, 0, 115, 198),
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner), label: 'Mis Boletas'),
        BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq_sharp), label: 'Estadisticas'),
      ],
    );
  }
}
