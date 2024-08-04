import 'package:flutter/material.dart';
import 'package:villa_las_acacias/Service/AuthService.dart';

class Cambiar1ContrasenaPage extends StatefulWidget {
  final String email;

  const Cambiar1ContrasenaPage({required this.email, Key? key}) : super(key: key);

  @override
  State<Cambiar1ContrasenaPage> createState() => _CambiarContrasenaPageState();
}

class _CambiarContrasenaPageState extends State<Cambiar1ContrasenaPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _cambiarContrasena() async {
    if (_newPasswordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor ingresa la nueva contraseña';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _authService.cambiarContrasena(widget.email, _newPasswordController.text);
      setState(() {
        _isLoading = false;
      });

      if (!response.containsKey('error')) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contraseña cambiada con éxito')));
        Navigator.pop(context);
      } else {
        setState(() {
          _errorMessage = response['error'] ?? 'Error al cambiar la contraseña';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error al intentar cambiar la contraseña';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'Nueva contraseña',
                errorText: _errorMessage,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _cambiarContrasena,
                    child: const Text('Cambiar Contraseña'),
                  ),
          ],
        ),
      ),
    );
  }
}
