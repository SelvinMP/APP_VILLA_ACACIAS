import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:villa_las_acacias/Pages/Validar_codigo.dart'; // Importar la nueva pantalla
import 'package:villa_las_acacias/Service/AuthService.dart';

class Registrasepage extends StatefulWidget {
  const Registrasepage({super.key});

  @override
  _RegistrasepageState createState() => _RegistrasepageState();
}

class _RegistrasepageState extends State<Registrasepage> {
  final AuthService _authService = AuthService();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmapasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _errorMessage;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  bool _validatePassword(String password) {
    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])(?!.*\s).{8,}$');
    return passwordRegex.hasMatch(password);
  }

  void _submitForm() {
    setState(() {
      _errorMessage = _validatePassword(_passwordController.text)
          ? null
          : 'La contraseña debe tener al menos 8 caracteres, una letra mayúscula, una letra minúscula, un número y un carácter especial.';
    });

    if (_errorMessage == null) {
      _registrar();
    }
  }

  void _registrar() async {
    final username = _nombreController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    String password1 = _passwordController.text;
    String confirmPassword = _confirmapasswordController.text;

    if (password1 == confirmPassword) {
      try {
        final response = await _authService.register(
          username,
          email,
          password,
        );

        if (!response.containsKey('error')) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerificationScreen(
                    email: email)), // Redirigir a la pantalla de verificación
          );
        } else {
          setState(() {
            _errorMessage =
                response['error'] ?? 'Error al registrar el usuario';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_errorMessage!)),
          );
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Error al intentar registrar el usuario';
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
        backgroundColor: const Color(0xff14A13B),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Villa Las \nAcacias",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Cuerpo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Cuerpo() {
    return Container(
      height: 450.0,
      width: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10.0),
            Crea_Cuenta(),
            const SizedBox(
              height: 9.0,
            ),
            Nombre(),
            const SizedBox(
              height: 10.0,
            ),
            Telef_Gemail(),
            const SizedBox(
              height: 10.0,
            ),
            Contrasena(),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(
              height: 10.0,
            ),
            Confirmar_Contrasena(),
            const SizedBox(
              height: 15.0,
            ),
            Registrarse(),
          ],
        ),
      ),
    );
  }

  Widget Crea_Cuenta() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        "Crea tu cuenta",
        style: TextStyle(
          color: Color(0xff14A13B),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Nombre() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: TextField(
        controller: _nombreController,
        decoration: const InputDecoration(
          hintText: "Nombre de usuario",
          fillColor: Colors.white,
          filled: true,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(70),
          FilteringTextInputFormatter.allow(RegExp(r'[A-Z _]')),
        ],
      ),
    );
  }

  Widget Telef_Gemail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: TextField(
        controller: _emailController,
        decoration: const InputDecoration(
          hintText: "Correo electrónico",
          fillColor: Colors.white,
          filled: true,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(70),
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]')),
        ],
      ),
    );
  }

  Widget Contrasena() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: TextField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          hintText: "Contraseña",
          fillColor: Colors.white,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
      ),
    );
  }

  Widget Confirmar_Contrasena() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: TextField(
        controller: _confirmapasswordController,
        obscureText: _obscureConfirmPassword,
        decoration: InputDecoration(
          hintText: "Confirmar contraseña",
          fillColor: Colors.white,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: _toggleConfirmPasswordVisibility,
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
      ),
    );
  }

  Widget Registrarse() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff14A13B),
      ),
      onPressed: _submitForm,
      child: const Text(
        'REGISTRARSE',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
