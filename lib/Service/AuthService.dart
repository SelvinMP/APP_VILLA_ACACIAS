import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String apiUrl = 'http://192.168.43.126:3000/';

  Future<Map<String, dynamic>> login(String username, String password) async {
  print('Iniciando sesión con usuario: $username');
  try {
    final response = await http.post(
      Uri.parse('${apiUrl}login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    print('Respuesta del servidor: ${response.statusCode}');
    print('Cuerpo de la respuesta: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return data;
    }

    if (response.statusCode == 402) {
      final data = jsonDecode(response.body);
      List<dynamic> adminEmailsList = data['adminEmails'];
      String adminEmails = adminEmailsList.join('\n'); // Unir correos en líneas separadas
      
      return {
        'error': 'Comuníquese con los administradores para el uso de la aplicación',
        'adminEmails': adminEmails
      };
    }

    if (response.statusCode == 403) {
      return {
        'error': 'Usuario ha sido bloqueado por múltiples intentos fallidos'
      };
    } else {
      return {
        'error': jsonDecode(response.body)['message'] ?? 'Login failed'
      };
    }
  } catch (e) {
    return {'error': 'Usuario o contraseña incorrecta'};
  }
}
  

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, dynamic>> getProtectedData() async {
    String? token = await getToken();
    print('Token recuperado: $token');

    if (token == null) {
      return {'error': 'No token found'};
    }

    try {
      final response = await http.get(
        Uri.parse('${apiUrl}protected'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Respuesta del servidor (protected): ${response.statusCode}');
      print('Cuerpo de la respuesta (protected): ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'Failed to fetch protected data'};
      }
    } catch (e) {
      print('Error al intentar obtener datos protegidos: $e');
      return {'error': 'Error al intentar obtener datos protegidos'};
    }
  }

  Future<Map<String, dynamic>> register(
      String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'NOMBRE_USUARIO': username,
          'EMAIL': email,
          'CONTRASEÑA': password
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {'message': data['message']};
      } else {
        return {
          'error': jsonDecode(response.body)['message'] ?? 'Registro fallido'
        };
      }
    } catch (e) {
      return {'error': 'Error al intentar registrar el usuario'};
    }
  }

  Future<Map<String, dynamic>> verifyEmail(String email, String code) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}verify'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'EMAIL': email, 'CODIGO_VERIFICACION': code}),
      );
      
    if (response.statusCode == 402) {
      final data = jsonDecode(response.body);
      List<dynamic> adminEmailsList = data['adminEmails'];
      String adminEmails = adminEmailsList.join('\n'); // Unir correos en líneas separadas
      
      return {
        'error': 'Comuníquese con los administradores para el uso de la aplicación',
        'adminEmails': adminEmails
      };
    }
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'message': data['message']};
      } else {
        return {
          'error':
              jsonDecode(response.body)['message'] ?? 'Verificación fallida'
        };
      }
      
    } catch (e) {
      return {'error': 'Error al intentar verificar el correo'};
    }
  }

  Future<Map<String, dynamic>> toggleTwoStepVerification(
      String userId, bool enable) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}activar_verificacion'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'isTwoStepVerificationEnabled': enable ? '1' : 'null',
        }),
      );

      if (response.statusCode == 200) {
        return {'message': 'Verificación de 2 pasos actualizada con éxito'};
      } else {
        return {'error': 'Error al actualizar la verificación de 2 pasos'};
      }
    } catch (e) {
      return {
        'error': 'Error al intentar actualizar la verificación de 2 pasos'
      };
    }
  }

//********** RESTABLECER CONTRASEÑA ***********
  Future<Map<String, dynamic>> restablecer(String email) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}restablecer_contrasena'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'message': data['message'], 'token': data['token']};
      } else {
        return {
          'error': jsonDecode(response.body)['message'] ?? 'intento fallido'
        };
      }
    } catch (e) {
      return {'error': 'Error al intentar verificar el usuario'};
    }
  }

// ********** VERIFICAR CONTRASEÑA TEMPORAL **********
  Future<Map<String, dynamic>> verificarContrasenaTemporal(
      String email, String tempPassword) async {
    String? token = await getToken(); // Obtener el token JWT guardado

    if (token == null) {
      return {'error': 'No se encontró el token'};
    }

    try {
      final response = await http.post(
        Uri.parse('${apiUrl}verificar_contrasena_temporal'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Incluir el token en el encabezado
        },
        body: jsonEncode({'email': email, 'tempPassword': tempPassword}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'message': data['message']};
      } else {
        return {
          'error':
              jsonDecode(response.body)['message'] ?? 'Verificación fallida'
        };
      }
    } catch (e) {
      return {'error': 'Error al intentar verificar la contraseña temporal'};
    }
  }

//******* CAMBIAR CONTRASEÑA *******
  Future<Map<String, dynamic>> cambiarContrasena(
      String actual, String nueva) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        return {'error': 'No se encontró el token de autenticación'};
      }

      final response = await http.post(
        Uri.parse('${apiUrl}cambiar_contrasena'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'actual': actual, 'nueva': nueva}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return {'message': 'Contraseña actualizada correctamente'};
      } else {
        return {
          'error': jsonDecode(response.body)['message'] ??
              'Error al actualizar la contraseña'
        };
      }
    } catch (e) {
      print('Error al intentar actualizar la contraseña: $e');
      return {'error': 'Error al intentar actualizar la contraseña: $e'};
    }
  }

  Future<void> logout() async {
    // Obtener el token almacenado
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      // Hacer una solicitud para cerrar sesión (opcional, si tienes una ruta en el backend)
      try {
        final response = await http.post(
          Uri.parse('${apiUrl}logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          // Eliminar el token almacenado
          await prefs.remove('token');
          print('Sesión cerrada exitosamente');
        } else {
          print('Error al cerrar sesión: ${response.body}');
        }
      } catch (e) {
        print('Error al cerrar sesión: $e');
      }
    } else {
      // No hay token almacenado
      print('No hay sesión activa');
    }
  }

  Future<Map<String, dynamic>> insertVisit(
      int userId, String visitorName, String dniVisitor, int numPersons, String numPlaca, String dateTime) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}registerVisit'), // Asegúrate de que esta URL sea correcta
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ID_PERSONA': userId,
          'NOMBRE_VISITANTE': visitorName,
          'DNI_VISITANTE': dniVisitor,
          'NUM_PERSONAS': numPersons,
          'NUM_PLACA': numPlaca,
          'FECHA_HORA': dateTime,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {'message': data['message'], 'qrCode': data['qrCode']};
      } else {
        return {
          'error': jsonDecode(response.body)['message'] ?? 'Registro de visita fallido'
        };
      }
    } catch (e) {
      return {'error': 'Error al intentar registrar la visita'};
    }
  }



}//Fin de la clase




/*import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  final String apiUrl = 'http://192.168.43.126:3000/';

  Future<Map<String, dynamic>> login(String username, String password) async {
    print('Iniciando sesión con usuario: $username');
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      print('Respuesta del servidor: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');

      

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];

        // Almacenar el token usando shared_preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

      return data;}
      
      if(response.statusCode == 403){
        return {'error': 'Usuario ha sido bloqueado por múltiples intentos fallidos'};
      
      } else {
        return {'error': jsonDecode(response.body)['message'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'error': 'Usuario o contraseña incorrecta'};
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, dynamic>> getProtectedData() async {
    String? token = await getToken();
    print('Token recuperado: $token');

    if (token == null) {
      return {'error': 'No token found'};
    }

    try {
      final response = await http.get(
        Uri.parse('${apiUrl}protected'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Respuesta del servidor (protected): ${response.statusCode}');
      print('Cuerpo de la respuesta (protected): ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'Failed to fetch protected data'};
      }
    } catch (e) {
      print('Error al intentar obtener datos protegidos: $e');
      return {'error': 'Error al intentar obtener datos protegidos'};
    }
  }

  //****** Registro */
    Future<Map<String, dynamic>> register(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'NOMBRE_USUARIO': username, 'EMAIL': email, 'CONTRASEÑA': password}),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {'message': data['message']};
      } else {
        return {'error': jsonDecode(response.body)['message'] ?? 'Registro fallido'};
      }
    } catch (e) {
      return {'error': 'Error al intentar registrar el usuario'};
    }
  }

  Future<Map<String, dynamic>> verifyEmail(String email, String code) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}verify'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'EMAIL': email, 'CODIGO_VERIFICACION': code}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'message': data['message']};
      } else {
        return {'error': jsonDecode(response.body)['message'] ?? 'Verificación fallida'};
      }
    } catch (e) {
      return {'error': 'Error al intentar verificar el correo'};
    }
  }

Future<Map<String, dynamic>> toggleTwoStepVerification(String userId, bool enable) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}activar_verificacion'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'isTwoStepVerificationEnabled': enable ? '1' : 'null',
        }),
      );

      if (response.statusCode == 200) {
        return {'message': 'Verificación de 2 pasos actualizada con éxito'};
      } else {
        return {'error': 'Error al actualizar la verificación de 2 pasos'};
      }
    } catch (e) {
      return {'error': 'Error al intentar actualizar la verificación de 2 pasos'};
    }
  }

  //RESTABLECER CONTRASEÑA 
    Future<Map<String, dynamic>> restablecer(String email) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}restablecer_contrasena'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email,}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'message': data['message']};
      } else {
        return {'error': jsonDecode(response.body)['message'] ?? 'intento fallido'};
      }
    } catch (e) {
      return {'error': 'Error al intentar verificar el usuario'};
    }
  }

  Future<Map<String, dynamic>> verificarContrasenaTemporal(String email, String code) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}verificar_contrasena_temporal'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'tempPassword': code}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'message': data['message']};
      } else {
        return {'error': jsonDecode(response.body)['message'] ?? 'Verificación fallida'};
      }
    } catch (e) {
      return {'error': 'Error al intentar verificar el correo'};
    }
  }

  // Función para cambiar la contraseña
Future<Map<String, dynamic>> cambiarContrasena(String actual, String nueva) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return {'error': 'No se encontró el token de autenticación'};
    }

    final response = await http.post(
      Uri.parse('${apiUrl}/cambiar_contrasena'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({'actual': actual, 'nueva': nueva}),
    );

    // Imprimir la respuesta para depuración
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return {'message': 'Contraseña actualizada correctamente'};
    } else {
      return {'error': jsonDecode(response.body)['message'] ?? 'Error al actualizar la contraseña'};
    }
  } catch (e) {
    print('Error al intentar actualizar la contraseña: $e');
    return {'error': 'Error al intentar actualizar la contraseña: $e'};
  }
}


  







/*
Future<Map<String, dynamic>> restablecer(String email) async {
  try {
    final response = await http.post(
      Uri.parse('$apiUrl/restablecer_contrasena'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // Manejo de errores de respuesta no exitosa
      return {'error': 'Error en la solicitud: ${response.statusCode}'};
    }
  } catch (e) {
    // Manejo de errores de red y otros
    return {'error': 'Error al realizar la solicitud: $e'};
  }
}


  Future<Map<String, dynamic>> verificarContrasenaTemporal(String email, String tempPassword) async {
    final response = await http.post(
      Uri.parse('$apiUrl/verificar_contrasena_temporal'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'tempPassword': tempPassword}),
    );

    return jsonDecode(response.body);
  }
*/

}
*/