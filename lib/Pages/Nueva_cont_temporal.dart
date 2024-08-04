import 'package:flutter/material.dart';
import 'package:villa_las_acacias/Pages/Cambiar_contrasena.dart';
import 'package:villa_las_acacias/Service/AuthService.dart';

class VerificationNuevaScreen extends StatefulWidget {
  final String email;

  const VerificationNuevaScreen({required this.email, super.key});

  @override
  State<VerificationNuevaScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationNuevaScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _codeController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _verify() async {
    if (_codeController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor ingresa el código de verificación';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _authService.verificarContrasenaTemporal(widget.email, _codeController.text);
      setState(() {
        _isLoading = false;
      });

      if (!response.containsKey('error')) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Código verificado con éxito')));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CambiarContrasenaPage(email: widget.email,token: response['token'])),
        );
      } else {
        setState(() {
          _errorMessage = response['error'] ?? 'Error al verificar el código';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error al intentar verificar el código';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restablecer contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Se ha enviado una contraseña temporal a ${widget.email}. Por favor ingresa la contraseña a continuación.'),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Contraseña temporal',
                errorText: _errorMessage,
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _verify,
                    child: const Text('Verificar'),
                  ),
          ],
        ),
      ),
    );
  }
}
