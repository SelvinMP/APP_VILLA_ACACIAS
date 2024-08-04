import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:villa_las_acacias/Service/AuthService.dart';

class CambiarContrasenaPage extends StatefulWidget {
  const CambiarContrasenaPage({super.key, email,required token});

  @override
  State<CambiarContrasenaPage> createState() => _CambiarContraState();
}

class _CambiarContraState extends State<CambiarContrasenaPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _actualController = TextEditingController();
  final TextEditingController _nuevaController = TextEditingController();
  final TextEditingController _confirmapasswordController = TextEditingController();
  bool _obscureActual = true;
  bool _obscureNueva = true;
  bool _obscureConfirmar = true;
  String? _errorMessage;

  void _toggleActualVisibility() {
    setState(() {
      _obscureActual = !_obscureActual;
    });
  }

  void _toggleNuevaVisibility() {
    setState(() {
      _obscureNueva = !_obscureNueva;
    });
  }

  void _toggleConfirmarVisibility() {
    setState(() {
      _obscureConfirmar = !_obscureConfirmar;
    });
  }

  bool _validatePassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])(?!.*\s).{8,}$');
    return passwordRegex.hasMatch(password);
  }

  void _submitForm() {
    setState(() {
      _errorMessage = _validatePassword(_nuevaController.text)
          ? null
          : 'La contraseña debe tener al menos 8 caracteres, una letra mayúscula, una letra minúscula, un número y un carácter especial.';
    });

    if (_errorMessage == null) {
      _cambiarContrasena1();
    }
  }

  void _cambiarContrasena1() async {
    final actual = _actualController.text;
    final nueva = _nuevaController.text;
    final confirmar = _confirmapasswordController.text;

    if (nueva == confirmar) {
      try {
        final response = await _authService.cambiarContrasena(actual, nueva);
        if (!response.containsKey('error')) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text("Contraseña actualizada correctamente"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          setState(() {
            _errorMessage = response['error'];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_errorMessage!)),
          );
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Error al intentar actualizar la contraseña, inténtelo de nuevo';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Las contraseñas no coinciden"),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
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
            "Cambiar contraseña",
            style: TextStyle(
              color: Color(0xff14A13B),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Color(0xff14A13B),
                size: 40.0,
              ),
              onPressed: () => Get.toNamed('/Ajustes'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: _CuerpoCambiarContrasena(),
        ),
      ),
    );
  }

  Widget _CuerpoCambiarContrasena() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [Colors.grey, Colors.green],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15.0),
                _TextContenido(),
                const SizedBox(height: 9.0),
                _TextActual(),
                const SizedBox(height: 7.0),
                _LabelActual(),
                const SizedBox(height: 7.0),
                _TextNueva(),
                const SizedBox(height: 7.0),
                _LabelNueva(),
                const SizedBox(height: 7.0),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                _TextConfirmar(),
                const SizedBox(height: 7.0),
                _LabelConfirmar(),
                const SizedBox(height: 30.0),
                _Enviar(),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _TextContenido() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: Alignment.centerRight,
      child: const Text(
        "La nueva contraseña debe tener entre 8 y 12 caracteres, y debe contener al menos 1 número y al menos 2 letras, incluido 1 carácter en mayúscula",
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _TextActual() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          "Contraseña actual:",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _LabelActual() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        obscureText: _obscureActual,
        controller: _actualController,
        decoration: InputDecoration(
          hintText: "Introducir la contraseña actual",
          fillColor: Colors.white,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureActual ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: _toggleActualVisibility,
          ),
        ),
      ),
    );
  }

  Widget _TextNueva() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          "Contraseña nueva:",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _LabelNueva() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        obscureText: _obscureNueva,
        controller: _nuevaController,
        decoration: InputDecoration(
          hintText: "Introducir la contraseña nueva",
          fillColor: Colors.white,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureNueva ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: _toggleNuevaVisibility,
          ),
        ),
      ),
    );
  }

  Widget _TextConfirmar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          "Confirmar contraseña:",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _LabelConfirmar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        obscureText: _obscureConfirmar,
        controller: _confirmapasswordController,
        decoration: InputDecoration(
          hintText: "Confirmar contraseña nueva",
          fillColor: Colors.white,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureConfirmar ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: _toggleConfirmarVisibility,
          ),
        ),
      ),
    );
  }

  Widget _Enviar() {
    return Container(
      height: 50,
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff14A13B),
      ),
      child: TextButton(
        onPressed: _submitForm,
        child: const Text(
          "CAMBIAR CONTRASEÑA",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
