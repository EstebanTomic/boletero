

import 'package:boletero/models/ticket_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketRepository extends GetxController {

  static TicketRepository get instance => Get.find();
  RxList<TicketModel> ticketsDocuments = <TicketModel>[].obs;
  final _db = FirebaseFirestore.instance;

  createTicket(TicketModel ticket) async {
    await _db.collection('ticket').add(ticket.toJson()).whenComplete(
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

  
  Future<void> fetchTicketDocuments(String? userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('ticket')
          .where('idCliente', isEqualTo: userId)
          .get();
      ticketsDocuments.value = querySnapshot.docs.map((doc) => 
      TicketModel(xml: doc['xml'], 
                        monto: doc['monto'], 
                        rut: doc['rut'], 
                        folio: doc['folio'], 
                        fecha: doc['fecha'], 
                        empresa: doc['empresa'], 
                        razonSocial: doc['razonSocial'])
      ).toList();
    } catch (e) {
      print('Error al obtener documentos: $e');
    }
}


  deleteTicketById(int id) {
      _db.collection('ticket')
        .doc(id.toString())
        .delete();
  }

}