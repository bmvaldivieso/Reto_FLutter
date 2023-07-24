import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/peliculas_detalle_model.dart';
import '../service/peliculas_detalle_service.dart';

///La clase PeliculasDetalle tiene un constructor que toma un parámetro id, que se utiliza para identificar la película de la que se mostrarán los detalles.
class PeliculasDetalle extends StatelessWidget {
  final String id;

  const PeliculasDetalle({Key? key, required this.id}) : super(key: key);

  ///En el método build, se utiliza un FutureBuilder para manejar la carga asíncrona de los detalles de la película.
  @override
  Widget build(BuildContext context) {
    ///El FutureBuilder recibe una instancia de PeliculasDetalleService().fetchPeliculaDetalle(id) para obtener los detalles de la película utilizando el servicio PeliculasDetalleService. Esta clase se encarga de hacer una solicitud HTTP al servidor para obtener los detalles de la película correspondiente al id proporcionado.
    ///Dependiendo del estado de la conexión, el FutureBuilder muestra diferentes Widgets en función de si está esperando la respuesta (muestra un indicador de carga), si hubo un error (muestra un mensaje de error) o si se obtuvieron los detalles de la película (muestra los detalles en un Scaffold).
    return FutureBuilder<PeliculasDetalleModel>(
      future: PeliculasDetalleService().fetchPeliculaDetalle(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Cargando...')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Error al cargar los detalles')),
          );
        } else {
          final pelicula = snapshot.data!;

          ///Cuando se obtienen los detalles de la película, se construye el Scaffold con la información recibida. Muestra la imagen de la película, su título, descripción, atributos y un botón para compartir la información de la película.
          return Scaffold(
            appBar: AppBar(
              title: Text(
                pelicula.data.title,
                style: const TextStyle(
                  fontSize: 13.5,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(pelicula.data.image.url),
                      const SizedBox(height: 16),
                      Text(
                        pelicula.data.title,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: pelicula.data.description.split(' ')[0],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: pelicula.data.description.substring(
                                pelicula.data.description.split(' ')[0].length),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: pelicula.data.attrs.length,
                    itemBuilder: (context, index) {
                      final attr = pelicula.data.attrs[index];
                      return ListTile(
                        title: Text('${attr.name}:',
                            style: const TextStyle(fontSize: 18)),
                        subtitle: Text(attr.value,
                            style: const TextStyle(fontSize: 18)),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      );
                    },
                  ),
                ],
              ),
            ),

            ///El botón para compartir (floatingActionButton) utiliza la biblioteca share_plus para compartir el título y la descripción de la película a través de otras aplicaciones en el dispositivo. Al hacer clic en el botón, se abrirá un menú con diferentes opciones para compartir, como mensajes, redes sociales, etc.
            floatingActionButton: Material(
              color: Colors.indigo[200],
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  await Share.share(
                    '${pelicula.data.title}\n\n${pelicula.data.description}',
                    subject: pelicula.data.title,
                  );
                },
                child: const SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(Icons.share, color: Colors.white),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }
      },
    );
  }
}
