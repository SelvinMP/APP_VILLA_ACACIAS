import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:villa_las_acacias/Service/AuthService.dart';
//import 'auth_service.dart'; // Asegúrate de importar tu AuthService

class GenerarQRpage extends StatefulWidget {
  const GenerarQRpage({super.key});

  @override
  State<GenerarQRpage> createState() => _GenerarQRState();
}

class _GenerarQRState extends State<GenerarQRpage> {
  DateTime? _selectedDateTime;
  TextEditingController _dateTimeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dniController = TextEditingController();
  TextEditingController _numPersonsController = TextEditingController();
  TextEditingController _numPlacaController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _dateTimeController.dispose();
    _nameController.dispose();
    _dniController.dispose();
    _numPersonsController.dispose();
    _numPlacaController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _dateTimeController.text = DateFormat('yyyy-MM-dd HH:mm').format(_selectedDateTime!);
        });
      }
    }
  }

  Future<void> _generateQRCode() async {
    final int userId = 1; // Cambia esto para obtener el ID del usuario real
    final String visitorName = _nameController.text;
    final String dniVisitor = _dniController.text;
    final int numPersons = int.parse(_numPersonsController.text);
    final String numPlaca = _numPlacaController.text;
    final String dateTime = _dateTimeController.text;

    final response = await _authService.insertVisit(userId, visitorName, dniVisitor, numPersons, numPlaca, dateTime);

    if (response.containsKey('error')) {
      // Manejar el error
      Get.snackbar('Error', response['error'], backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      // Manejar la respuesta exitosa
      Get.snackbar('Success', response['message'], backgroundColor: Colors.green, colorText: Colors.white);
      // Aquí puedes manejar el código QR devuelto, si es necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffD9D9D9),
          title: const Text(
            "Generar QR",
            style: TextStyle(
              color: Color(0xff14A13B),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Boton de x para volver atrás
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Color(0xff14A13B),
                size: 40.0,
              ),
              onPressed: () => Get.toNamed('/Pantalla_Principal'),
            ),
          ],
        ),
        body: CuerpoNotificaciones(),
      ),
    );
  }

  // El cuerpo de notificaciones para todos los métodos
  Widget CuerpoNotificaciones() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          textNuevo_Visitante(),
          const SizedBox(
            height: 15.0,
          ),
          textNombre(),
          boxNombre(),
          const SizedBox(
            height: 10,
          ),
          textDNI(),
          boxDNI(),
          const SizedBox(
            height: 10,
          ),
          TextNumeroPersonas(),
          boxNumeroPersonas(),
          const SizedBox(
            height: 10,
          ),
          TextFecha_hora(),
          boxFecha_hora(),
          const SizedBox(
            height: 10,
          ),
          textNumeroPlaca(),
          boxNumeroPlaca(),
          const SizedBox(
            height: 20,
          ),
          GENERAR(),
          const SizedBox(
            height: 10,
          ),
          CANCELAR(),
        ],
      ),
    );
  }

  // Contenedor verde con letras blancas como encabezado que dice Nuevo Visitante
  Widget textNuevo_Visitante() {
    return Container(
      height: 40,
      width: 210,
      color: const Color(0xff14A13B),
      child: const Align(
        // para alinear el texto dentro de contenedor
        alignment: Alignment.center,
        child: Text(
          "Nuevo Visitante",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Los textos y cajas de texto para llenar la información
  Widget textNombre() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: const Align(
        alignment: Alignment.bottomLeft, // para alinear el texto a la izquierda
        child: Text(
          "Nombre:",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget boxNombre() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        controller: _nameController,
        enableInteractiveSelection: false,
        autofocus: true,
        textCapitalization: TextCapitalization.characters,
        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget textDNI() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: const Align(
        alignment: Alignment.bottomLeft, // para alinear el texto a la izquierda
        child: Text(
          "DNI Visitante:",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget boxDNI() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        controller: _dniController,
        enableInteractiveSelection: false,
        autofocus: true,
        textCapitalization: TextCapitalization.characters,
        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget TextNumeroPersonas() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: const Align(
        alignment: Alignment.bottomLeft, // para alinear el texto a la izquierda
        child: Text(
          "Número de Personas:",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget boxNumeroPersonas() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        controller: _numPersonsController,
        enableInteractiveSelection: false,
        autofocus: true,
        textCapitalization: TextCapitalization.characters,
        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget TextFecha_hora() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: const Align(
        alignment: Alignment.bottomLeft, // para alinear el texto a la izquierda
        child: Text(
          "Fecha y hora:",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget boxFecha_hora() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        controller: _dateTimeController,
        enableInteractiveSelection: false,
        readOnly: true,
        onTap: () => _selectDateTime(context),
        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget textNumeroPlaca() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: const Align(
        alignment: Alignment.bottomLeft, // para alinear el texto a la izquierda
        child: Text(
          "Número de Placa:",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget boxNumeroPlaca() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        controller: _numPlacaController,
        enableInteractiveSelection: false,
        autofocus: true,
        textCapitalization: TextCapitalization.characters,
        decoration: const InputDecoration(
          fillColor: Colors.white,
          hintText: "(Opcional)",
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  // Botones de CANCELAR y GENERAR
  Widget CANCELAR() {
    return Container(
      height: 40,
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff908F8F),
        ),
        onPressed: () => Get.toNamed('/Pantalla_Principal'),
        child: const Text(
          'CANCELAR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget GENERAR() {
    return Container(
      height: 40,
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff14A13B),
        ),
        onPressed: _generateQRCode,
        child: const Text(
          'GENERAR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
} // Fin de la clase principal
