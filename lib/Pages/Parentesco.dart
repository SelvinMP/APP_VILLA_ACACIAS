import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Parentescopage extends StatefulWidget {
  const Parentescopage({super.key});

  @override
  State<Parentescopage> createState() => _ParentescoState();
}

class _ParentescoState extends State<Parentescopage> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading : false,
          backgroundColor: const Color(0xffD9D9D9),
          title: const Text("Parentesco",
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

        body: CuerpoParentesco(),
        
      ),
    );
  }
  
  //El cuerpo  de notificaciones para todos los metodos
  CuerpoParentesco() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 15,
            ),
          textNuevo_Visitante(),
          const SizedBox(
            height: 15.0,
          ),
          textNombre(),
          boxNombre(),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          textDNI_Persona(),
          boxDNI_Persona(),
          const SizedBox(
            height: 10,
          ),
          TextParentesco(),
          boxParentesco(),
          const SizedBox(
            height: 10,
          ),
          texTipo_Evento(),
          boxTipo_Evento(),
          const SizedBox(
            height: 20,
          ),
          GENERAR(),
          const SizedBox(
            height: 10,
          ),
          CANCELAR(),
        ],
      ),

    );
  }
  
  //Es el contenedor verde con las letras que dice Nueva Reservacion
  textNuevo_Visitante() {
    return Container(
      height: 40,
      width: 300,
      color: const Color(0xff14A13B),
      child: const Align(//para alinear el texto dentro de contenedor
        alignment: Alignment.center,
      child: Text("Nuevo Parentesco", 
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Colors.white,
        ),
        ),
      )
    );
  }

//*****Los tex y texbox para llenar la informacion *****
Widget textNombre() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30.0),
    child: const Align(
        alignment: Alignment.bottomLeft, // para alinear el texto a la izquierda
        child: Text(
          "Nombre:",
          style: TextStyle(
            fontSize: 20,
          ),
        )
        ),
  );
}

Widget boxNombre(){
  return Container(
     margin: const EdgeInsets.symmetric(horizontal: 30.0),
    child: const TextField(
      enableInteractiveSelection: false,
      autofocus: true,
      textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
  ));
}

Widget textDNI_Persona() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30.0),
    child: const Align(
        alignment: Alignment.bottomLeft, // para alinear el texto a la izquierda
        child: Text(
          "DNI Persona:",
          style: TextStyle(
            fontSize: 20,
          ),
        )),
  );
}

Widget boxDNI_Persona(){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30.0),
    child: const TextField(
      enableInteractiveSelection: false,
      autofocus: true,
      textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        ),
      ),
  );
}

Widget TextParentesco() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30.0),
    child: const Align(
        alignment: Alignment.bottomLeft, // para alinear el texto a la izquierda
        child: Text(
          "Parentesco:",
          style: TextStyle(
            fontSize: 20,
          ),
        )),
  );
}

Widget boxParentesco(){
  return Container(
     margin: const EdgeInsets.symmetric(horizontal: 30.0),
    child: const TextField(
      enableInteractiveSelection: false,
      autofocus: true,
      textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: "Elige tipo de  Parentesco",
          filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        ),
      ),
  );
}

Widget texTipo_Evento() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30.0),
    child: const Align(
        alignment: Alignment.bottomLeft, // para alinear el texto a la izquierda
        child: Text(
          "Tipo de Evento:",
          style: TextStyle(
            fontSize: 20,
          ),
        )),
  );
}

Widget boxTipo_Evento(){
  return Container(
     margin: const EdgeInsets.symmetric(horizontal: 30.0),
    child: const TextField(
      enableInteractiveSelection: false,
      autofocus: true,
      textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        ),
      ),
  );
}

//***Botones de CANCELAR y GENERAR 


  Widget CANCELAR() {
    return Container(
      height: 40,
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff908F8F)
        ),
        onPressed: () => Get.toNamed('/Pantalla_Principal'),
        child: const Text('CANCELAR',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white
          ),
          ),
      ),
    );
  }

    Widget GENERAR() {
    return Container(
      height: 40,
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff14A13B)
        ),
        onPressed: () {
          // Acción al presionar el botón
          print('ElevatedButton presionado');
          //Navigator.pushNamed(context, '/second');
        },
        child: const Text('GENERAR',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white
          ),
          ),
      ),
    );
  }


}//fIN DE LA CLASE PRINCIPAL