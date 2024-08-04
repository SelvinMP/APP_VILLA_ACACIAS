import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:villa_las_acacias/Pages/Cambiar_contrasena.dart';
import 'package:villa_las_acacias/Pages/Perfil.dart';

class Ajustespage extends StatefulWidget {
  const Ajustespage({super.key});

  @override
  State<Ajustespage> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustespage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading : false,
          backgroundColor: const Color(0xffD9D9D9),
          title: const Text("Ajustes",
          style: TextStyle(
          color: Color(0xff14A13B),
          fontSize: 24,
          fontWeight: FontWeight.bold
          ),
          ),
       //Boton de x para bolver a tras
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Color(0xff14A13B),
                size: 40.0,
              ),
              onPressed:() => Get.toNamed('/Pantalla_Principal'),
            ),
          ],

        ),
        body: Cuerpo_Ajustes(),

      ),
    );
  }
  
  Widget Cuerpo_Ajustes() {
    return  Center(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 30),
          Perfil_Usuario(),
          const SizedBox(height: 15),
          Cambiar_Contrasena(),
          const SizedBox(height: 15),
          Verificacion_2Pasos()

        ],
      ),
    );
  }
  
Widget Perfil_Usuario() {
    return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Perfil_page()),
      );
    },
  child: Container(
    height: 60.0,
    width: 320.0,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey, // Color del borde
        width: 3.0, // Ancho del borde
      ),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 15),
        Icon(
          Icons.person, // Icono de perfil
          color: Color(0xff14A13B), // Color del icono
          size: 40.0,
        ),
        SizedBox(width: 10), // Espacio entre el icono y el texto
        Text(
          'Perfil',
          style: TextStyle(
            fontSize: 20, // Tamaño de la fuente
            color: Colors.black, // Color del texto
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  )
  );
}
//Cambiar contrasena
Widget Cambiar_Contrasena() {
    return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CambiarContrasenaPage(token: null)),
      );
    },
  child: Container(
    height: 60.0,
    width: 320.0,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey, // Color del borde
        width: 3.0, // Ancho del borde
      ),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 15),
        Icon(
          Icons.lock, // Icono de candado
          color: Color(0xff14A13B), // Color del icono
          size: 40.0,
        ),
        SizedBox(width: 10), // Espacio entre el icono y el texto
        Text(
          'Cambiar contraseña',
          style: TextStyle(
            fontSize: 20, // Tamaño de la fuente
            color: Colors.black, // Color del texto
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  )
  );
}

//Verificacion de 2 pasos
Widget Verificacion_2Pasos() {
    return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CambiarContrasenaPage(token: null)),
      );
    },
  child: Container(
    height: 60.0,
    width: 320.0,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey, // Color del borde
        width: 3.0, // Ancho del borde
      ),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 15),
        Icon(
          Icons.lock, // Icono de candado
          color: Color(0xff14A13B), // Color del icono
          size: 40.0,
        ),
        SizedBox(width: 10), // Espacio entre el icono y el texto
        Text(
          'Cambiar contraseña',
          style: TextStyle(
            fontSize: 20, // Tamaño de la fuente
            color: Colors.black, // Color del texto
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  )
  );
}

}