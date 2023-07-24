import 'package:flutter/material.dart';

///MenuPage es una clase que extiende de StatelessWidget, lo que significa que representa una página sin estado, es decir, su contenido no cambia durante la vida útil de la página.
class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  ///En el método build, se construye la estructura visual de la página utilizando los widgets proporcionados por Flutter.
  @override
  Widget build(BuildContext context) {
    ///Scaffold es el widget base para una página que tiene una AppBar, un cuerpo y un FAB (Floating Action Button) opcional.
    return Scaffold(
      ///AppBar es el encabezado de la página y contiene un ícono (leading) en la esquina izquierda y un título en el centro. En este caso, el ícono es Icons.subject y el título es "Servicios".
      appBar: AppBar(
        leading: const Icon(Icons.subject, size: 32),
        title: const Text('Servicios'),
      ),

      ///El cuerpo de la página está contenido dentro de un Center widget y contiene una fila (Row) con dos elementos. Cada elemento representa una opción de servicio y está envuelto en un widget Expanded para que ocupen el espacio disponible de manera equitativa.
      body: Center(
        ///Cada opción de servicio está representada por un InkWell, que es un widget que responde a los toques del usuario. Al hacer clic en una opción, se navegará a la página correspondiente utilizando la función Navigator.pushNamed.
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/listadoNoticias');
                },
                borderRadius: BorderRadius.circular(10),

                ///Cada opción de servicio está dentro de un Container con un color de fondo y bordes redondeados (BorderRadius.circular). También tiene relleno (padding) para dar espacio entre el contenido y los bordes del contenedor.
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 42),

                  ///Dentro de cada contenedor, se coloca una columna (Column) que contiene un ícono (Icon) y un texto (Text) que representa el servicio. El tamaño del ícono y el texto se controla mediante el estilo (TextStyle) y otros atributos del widget.
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Icon(Icons.article_outlined, size: 75),
                      SizedBox(height: 10),
                      Text(
                        "Noticias",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/cineforo');
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 42),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Icon(Icons.movie_outlined, size: 75),
                      SizedBox(height: 10),
                      Text(
                        "Cine Foro",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
