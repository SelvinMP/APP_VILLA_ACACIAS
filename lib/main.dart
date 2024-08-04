import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Pages/Ajustes.dart';
import 'Pages/Generar_QR.dart';
import 'Pages/Login.dart';
import 'Pages/Notificaciones.dart';
import 'Pages/Nuevo_Visitante.dart';
import 'Pages/Olvidaste_contrasena.dart';
import 'Pages/Pantalla_principal.dart';
import 'Pages/Parentesco.dart';
import 'Pages/Registrarse.dart';
import 'Pages/Reservaciones.dart';

//import 'Services/AuthService.dart';

void main() {
  runApp(const VillaLasAcacias());
}

class VillaLasAcacias extends StatelessWidget {
  const VillaLasAcacias({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const LoginPage()),
        GetPage(name: '/Registrarse', page: () =>  Registrasepage()),
        GetPage(name: '/Olvidaste_page', page: () => const Olvidastepage()),
        GetPage(name: '/Pantalla_Principal', page: () => const Principalpage(token: null)),
        GetPage(name: '/Notificaciones', page: () => const Notificacionespage()),
        GetPage(name: '/GenerarQR', page: () => const GenerarQRpage()),
        GetPage(name: '/Reservaciones', page: () => const Reservacionespage()),
        GetPage(name: '/Ajustes', page: () => const Ajustespage()),
        GetPage(name: '/Cerrar_Sesion', page: () => const LoginPage()),
        GetPage(name: '/DescargarQR', page: () => const Nuevo_Visitantepage()),
        //GetPage(name: '/Cambiar_Contrasena', page: () => const CambiarContrasenaPage()),
        GetPage(name: '/Parentesco', page: () => const Parentescopage()),
        //GetPage(name: '/Parentescoss', page: () =>  RegisterScreen()),
      ],
    );
  }
}



/*
class AuthService {
  final String apiUrl = 'http://localhost:3000/';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${apiUrl}login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {'error': jsonDecode(response.body)['message'] ?? 'Login failed'};
    }
  }

  Future<Map<String, dynamic>> getProtectedData(String token) async {
    final response = await http.get(
      Uri.parse('${apiUrl}protected'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {'error': 'Failed to fetch protected data'};
    }
  }
}

*/






















/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// para lo del login las importaciones  http
import 'package:http/http.dart' as http;

import 'Pages/Ajustes.dart';
import 'Pages/Cambiar_contrasena.dart';
import 'Pages/Generar_QR.dart';
import 'Pages/Login.dart';
import 'Pages/Notificaciones.dart';
import 'Pages/Nuevo_Visitante.dart';
import 'Pages/Olvidaste_contrasena.dart';
import 'Pages/Pantalla_principal.dart';
import 'Pages/Registrarse.dart';
import 'Pages/Reservaciones.dart';


//Donde se empieza a ejecutar la aplicacion
void main() { //El void es lo primero que se ejecuta
  runApp(const Villa_Las_Acacias()); //se ejecuta la funcion acasias
}
//para hacer titulo y cuerpo de la App
class Villa_Las_Acacias extends StatelessWidget{
   const Villa_Las_Acacias ({super.key});

   @override
   Widget build (BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, //para quitar el debud de la esquina
      //home: Acacias(),
      initialRoute: '/',

      getPages: [
        //Ruta de inicio
      GetPage(name: '/', page: ()=>  const Loginpage()),
      //rutas del login
      GetPage(name: '/Registrarse', page: ()=> const Registrasepage()),
      GetPage(name: '/Olvidaste_page', page: ()=> const Olvidastepage()),
      GetPage(name: '/Pantalla_Principal', page: ()=> const Principalpage(token: null,)),
      //Rutas de la pantalla principal
      GetPage(name: '/Notificaciones', page: ()=> const Notificacionespage()),
      GetPage(name: '/GenerarQR', page: ()=> const GenerarQRpage()),
      GetPage(name: '/Reservaciones', page: ()=> const Reservacionespage()),
      GetPage(name: '/Ajustes', page: ()=> const Ajustespage()),
      GetPage(name: '/Cerrar_Sesion', page: ()=> const Loginpage()),
      //Ruta de GenerarQR
      GetPage(name: '/DescargarQR', page: ()=> const Nuevo_Visitantepage()),
      //Cambiar contrasenaña
      GetPage(name: '/Cambiar_Cotrasena', page: ()=> const CambiarContrasenaPage()),
      //GetPage(name: '/Pantalla_Principal', page: ()=> const Principalpage()),
      //GetPage(name: '/Pantalla_Principal', page: ()=> const Principalpage()),
      //GetPage(name: '/Pantalla_Principal', page: ()=> const Principalpage()),
        
      ],
    );
   }
}
// Para el Login de los usuarios.
class AuthService {
  final String apiUrl = 'http://localhost:3000/';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {'error': jsonDecode(response.body)['message'] ?? 'Login failed'};
    }
  }

  Future<Map<String, dynamic>> getProtectedData(String token) async {
    final response = await http.get(
      Uri.parse('$apiUrl/protected'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {'error': 'Failed to fetch protected data'};
    }
  }
}

*/











