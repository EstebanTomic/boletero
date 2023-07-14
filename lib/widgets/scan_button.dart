import 'package:boletero/providers/scan_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:xml/xml.dart' as xml;
import 'package:intl/intl.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
      // LLamado a Camara
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#000000', 'Cancelar', false, ScanMode.BARCODE);

/*
        // Respuesta de prueba
        String barcodeScanRes = '''
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
      <RS>ADMINISTRADORA DE VENTAS AL DETALLE LIMI</RS>
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
        ''';
          */
      

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
          final rut = dd.findElements('RE').first.innerText.toString();
          final monto = dd.findElements('MNT').first.innerText.toString();
          final folio = dd.findElements('F').first.innerText.toString();
          final fecha = dd.findElements('FE').first.innerText.toString();

          //TODO: Generar Helpers para Formatos
          final montoFormatted = NumberFormat.currency(name: 'CLP', decimalDigits: 0, symbol: '\$').format(int.parse(monto));
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
          scanListProvider.newScan(barcodeScanRes, montoFormatted, rut, folio, fechaFormatted, empresa);
          debugPrint('rut: $rut');
          debugPrint('monto: $montoFormatted');
          debugPrint('folio: $folio');
          debugPrint('fecha: $fechaFormatted');
          debugPrint('empresa: $empresa');
        }
      },
    );
  }
}
