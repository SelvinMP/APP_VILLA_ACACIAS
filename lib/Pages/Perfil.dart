import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Perfil_page extends StatefulWidget {
  const Perfil_page({super.key});

  @override
  State<Perfil_page> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil_page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffD9D9D9),
          title: const Text("Perfil",
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
              onPressed: () => Get.toNamed('/Ajustes'),
            ),
          ],

        ),

      ),
    );
  }
}