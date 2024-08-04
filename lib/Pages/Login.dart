import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:villa_las_acacias/Pages/Pantalla_principal.dart';
import 'package:villa_las_acacias/Service/AuthService.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

//clase para que  no se pueda pegar en el campo de la contraseña
class NoPasteFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Si la diferencia entre oldValue y newValue implica una acción de pegar, ignorar la actualización
    if (newValue.text.length > oldValue.text.length + 1) {
      return oldValue;
    }
    return newValue;
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  bool _obscureText = true;
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();

  //control de la visibilidad de las contraseñas
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //Validar contraseña
  bool _validatePassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])(?!.*\s).{8,}$');
    return passwordRegex.hasMatch(password);
  }



  //Lo del login para iniciar sesión
    void _login(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final response = await _authService.login(username, password);

      if (response.containsKey('token')) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Principalpage(token: response['token']),
          ),
        );
      } else {
        setState(() {
          _errorMessage = response['error'] ?? 'Usuario o contraseña incorrecta';
        });
        _showErrorDialog(_errorMessage!);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al intentar iniciar sesión';
      });
      print('Excepción durante el inicio de sesión: $e');
      _showErrorDialog(_errorMessage!);
    }
  }
//Mensaje de la contraseña no coenciden
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff14A13B),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                cuerpo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cuerpo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 450.0,
      width: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40.0),
            usuario(),
            const SizedBox(height: 9.0),
            campoUsuario(),
            const SizedBox(height: 9.0),
            contrasena(),
            const SizedBox(height: 9.0),
            campoContrasena(),
            const SizedBox(height: 15.0),
            olvidarContrasena(),
            const SizedBox(height: 9.0),
            iniciarSesion(),
            const SizedBox(height: 7.0),
            registrarse(),
          ],
        ),
      ),
    );
  }

  Widget usuario() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          "Usuario:",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget contrasena() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          "Contraseña:",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget campoUsuario() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        controller: _usernameController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.mail),
          hintText: "Ingresa tu correo",
          fillColor: Color(0xffD9D9D9),
          filled: true,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(70),
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]')),
        ],
      ),
    );
  }

  Widget campoContrasena() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          hintText: "Ingresa tu contraseña",
          fillColor: const Color(0xffD9D9D9),
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: _toggleObscureText,
          ),
        ),
        inputFormatters: [
          NoPasteFormatter(),
        ],
      ),
    );
  }

  Widget olvidarContrasena() {
    return GestureDetector(
      onTap: () => Get.toNamed('/Olvidaste_page'),
      child: const Text(
        "¿Olvidaste tu contraseña?",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget iniciarSesion() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff14A13B),
      ),
      onPressed: () {
        _login(context);
      },
      child: const Text(
        'INICIAR SESIÓN',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget registrarse() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff14A13B),
      ),
      onPressed: () => Get.toNamed('/Registrarse'),
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