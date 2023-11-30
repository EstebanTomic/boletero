import 'dart:io';

import 'package:boletero/models/tickets_model.dart';
import 'package:boletero/providers/ticket_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/form_container_widget.dart';

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
  TextEditingController _folioController = TextEditingController();
  File? _scannedImage;
  final ImagePicker _picker = ImagePicker();
  String? _retrieveDataError;
  List<XFile>? _mediaFileList;
  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;

  @override
  void dispose() {
    _montoController.dispose();
    _fechaController.dispose();
    _rutController.dispose();
    _folioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Color.fromARGB(205, 0, 115, 198),
          child: Center(
            child: Wrap(
              children: <Widget>[
                Padding(
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
                          controller: _rutController,
                          hintText: "RUT Emisor",
                          isPasswordField: false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FormContainerWidget(
                          controller: _folioController,
                          hintText: "Folio del DTE",
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
                          controller: _montoController,
                          hintText: "Monto Boleta",
                          isPasswordField: false,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: _registerManualPhotoTicket,
                          child: Container(
                            width: 70,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(205, 0, 115, 198),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: const Icon(Icons.photo_camera,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FutureBuilder<void>(
                          future: retrieveLostData(),
                          builder: (BuildContext context,
                              AsyncSnapshot<void> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return const Text(
                                    'Aún no has fotografiado tu boleta',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(205, 0, 115, 198)));
                              case ConnectionState.done:
                                return _previewImages();
                              case ConnectionState.active:
                                if (snapshot.hasError) {
                                  return Text(
                                    'Pick image/video error: ${snapshot.error}}',
                                    textAlign: TextAlign.center,
                                  );
                                } else {
                                  return const Text(
                                      'Aún no has fotografiado tu boleta',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              205, 0, 115, 198)));
                                }
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_mediaFileList != null) {
      return Semantics(
          label: 'Boleta Seleccionada',
          child: Image.file(
            File(_mediaFileList![0].path),
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return const Center(
                  child: Text('This image type is not supported'));
            },
          ));
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text('Aún no has fotografiado tu boleta',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(205, 0, 115, 198)));
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          _mediaFileList = response.files;
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  void _registerManualPhotoTicket() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _setImageFileListFromFile(photo);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  void _registerManualTicket() async {
    String monto = _montoController.text;
    String fecha = _fechaController.text;
    String rut = _rutController.text;
    String folio = _folioController.text;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String fechaCreacion = formatter.format(now);
    // Obtenemos UUID de usuario logeado por firebase
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    try {
      final tm = TicketsModel(
          empresa: '',
          fecha: fecha,
          fechaCreacion: fechaCreacion,
          folio: folio,
          monto: monto,
          razonSocial: '',
          rut: rut,
          xml: '',
          idUsuario: uid);
      TicketRepository tr = Get.put(TicketRepository());
      tr.createTicket(tm);
      print("TODOO");
    } catch (e) {
      print("Some error happend ${e}");
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Warning!"),
            content: Text("${e}"),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}
