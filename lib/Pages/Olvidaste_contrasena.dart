import 'package:flutter/material.dart';
import 'package:villa_las_acacias/Pages/Nueva_cont_temporal.dart';
import 'package:villa_las_acacias/Service/AuthService.dart';

class Olvidastepage extends StatefulWidget {
  const Olvidastepage({super.key});

  @override
  State<Olvidastepage> createState() => _OlvidasteState();
}

class _OlvidasteState extends State<Olvidastepage> {
  String? _errorMessage;
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();

  void _restablecer(BuildContext context) async {
    final email = _emailController.text;
    try {
    final response = await _authService.restablecer(email);
        if (!response.containsKey('error')) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerificationNuevaScreen(email: email)), // Redirigir a la pantalla de verificación
          );
        } else {
          setState(() {
            _errorMessage = response['error'] ?? 'Error al registrar el usuario';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_errorMessage!)),
          );
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Error al intentar ingresar el usuario';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      } // Redirigir a la pantalla de verificación
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff14A13B),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.white,
          title: const Text(
            "Villa Las Acacias",
            style: TextStyle(
              color: Color(0xff14A13B),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: Cuerpo_Olvidar(),
      ),
    );
  }

  Widget Cuerpo_Olvidar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15.0),
            TextRestablecer(),
            const SizedBox(height: 9.0),
            TextContenido(),
            const SizedBox(height: 9.0),
            TextUsuario(),
            const SizedBox(height: 9.0),
            LabelUsuario(),
            const SizedBox(height: 9.0),
            Restablecer(),
          ],
        ),
      ),
    );
  }

  Widget TextRestablecer() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        "Restablecer contraseña",
        style: TextStyle(
          color: Color(0xff14A13B),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget TextContenido() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      alignment: Alignment.centerRight,
      child: const Text(
        "Completa con tu correo registrado para enviarte un código temporal y restablecer tu contraseña",
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget TextUsuario() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          "Correo:",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget LabelUsuario() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        controller: _emailController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: "Ingresa tu correo",
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  Widget Restablecer() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff14A13B),
      ),
      onPressed: () {
        _restablecer(context);
      },
      child: const Text(
        'RESTABLECER',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}