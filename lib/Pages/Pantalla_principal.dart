import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:villa_las_acacias/Service/AuthService.dart';

class Principalpage extends StatefulWidget {
  const Principalpage({super.key, required token});

  @override
  _Principal_page createState() => _Principal_page();
}
final AuthService _authService = AuthService();

class _Principal_page extends State<Principalpage> {
  Future<void> logout() async {
    final response = await _authService.logout();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffD9D9D9),
        appBar: AppBar(
          title: const Text(
            "Villa Las Acacias",
            style: TextStyle(
              color: Color(0xff14A13B),
              fontSize: 24,
            ),
          ),
          //Boton de notificaciones
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Color(0xff14A13B)),
              onPressed: () => Get.toNamed('/Notificaciones'),
            ),
          ],
        ),
        //El drawer es para hacer el menu.
        drawer: Drawer(
          backgroundColor: const Color(0xffBAC8BD),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                  //El drawerHeader es para hacer el perfil del usuario.
                  decoration: BoxDecoration(
                    color: Color(0xffACAFAD),
                  ),
                  child: Column(
                      /*
                  children: [
                    Expanded(child: 
                     //Colocar la imagen del perfil 
                    ),
                  ],
                  */
                      )),
              //Metodos del menu
              Column(
                children: [
                  GenerarQR(),
                  const SizedBox(
                    height: 15,
                  ), // separa los container con un alto de 15
                  Reservaciones(),
                  const SizedBox(
                    height: 15,
                  ), // separa los container con un alto de 15
                  Parentesco(),
                  const SizedBox(
                    height: 15,
                  ), // separa los container con un alto de 15
                  Ajustes(),
                  const SizedBox(
                    height: 15,
                  ), // separa los container con un alto de 15
                  Cerrar_Sesion(),
                ],
              ),
            ],
          ),
        ),
        body: CuerpoPP(),
      ),
    );
  }

//Cuerpo Principal del pantalla principal
  CuerpoPP() {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 15.0,
          ),
          textAnuncios_Eventos(),
        ],
      ),
    );
  }

//*** Metodos para configurar la pantalla principal
  textAnuncios_Eventos() {
    return const Align(
        alignment: Alignment.center, // para alinear el texto al centro
        child: Text(
          "Anuncios y Eventos",
          style: TextStyle(
            color: Color(0xff14A13B),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  //*****  Metodos para el Menu del Drawer *******
  Widget GenerarQR() {
    return Container(
      height: 45,
      width: 255,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: ListTile(
        leading: const Icon(Icons.qr_code),
        title: const Text(
          "Generar QR",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        iconColor: Colors.black,
        textColor: const Color(0xff14A13B),
        onTap: () => Get.toNamed('/GenerarQR'),
      ),
    );
  }

  Widget Reservaciones() {
    return Container(
      height: 45,
      width: 255,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: ListTile(
        leading: const Icon(Icons.event_available),
        title: const Text(
          "Reservaciones",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        iconColor: Colors.indigo,
        textColor: const Color(0xff14A13B),
        onTap: () => Get.toNamed('/Reservaciones'),
      ),
    );
  }

  Widget Parentesco() {
    return Container(
      height: 45,
      width: 255,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: ListTile(
        leading: const Icon(Icons.family_restroom),
        title: const Text(
          "Parentesco",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        iconColor: Colors.purple,
        textColor: const Color(0xff14A13B),
        onTap: () => Get.toNamed('/Parentesco'),
      ),
    );
  }

  Widget Ajustes() {
    return Container(
      height: 45,
      width: 255,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: ListTile(
        leading: const Icon(Icons.settings),
        title: const Text(
          "Ajustes",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        iconColor: Colors.grey,
        textColor: const Color(0xff14A13B),
        onTap: () => Get.toNamed('/Ajustes'),
      ),
    );
  }

  Widget Cerrar_Sesion() {
    return Container(
      height: 45,
      width: 255,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: ListTile(
        leading: const Icon(Icons.exit_to_app),
        title: const Text(
          "Cerrar Sesión",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        iconColor: Colors.red,
        textColor: const Color(0xff14A13B),
        onTap: () async {
          await logout();
          Get.offAllNamed(
              '/Login'); // Redirige al usuario a la pantalla de login
        },
      ),
    );
  }
} //Fin de la Clase principal
