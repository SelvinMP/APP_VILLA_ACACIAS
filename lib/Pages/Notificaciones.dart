import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notificacionespage extends StatefulWidget {
  const Notificacionespage({super.key});

  @override
  State<Notificacionespage> createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificacionespage> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading : false,
          backgroundColor: const Color(0xffD9D9D9),
          title: const Text("Notificaciones",
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
              onPressed: () => Get.toNamed('/Pantalla_Principal')
            ),
          ],

        ),
        
      ),
    );
  }
}