import 'package:boletero/models/tickets_model.dart';
import 'package:boletero/providers/ticket_provider.dart';
import 'package:boletero/providers/ui_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xml/xml.dart' as xml;
import 'package:boletero/providers/scan_list_provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../models/boleta_model.dart';
import '../pages/pages.dart';
import '../providers/boleta_provider.dart';

class CentralButton extends StatelessWidget {
  const CentralButton({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    var visible = true;
    var switchLabelPosition = false;
    var extend = false;
    var rmicons = false;
    var childrenButtonSize = const Size(56.0, 56.0);
    return SpeedDial(
      // animatedIcon: AnimatedIcons.menu_close,
      // animatedIconTheme: IconThemeData(size: 22.0),
      // / This is ignored if animatedIcon is non null
      // child: Text("open"),
      // activeChild: Text("close"),
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: 3,
      childPadding: const EdgeInsets.all(5),
      spaceBetweenChildren: 4,
      label:
          extend ? const Text("Open") : null, // The label of the main button.
      /// The active label of the main button, Defaults to label if not specified.
      activeLabel: extend ? const Text("Close") : null,

      /// Transition Builder between label and activeLabel, defaults to FadeTransition.
      // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
      /// The below button size defaults to 56 itself, its the SpeedDial childrens size
      childrenButtonSize: childrenButtonSize,
      visible: visible,
      direction: SpeedDialDirection.up,
      switchLabelPosition: switchLabelPosition,

      /// If false, backgroundOverlay will not be rendered.
      renderOverlay: true,
      // overlayColor: Colors.black,
      // overlayOpacity: 0.5,
      onOpen: () => debugPrint('OPENING DIAL'),
      onClose: () => debugPrint('DIAL CLOSED'),
      useRotationAnimation: true,
      tooltip: 'Registra una boleta',
      heroTag: 'speed-dial-hero-tag',
      // foregroundColor: Colors.black,
      // backgroundColor: Colors.white,
      // activeForegroundColor: Colors.red,
      // activeBackgroundColor: Colors.blue,
      elevation: 8.0,
      //animationCurve: Curves.elasticInOut,
      isOpenOnStart: false,
      shape: const StadiumBorder(),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.barcode_reader),
          label: 'Escanea Timbre SII',
          onTap: () => _triggerScan(context, false),
          onLongPress: () => debugPrint('Escaner LONG PRESS'),
        ),
        SpeedDialChild(
          child: const Icon(Icons.keyboard),
          //backgroundColor: Colors.deepOrange,
          //foregroundColor: Colors.white,
          label: 'Ingreso Manual',
          onTap: () {
            //ManualRegisterPage
            //Navigator.push(
            //  context,
            //  MaterialPageRoute(builder: (context) => ManualRegisterPage()),
            //);
            uiProvider.selectedMenuOpt = 2;
          },
        ),
        SpeedDialChild(
          child: !rmicons ? const Icon(Icons.document_scanner) : null,
          backgroundColor: Colors.red[200],
          foregroundColor: Colors.white,
          label: 'Ingresar MOCK',
          visible: true,
          onTap: () => _triggerScan(context, true),
          onLongPress: () => debugPrint('Ingresar MOCK'),
        ),
      ],
    );
  }

  Future<void> _triggerScan(BuildContext context, mock) async {
    String barcodeScanRes = mock
        ? '''
<TED version= 1.0>
  <DD>
    <RE>77215640-5</RE>
    <TD>39</TD>
    <F>435824786</F>
    <FE>2023-06-30</FE>
    <RR>66666666-6</RR>
    <RSR>Por defecto SII</RSR>
    <MNT>11600</MNT>
    <IT1>Red Bull tradicional 473 ml.</IT1>
    <CAF version='1.0'>
    <DA>
      <RE>77215640-5</RE>
      <RS>ADMINISTRADORA DE VENTAS AL DETALLE LIMITADA</RS>
      <TD>39</TD>
      <RNG>
        <D>433081956</D>
        <H>436081955</H>
      </RNG>
      <FA>2023-05-01</FA>
      <RSAPK>
        <M>3madj9V6tb9qSDYWy0Qj7ZRzBgCVc9MWYkwDptN+zW0nS8jtGZ9G2u+0jnJxII83BET888kDTSRZG21yV94Khw==</M>
        <E>Aw==</E>
      </RSAPK>
      <IDK>300</IDK>
    </DA>
    <FRMA algoritmo="SHA1withRSA">UEl+eMwg7baZxyy+JhfGmVZuTPorQnKSLinUo0poIRBnEgKyeJpQ9rcddzgiX3fC9IWVHStw/0TpPp7kx5N4GQ==</FRMA>
    </CAF>
    <TSTED>2023-06-30T07:06:54</TSTED>
  </DD>
  <FRMT algoritmo='SHA1withRSA'>22QKSD2MfSWGAa5XUmUilq/Rs1iKfVi6fMhMt/zstH5ge0os9MkHi979+sq0KHluhwCLNnNZgF+Dagy75G5MBQ==</FRMT>
</TED>
        '''
        : await FlutterBarcodeScanner.scanBarcode(
            '#000000', 'Cancelar', false, ScanMode.BARCODE);

    debugPrint('resultado: $barcodeScanRes');
    // Si es -1 no hacemos nada, es el boton cancelar
    if (barcodeScanRes != '-1') {
      // Agregamos comillas a version para poder parsear como XML
      String result =
          barcodeScanRes.replaceAll("version= 1.0", "version= \"1.0\"");
      //debugPrint('result: $result');
      final document = xml.XmlDocument.parse(result);
      debugPrint('resultadoParseado: $document');

      // Extraemos data desde parseo
      final ted = document.findElements('TED').first;
      final dd = ted.findElements('DD').first;
      final caf = dd.findElements('CAF').first;
      final da = caf.findElements('DA').first;
      final rut = dd.findElements('RE').first.innerText.toString();
      final monto = dd.findElements('MNT').first.innerText.toString();
      final folio = dd.findElements('F').first.innerText.toString();
      final fecha = dd.findElements('FE').first.innerText.toString();
      final razonSocial = da.findElements('RS').first.innerText.toString();

      //TODO: Generar Helpers para Formatos
      final montoFormatted =
          NumberFormat.currency(name: 'CLP', decimalDigits: 0, symbol: '\$')
              .format(int.parse(monto));
      // final montoFormatted = NumberFormat.simpleCurrency(name: 'es_US').format(int.parse(monto));

      final DateTime fechaDT = DateTime.parse(fecha);
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String fechaFormatted = formatter.format(fechaDT);
      String empresa = '';

      switch (rut) {
        case '92642000-3':
          empresa = 'Librería Nacional';
          break;
        case '76031071-9':
          empresa = 'Salcobrand';
          break;
        case '77215640-5':
          empresa = 'Copec';
          break;
        case '76833720-9':
          empresa = 'Acuenta';
          break;
        case '77482034-5':
          empresa = 'Muvap';
          break;
      }

      // Guardamos en la BD
      final scanListProvider =
          Provider.of<ScanListProvider>(context, listen: false);
      scanListProvider.newScan(barcodeScanRes, montoFormatted, rut, folio,
          fechaFormatted, empresa, razonSocial);
      debugPrint('rut: $rut');
      debugPrint('monto: $montoFormatted');
      debugPrint('folio: $folio');
      debugPrint('fecha: $fechaFormatted');
      debugPrint('empresa: $empresa');

      // Analytics
      final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
      await analytics.logEvent(
        name: "register_boleta",
        parameters: {
          "content_type": "boleta",
          "rut": rut,
          "monto": montoFormatted,
          "folio": folio,
          "fecha": fechaFormatted,
          "empresa": empresa,
        },
      );

      // Obtenemos UUID de usuario logeado por firebase
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user?.uid;

      // Guardamos en DB firebase
      if (!mock) {
        // Boleta Sin usuario en tabla "boletas"
        //final boletaRepo = Get.put(BoletaRepository());
        //final boleta = BoletaModel(xml: document.toString(), monto: monto, rut: rut, folio: folio, fecha: fecha, empresa: empresa, razonSocial: razonSocial);
        //await boletaRepo.createBoleta(boleta);
        final DateTime now = DateTime.now();
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final String fechaCreacion = formatter.format(now);
        final ticketRepo = Get.put(TicketRepository());
        final ticket = TicketsModel(
          xml: document.toString(),
          monto: monto,
          rut: rut,
          folio: folio,
          fecha: fecha,
          empresa: empresa,
          razonSocial: razonSocial,
          idUsuario: uid,
          fechaCreacion: fechaCreacion,
        );
        await ticketRepo.createTicket(ticket);
      }
    }
  }
}
