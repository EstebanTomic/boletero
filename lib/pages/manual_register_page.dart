import 'package:flutter/material.dart';

import '../widgets/form_container_widget.dart';
import 'pages.dart';

class ManualRegisterPage extends StatefulWidget {
  const ManualRegisterPage({super.key});
  static const String routerName = 'ManualRegister';

  @override
  State<ManualRegisterPage> createState() => _ManualRegisterPageState();
}

class _ManualRegisterPageState extends State<ManualRegisterPage> {
  TextEditingController _montoController = TextEditingController();
  TextEditingController _fechaController = TextEditingController();
  TextEditingController _rutController = TextEditingController();
  TextEditingController _razonSocialController = TextEditingController();

  @override
  void dispose() {
    _montoController.dispose();
    _fechaController.dispose();
    _rutController.dispose();
    _razonSocialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ingresa los datos de tu boleta",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromARGB(205, 0, 115, 198),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              FormContainerWidget(
                controller: _montoController,
                hintText: "Monto Boleta",
                isPasswordField: false,
              ),
              SizedBox(
                height: 20,
              ),
              FormContainerWidget(
                controller: _fechaController,
                hintText: "Fecha de venta",
                isPasswordField: false,
              ),
              SizedBox(
                height: 20,
              ),
              FormContainerWidget(
                controller: _rutController,
                hintText: "RUT del comercio",
                isPasswordField: false,
              ),
              SizedBox(
                height: 20,
              ),
              FormContainerWidget(
                controller: _razonSocialController,
                hintText: "Razon Social",
                isPasswordField: false,
              ),
              SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: _registerManualTicket,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(205, 0, 115, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    "Registrar",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          )),
    );
  }
}

class HeaderManualRegister extends StatelessWidget {
  const HeaderManualRegister({super.key});

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
              "R.U.T.:",
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
              "N°: ",
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

void _registerManualTicket() async {
  //String monto = _montoController.text;
  //String fecha = _fechaController.text;
  //String rut = _rutController.text;

  try {
    print("TODOO");
  } catch (e) {
    print("Some error happend ${e}");
  }
}

class BackManualButton extends StatelessWidget {
  const BackManualButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, HomePage.routerName);
        },
        icon: Icon(Icons.arrow_back),
      ),
    );
  }
}
