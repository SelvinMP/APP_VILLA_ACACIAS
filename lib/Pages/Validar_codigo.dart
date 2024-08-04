import 'package:flutter/material.dart';
import 'package:villa_las_acacias/Pages/Pantalla_principal.dart';
import 'package:villa_las_acacias/Service/AuthService.dart';

class VerificationScreen extends StatefulWidget {
  final String email;

  VerificationScreen({required this.email});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
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
      final response = await _authService.verifyEmail(widget.email, _codeController.text);
      setState(() {
        _isLoading = false;
      });

      if (!response.containsKey('error')) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Correo verificado con éxito')));
        //Navigator.popUntil(context, ModalRoute.withName('/Pantalla_Principal')); // Vuelve a la pantalla principal
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Principalpage(token: null)), // Redirigir a la pantalla de verificación
          );
      } else {
        setState(() {
          _errorMessage = response['error'] ?? 'Error al verificar el código' ;
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
        title: const Text('Verificación de correo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Se ha enviado un código de verificación a ${widget.email}. Por favor ingresa el código a continuación.'),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Código de verificación',
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
