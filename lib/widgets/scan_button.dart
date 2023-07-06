import 'package:boletero_qr_reader/providers/scan_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:xml/xml.dart' as xml;

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {

      // LLamado a Camara
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.BARCODE);
      
      // Respuesta de prueba
    /*  String barcodeScanRes = '''
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

       
         // Agregamos comillas a version para poder parsear como XML
        String result = barcodeScanRes.replaceAll("version= 1.0", "version= \"1.0\"");
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

        // Guardamos en la BD
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.newScan(barcodeScanRes, monto, rut, folio, fecha);
        debugPrint('rut: $rut');
        debugPrint('monto: $monto');
        debugPrint('folio: $folio');
        debugPrint('fecha: $fecha');

      },
    );
  }
}
