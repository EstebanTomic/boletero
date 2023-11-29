import 'package:boletero/models/tickets_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketController extends GetxController with StateMixin {
  final _db = FirebaseFirestore.instance;
  RxList<TicketsModel> ticketsDocuments = <TicketsModel>[].obs;

  createTicket(TicketsModel ticket) async {
    await _db
        .collection('tickets')
        .add(ticket.toJson())
        .whenComplete(() => Get.snackbar(
            'Nueva Boleta', 'La boleta se registró correctamente.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.greenAccent,
            colorText: Colors.white))
        .catchError((error, StackTrace) {
      Get.snackbar('Error', 'Algo ocurrió, intenta de nuevo.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<void> fetchTicketDocuments(String? userId) async {
    try {
      // make status to loading
      change(null, status: RxStatus.loading());
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
      // if done, change status to success
      change(null, status: RxStatus.success());
    } catch (e) {
      print('Error al obtener documentos: $e');
    }
  }

  deleteTicketById(String? id) {
    print(_db.collection('tickets').doc(id.toString()).get());
    _db.collection('tickets').doc(id.toString()).delete();
  }

  deleteTicketsByUserId(String? userId) async {
    try {
      CollectionReference collectionReference = _db.collection('tickets');
      QuerySnapshot querySnapshot =
          await collectionReference.where('idUsuario', isEqualTo: userId).get();
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.delete();
      }
    } catch (e) {
      print('Error al eliminar documentos: $e');
    }
  }
}
