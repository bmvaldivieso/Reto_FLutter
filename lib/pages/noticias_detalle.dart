import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

///Este import se utiliza para importar la clase DateFormat que forma parte de la biblioteca intl. La clase DateFormat permite formatear y analizar fechas y horas en diferentes formatos y estilos, lo que es especialmente útil para mostrar fechas en formatos localizados y comprensibles para el usuario.
import 'package:intl/intl.dart';
import '../service/noticias_detalle_service.dart';
import '../models/noticias_detalle_model.dart';

///NoticiasDetalle es un StatefulWidget que toma un parámetro id en su constructor para identificar la noticia de la que se mostrarán los detalles.
class NoticiasDetalle extends StatefulWidget {
  final String id;

  const NoticiasDetalle({Key? key, required this.id}) : super(key: key);

  @override
  State<NoticiasDetalle> createState() => NoticiasDetalleState();
}

class NoticiasDetalleState extends State<NoticiasDetalle> {
  ///En el método build, se utiliza un FutureBuilder para manejar la carga asíncrona de los detalles de la noticia.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
      ),

      ///El FutureBuilder recibe una instancia de NoticiasDetalleService().fetchNoticiaDetalle(widget.id) para obtener los detalles de la noticia utilizando el servicio NoticiasDetalleService. Esta clase se encarga de hacer una solicitud HTTP al servidor para obtener los detalles de la noticia correspondiente al id proporcionado.
      ///Dependiendo del estado de la conexión, el FutureBuilder muestra diferentes Widgets en función de si está esperando la respuesta (muestra un indicador de carga), si hubo un error (muestra un mensaje de error) o si se obtuvieron los detalles de la noticia (muestra los detalles en un ScrollConfiguration).
      body: FutureBuilder<NoticiasDetalleModel>(
        future: NoticiasDetalleService().fetchNoticiaDetalle(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final noticia = snapshot.data!.data;
            final formattedDateTime =
                DateFormat('dd-MM-yyyy, HH:mm').format(noticia.date);

            ///Cuando se obtienen los detalles de la noticia, se construye el ScrollConfiguration con la información recibida. Muestra la imagen de la noticia, su título, elementos relacionados, fecha de actualización, descripción y un botón para compartir la información de la noticia.
            return ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.grey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          noticia.image.url,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          noticia.title,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            for (var related in noticia.related)
                              Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  related.id,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Divider(
                            color: Colors.grey[400],
                            thickness: 1,
                          ),
                        ),
                        Text(
                          'Actualizado $formattedDateTime',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Divider(
                            color: Colors.grey[400],
                            thickness: 1,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            noticia.description,
                            style: const TextStyle(fontSize: 17),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),

      ///El botón para compartir (floatingActionButton) utiliza la biblioteca share_plus para compartir el título y la descripción de la noticia a través de otras aplicaciones en el dispositivo. Al hacer clic en el botón, se abrirá un menú con diferentes opciones para compartir, como mensajes, redes sociales, etc.
      floatingActionButton: Material(
        color: Colors.indigo[200],
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async {
            final snapshot =
                await NoticiasDetalleService().fetchNoticiaDetalle(widget.id);
            final noticia = snapshot.data;
            await Share.share(
              '${noticia.title}\n\n${noticia.description}',
              subject: noticia.title,
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
}

///La clase NoGlowScrollBehavior es una subclase de ScrollBehavior que se utiliza para personalizar el comportamiento de desplazamiento en la pantalla. En este caso, simplemente devuelve el child sin aplicar el efecto de brillo (glow) en el desplazamiento.
class NoGlowScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
