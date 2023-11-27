import 'dart:io';
import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:boletero/models/scan_model.dart';
import 'package:boletero/models/tickets_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

import 'pages.dart';

class BoletasPage extends StatelessWidget {
  const BoletasPage({super.key});
  static const String routerName = 'Boletas';
  @override
  Widget build(BuildContext context) {
    // final ScanModel scan =
    //     ModalRoute.of(context)!.settings.arguments as ScanModel;
    //

    final TicketsModel ticket =
        ModalRoute.of(context)!.settings.arguments as TicketsModel;

    final controller = ScreenshotController();
    String rut = ticket.rut;
    String folio = ticket.folio;
    String razonSocial = ticket.razonSocial;
    String fecha = ticket.fecha;
    String monto = ticket.monto;
    String data = ticket.xml;

    return Scaffold(
        backgroundColor: Colors.black87,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Screenshot(
                controller: controller,
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
                      CabeceraBoleta(rut: rut, folio: folio),
                      DetalleComercio(razonSocial: razonSocial),
                      DetalleCompra(fecha: fecha, monto: monto),
                      PDF417Barcode(data: data),
                    ],
                  ),
                ),
              ),
            ),
            ShareButton(controller: controller),
            BackButton(),
          ],
        ));
  }
}

class CabeceraBoleta extends StatelessWidget {
  const CabeceraBoleta({
    super.key,
    required this.rut,
    required this.folio,
  });

  final String rut;
  final String folio;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 330,
      height: 110,
      decoration: BoxDecoration(
        border: Border.all(width: 2.5),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "R.U.T.: $rut",
              style: const TextStyle(
                  fontSize: 22.0,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            ),
            Text(
              "BOLETA ELECTRÓNICA",
              style: const TextStyle(
                  fontSize: 22.0,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            ),
            Text(
              "N°: $folio",
              style: const TextStyle(
                  fontSize: 22.0,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            )
          ]),
    );
  }
}

class DetalleComercio extends StatelessWidget {
  const DetalleComercio({
    super.key,
    required this.razonSocial,
  });

  final String razonSocial;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 330,
      height: 80,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "$razonSocial",
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            )
          ]),
    );
  }
}

class DetalleCompra extends StatelessWidget {
  const DetalleCompra({super.key, required this.fecha, required this.monto});

  final String fecha;
  final String monto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 100,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Fecha de emisión: $fecha\n",
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF000000),
                  fontFamily: "Roboto"),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "MONTO TOTAL: $monto",
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                    fontFamily: "Roboto"),
              ),
            ),
          ]),
    );
  }
}

class PDF417Barcode extends StatelessWidget {
  const PDF417Barcode({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BarcodeWidget(
          barcode: Barcode.pdf417(),
          data: data,
          width: 330,
          height: 120,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Timbre Electrónico SII",
            style: const TextStyle(
                fontSize: 16.0, color: Color(0xFF000000), fontFamily: "Roboto"),
          ),
        ),
      ],
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({super.key, required this.controller});
  final ScreenshotController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: IconButton(
        onPressed: () async {
          //Share.share('TEST');
          final image = await controller.capture();
          if (image == null) return;
          //await saveImage(image);
          await saveAndShare(image);
        },
        icon: Icon(Icons.share),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: IconButton(
        onPressed: () {
          //Get.toNamed('TicketRegister');
          //Get.to(() => HomePage.routerName);
          //Get.back(result: "result");
          Navigator.pushNamed(context, HomePage.routerName);
        },
        icon: Icon(Icons.arrow_back),
      ),
    );
  }
}

Future<String> saveImage(Uint8List bytes) async {
  //await [Permissions.storage].request();
  final time = DateTime.now()
      .toIso8601String()
      .replaceAll('.', '-')
      .replaceAll(':', '-');
  final name = 'boleta_$time';
  final result = await ImageGallerySaver.saveImage(bytes, name: name);
  return result['filePath'];
}

Future<String> saveAndShare(Uint8List bytes) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    await image.writeAsBytes(bytes);
    await Share.shareXFiles([XFile(image.path)]);
    return 'ok';
  } catch (e) {
    print(e);
    rethrow;
  }
}
