import 'package:boletero/models/tickets_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketRepository extends GetxController with StateMixin {
  final _db = FirebaseFirestore.instance;
  RxList<TicketsModel> ticketsDocuments = <TicketsModel>[].obs;

  createTicket(TicketsModel ticket) async {
    await _db
        .collection('tickets')
        .add(ticket.toJson())
        .whenComplete(() => Get.snackbar(
            'Nueva Boleta', 'La boleta se registró correctamente.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.greenAccent.withOpacity(0.5),
            colorText: Colors.white))
        .catchError((error, StackTrace) {
      Get.snackbar('Error', 'Algo ocurrió, intenta de nuevo.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.red);
      print(error.toString());
    });
    fetchTicketDocuments(ticket.idUsuario);
  }

  Future<void> fetchTicketDocuments(String? userId) async {
    try {
      // make status to loading
      change(null, status: RxStatus.loading());
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
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
      change(null, status: RxStatus.success());
    }
  }

  deleteTicketById(String? id) {
    try {
      _db.collection('tickets').doc(id.toString()).delete();
    } catch (e) {
      print('Error al eliminar documentos: $e');
    }
  }

  deleteTicketByFields(String? userId, String rut, String folio) async {
    try {
      change(null, status: RxStatus.loading());
      await _db
          .collection('tickets')
          .where('idUsuario', isEqualTo: userId)
          .where('rut', isEqualTo: rut)
          .where('folio', isEqualTo: folio)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          _db.collection("tickets").doc(element.id).delete().then((value) {
            print("Success!");
          });
        });
      });
      // if done, change status to success
      fetchTicketDocuments(userId);
    } catch (e) {
      print('Error al eliminar documentos: $e');
    }
  }

  deleteTicketByUuid(String? id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('tickets')
              .where('id', isEqualTo: id)
              .get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Error al eliminar documentos: $e');
    }
  }
}
