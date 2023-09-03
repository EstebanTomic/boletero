

import 'package:boletero/models/boleta_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoletaRepository extends GetxController {

  static BoletaRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createBoleta(BoletaModel boleta) async {
    await _db.collection('boletas').add(boleta.toJson()).whenComplete(
      () => Get.snackbar('Success', 'La boleta se registró correctamente.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green)
    )
    .catchError((error, StackTrace) {
       Get.snackbar('Error', 'Algo ocurrió, intenta de nuevo.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withOpacity(0.1),
      colorText: Colors.red);
      print(error.toString());
    });
  }

}