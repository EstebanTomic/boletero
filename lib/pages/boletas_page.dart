import 'package:boletero/models/scan_model.dart';
import 'package:flutter/material.dart';

class BoletasPage extends StatelessWidget {
  const BoletasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    String rut = scan.rut;
    String folio = scan.folio;
    String razonSocial = scan.empresa;
    String fecha = scan.fecha;
    String monto = scan.monto;

    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Cabecera
        CabeceraBoleta(rut: rut, folio: folio),
        DetalleComercio(razonSocial: razonSocial),
        DetalleCompra(fecha: fecha, monto: monto)
        // Detalle Comercio
        
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
      width: 300,
      height: 90,
      decoration: BoxDecoration(
        border: Border.all(width: 2.5),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "R.U.T.: $rut",
              style: const TextStyle(
                  fontSize: 24.0,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            ),
            Text(
              "BOLETA ELECTRÓNICA",
              style: const TextStyle(
                  fontSize: 24.0,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            ),
            Text(
              "N°: $folio",
              style: const TextStyle(
                  fontSize: 24.0,
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
      height: 90,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "S.I.I",
              style: const TextStyle(
                  fontSize: 24.0,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            ),
            Text(
              "$razonSocial",
              style: const TextStyle(
                  fontSize: 24.0,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            )
          ]),
    );
  }
}

class DetalleCompra extends StatelessWidget {
  const DetalleCompra({
    super.key,
    required this.fecha,
    required this.monto
    });

    final String fecha;
    final String monto;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 90,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            Text(
              "MONTO TOTAL: $monto",
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                  fontFamily: "Roboto"),
            ),
          ]),
    );
  }
}


