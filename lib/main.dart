/// Importa el paquete flutter/material.dart, que contiene las clases y widgets básicos para construir la interfaz de usuario en Flutter.
import 'package:flutter/material.dart';

///Importa el paquete get/get.dart, que es una biblioteca de manejo de estado y navegación para Flutter.
import 'package:get/get.dart';

///Importa el archivo screens.dart ubicado en el directorio pages. Este archivo contiene las definiciones de las diferentes pantallas que se mostrarán en la aplicación.
import 'pages/screens.dart';

///Aquí, se define la función main, que es el punto de entrada de la aplicación Flutter. Esta función ejecuta la aplicación y pasa una instancia de MyApp como el widget raíz para iniciar la interfaz de usuario.
void main() => runApp(const MyApp());

///Define la clase MyApp, que es un widget sin estado (StatelessWidget) en Flutter. Un StatelessWidget es un widget que no cambia su estado después de que se ha construido.
class MyApp extends StatelessWidget {
  /// El constructor de MyApp, que acepta un parámetro opcional key. En este caso, el constructor no realiza ninguna lógica adicional y solo llama al constructor de la clase padre.
  const MyApp({super.key});

  @override

  ///La implementación del método build, que es obligatorio para todos los widgets en Flutter. Aquí se define la estructura y la interfaz de usuario de la aplicación.
  Widget build(BuildContext context) {
    ///Retorna un GetMaterialApp, que es un widget proporcionado por GetX para manejar el enrutamiento y el estado de la aplicación. Este widget envuelve toda la interfaz de usuario y define el tema, las rutas y las páginas que componen la aplicación.
    return GetMaterialApp(
      ///Configura si se muestra o no la etiqueta de depuración en la esquina superior derecha de la pantalla cuando la aplicación se ejecuta en modo de depuración.
      debugShowCheckedModeBanner: false,

      ///Define el tema principal de la aplicación. En este caso, se utiliza el tema claro (light) y se personaliza el aspecto del AppBar (barra de aplicación) con colores y estilos específicos.
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue[900]),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),

      ///Define la página de inicio de la aplicación, que es MenuPage. Esta será la primera pantalla que se muestra al abrir la aplicación.
      home: const MenuPage(), //Ruta del Home
      ///Define la lista de rutas y páginas disponibles en la aplicación. Cada elemento en esta lista representa una ruta y está asociado a un widget que se mostrará cuando se navegue a esa ruta.
      getPages: [
        ///Define una ruta de navegación con Get. Cada GetPage contiene un nombre de ruta (name), la página asociada (page), y una transición de navegación (transition).
        GetPage(
          name: '/home',
          page: () => const MenuPage(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/listadoNoticias',
          page: () => const ListadoNoticias(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/cineforo',
          page: () => const CineForo(),
          transition: Transition.native,
        ),
      ],
    );
  }
}
