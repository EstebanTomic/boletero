import 'package:boletero/models/tickets_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketRepository extends GetxController with StateMixin {
  final _db = FirebaseFirestore.instance;
  var suma = 0;
  var count = 0;
  RxList<TicketsModel> ticketsDocuments = <TicketsModel>[].obs;
  RxInt totalMount = 0.obs;
  RxInt totalQuantity = 0.obs;
  RxInt avgMount = 0.obs;

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
      suma = 0;
      count = 0;
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
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Asegúrate de que el campo exista y sea numérico antes de sumarlo
        count++;
        if (doc.data() != null) {
          suma += int.parse(doc['monto']);
        }
      }
      totalMount.value = suma;
      totalQuantity.value = count;
      final avg = suma ~/ count;
      avgMount.value = avg;
      print('Suma: $suma');
      change(null, status: RxStatus.success());
    } catch (e) {
      print('Error al obtener documentos: $e');
      change(null, status: RxStatus.success());
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

  insertTicketManual() async {}
}
