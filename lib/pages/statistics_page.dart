import 'package:boletero/providers/ticket_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'pages.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});
  static const String routerName = 'TicketStatistics';

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;

    TicketRepository tr = Get.put(TicketRepository());
    tr.fetchTicketDocuments(uid);

    final totalQuantity = tr.totalQuantity;
    final totalMount = tr.totalMount;
    final avgMount = tr.avgMount;

    final formatAvgMount = NumberFormat('#,###', 'es_CL')
        .format(int.parse(avgMount.value.toString()));

    final formatTotalMount = NumberFormat('#,###', 'es_CL')
        .format(int.parse(totalMount.value.toString()));

    return tr.obx(
      (state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 400,
                height: 500,
                decoration: const BoxDecoration(
                    //borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Cabecera
                    Container(
                      alignment: Alignment.center,
                      width: 400,
                      height: 120,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Boletas registradas: $totalQuantity",
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(205, 0, 115, 198),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Tu gasto promedio: \$ $formatAvgMount",
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(205, 0, 115, 198),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Monto Total de tus boletas: \$ $formatTotalMount",
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(205, 0, 115, 198),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto"),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      onLoading: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Center(child: new CircularProgressIndicator())),
    );

    //return const Center(
    //  child: Text('Proximamente'),
    //);
  }
}
