class TicketModel {
  String? id;
  String xml;
  String monto;
  String rut;
  String folio;
  String fecha;
  String empresa;
  String razonSocial;
  String? idUsuario;

  TicketModel({
    this.id,
    required this.xml,
    required this.monto,
    required this.rut,
    required this.folio,
    required this.fecha,
    required this.empresa,
    required this.razonSocial,
    this.idUsuario,
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
        "idUsuario": idUsuario,
      };   
  }
}
