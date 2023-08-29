import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView con Cards'),
      ),
      body: ListView.builder(
        itemCount: 10, // Cantidad de elementos en la lista
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 3, // Elevación de la tarjeta
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              title: Text('Elemento $index'),
              subtitle: Text('Descripción del elemento $index'),
              leading: Icon(Icons.star), // Icono a la izquierda
              trailing: Icon(Icons.arrow_forward), // Icono a la derecha
            ),
          );
        },
      ),
    );
  }
}
