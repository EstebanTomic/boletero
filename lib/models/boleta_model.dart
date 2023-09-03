class BoletaModel {
  String? id;
  String xml;
  String monto;
  String rut;
  String folio;
  String fecha;
  String empresa;
  String razonSocial;

  BoletaModel({
    this.id,
    required this.xml,
    required this.monto,
    required this.rut,
    required this.folio,
    required this.fecha,
    required this.empresa,
    required this.razonSocial,
  }) { }


  toJson() {
    return {
        "valor": xml,
        "monto": monto,
        "rut": rut,
        "folio": folio,
        "fecha": fecha,
        "empresa": empresa,
        "razonSocial": razonSocial,
      };   
  }
}
