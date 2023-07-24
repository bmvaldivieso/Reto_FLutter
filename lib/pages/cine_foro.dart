import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'screens.dart';

///CineForo es una clase que extiende de StatefulWidget, lo que significa que representa una página con estado, es decir, su contenido puede cambiar durante la vida útil de la página.
class CineForo extends StatefulWidget {
  const CineForo({Key? key}) : super(key: key);

  @override
  CineForoState createState() => CineForoState();
}

class CineForoState extends State<CineForo> {
  final CineForoService cineService = CineForoService();
  final CarouselController _sliderController = CarouselController();

  void _onMovieTap(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PeliculasDetalle(
          id: id,
        ),
      ),
    );
  }

  ///En el método build, se construye la estructura visual de la página utilizando los widgets proporcionados por Flutter.
  @override
  Widget build(BuildContext context) {
    ///Scaffold es el widget base para una página que tiene una AppBar y un cuerpo.
    return Scaffold(
      ///AppBar es el encabezado de la página y muestra el título "Cine Foro".
      appBar: AppBar(
        title: const Text('Cine Foro'),
      ),

      ///El cuerpo de la página está contenido en un Container con una imagen de fondo. La imagen de fondo se ajusta al tamaño del Container utilizando fit: BoxFit.fill.
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo_claro.jpg'),
            fit: BoxFit.fill,
          ),
        ),

        ///FutureBuilder es un widget que permite construir un widget basado en un Future. En este caso, se utiliza para mostrar un indicador de carga (CircularProgressIndicator) mientras se obtienen los datos de las películas.
        child: FutureBuilder<List<Datum>>(
          future: cineService.fetchPeliculas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final peliculas = snapshot.data!;

              ///Una vez que se obtienen los datos de las películas, se muestra un CarouselSlider que muestra las películas disponibles en forma de carrusel.
              ///CarouselSlider es un widget proporcionado por el paquete carousel_slider que permite mostrar una lista de elementos como un carrusel deslizante. Se utiliza para mostrar las películas disponibles.
              ///Las opciones del CarouselSlider se configuran para especificar la altura del carrusel, el intervalo de cambio de película y el espacio entre los contenedores de película.
              return CarouselSlider(
                carouselController: _sliderController,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 0.78,
                ),
                items: peliculas.map((pelicula) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        ///En el método _onMovieTap, se navega a la página PeliculasDetalle cuando se hace clic en una película. Se pasa el id de la película seleccionada a la página de detalles.
                        onTap: () => _onMovieTap(pelicula.id),

                        ///Para cada película, se crea un Container con una imagen de la película y el título centrados.
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AspectRatio(
                                aspectRatio: 543 / 411,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    pelicula.image.url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                pelicula.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
