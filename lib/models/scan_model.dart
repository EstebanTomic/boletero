import 'dart:convert';

import 'package:meta/meta.dart';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    int? id;
    String? tipo;
    String valor;
    String monto;
    String rut;
    String folio;
    String fecha;

    ScanModel({
        this.id,
        this.tipo,
        required this.valor,
        required this.monto,
        required this.rut,
        required this.folio,
        required this.fecha,
    }) {

      if(this.valor.contains('http')) {
        this.tipo = 'http';
      } else {
        this.tipo = 'geo';
      }
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id:    json["id"],
        tipo:  json["tipo"],
        valor: json["valor"],
        monto: json["monto"],
        rut:   json["rut"],
        folio: json["folio"],
        fecha: json["fecha"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
        "monto": monto,
        "rut": rut,
        "folio": folio,
        "fecha": fecha
    };
}
