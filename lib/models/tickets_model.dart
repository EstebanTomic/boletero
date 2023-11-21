class TicketsModel {
  String? id;
  String xml;
  String monto;
  String rut;
  String folio;
  String fecha;
  String empresa;
  String razonSocial;
  String? idUsuario;
  String fechaCreacion;

  TicketsModel({
    this.id,
    required this.xml,
    required this.monto,
    required this.rut,
    required this.folio,
    required this.fecha,
    required this.empresa,
    required this.razonSocial,
    this.idUsuario,
    required this.fechaCreacion,
  });

  toJson() {
    return {
      "valor": xml,
      "monto": monto,
      "rut": rut,
      "folio": folio,
      "fecha": fecha,
      "empresa": empresa,
      "razonSocial": razonSocial,
      "idUsuario": idUsuario,
      "fechaCreacion": fechaCreacion
    };
  }
}
