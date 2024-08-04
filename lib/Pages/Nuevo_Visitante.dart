import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Nuevo_Visitantepage extends StatefulWidget {
  const Nuevo_Visitantepage({super.key});

  @override
  State<Nuevo_Visitantepage> createState() => _Nuevo_VisitanteState();
}

class _Nuevo_VisitanteState extends State<Nuevo_Visitantepage> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading : false,
          backgroundColor: const Color(0xffD9D9D9),
          title: const Text("Nuevo Visitante",
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
              onPressed: () => Get.toNamed('/Pantalla_Principal'),
            ),
          ],

        ),

        body: CuerpoVisitante(),
        
      ),
    );
  }
  
  //El cuerpo  de notificaciones para todos los metodos
  Widget CuerpoVisitante() {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 15,
            ),
          textNuevo_Visitante(),


        ],
      ),

    );
  }
  
  Widget textNuevo_Visitante() {
    return Container(
      height: 40,
      width: 210,
      color: const Color(0xff14A13B),
      child: const Align(//para alinear el texto dentro de contenedor
        alignment: Alignment.center,
      child: Text("Código QR", 
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Colors.white,
        ),
        ),
      )
    );
  }
}