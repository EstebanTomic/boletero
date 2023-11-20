import 'package:boletero/models/tickets_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketRepository extends GetxController {
  final _db = FirebaseFirestore.instance;
  RxList<TicketsModel> ticketsDocuments = <TicketsModel>[].obs;

  createTicket(TicketsModel ticket) async {
    await _db
        .collection('tickets')
        .add(ticket.toJson())
        .whenComplete(() => Get.snackbar(
            'Success', 'La boleta se registró correctamente.',
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.white))
        .catchError((error, StackTrace) {
      Get.snackbar('Error', 'Algo ocurrió, intenta de nuevo.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<void> fetchTicketDocuments(String? userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('tickets')
              .where('idUsuario', isEqualTo: userId)
              .get();
      ticketsDocuments.value = querySnapshot.docs
          .map((doc) => TicketsModel(
              xml: doc['valor'],
              monto: doc['monto'],
              rut: doc['rut'],
              folio: doc['folio'],
              fecha: doc['fecha'],
              empresa: doc['empresa'],
              razonSocial: doc['razonSocial'],
              idUsuario: doc['idUsuario'],
              fechaCreacion: doc['fechaCreacion']))
          .toList();
    } catch (e) {
      print('Error al obtener documentos: $e');
    }
  }

  deleteTicketById(String? id) {
    _db.collection('tickets').doc(id.toString()).delete();
  }
}
