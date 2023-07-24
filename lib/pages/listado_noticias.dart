import 'package:app_utpl/pages/noticias_detalle.dart';
import 'package:flutter/material.dart';
import '../service/noticias_service.dart';
import '../models/noticias_model.dart';

///ListadoNoticias es una clase que extiende de StatefulWidget, lo que significa que representa una página con estado, es decir, su contenido puede cambiar durante la vida útil de la página.
class ListadoNoticias extends StatefulWidget {
  const ListadoNoticias({Key? key}) : super(key: key);

  @override
  ListadoNoticiasState createState() => ListadoNoticiasState();
}

class ListadoNoticiasState extends State<ListadoNoticias> {
  final NoticiasService noticiasService = NoticiasService();
  final ScrollController _scrollController = ScrollController();
  final List<Datum> _noticias = [];
  int _currentPage = 1;
  bool _isLoading = false;

  ///El método initState, se inicializan los estados y se inicia la carga de noticias mediante la función _loadNoticias.
  @override
  void initState() {
    super.initState();
    _loadNoticias();
    _scrollController.addListener(_onScroll);
  }

  ///El método dispose, se libera el ScrollController cuando la página se descarte para evitar fugas de memoria.
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ///_loadNoticias es una función asincrónica que realiza la llamada a NoticiasService para obtener las noticias de una página específica y las agrega a la lista _noticias.
  void _loadNoticias() async {
    setState(() {
      ///Mientras se están cargando las noticias, se establece la variable _isLoading en true y luego se actualiza a false una vez que la carga se completa o si ocurre un error.
      _isLoading = true;
    });

    try {
      final nuevasNoticias =
          await noticiasService.fetchNoticias(page: _currentPage);
      setState(() {
        _noticias.addAll(nuevasNoticias);
      });
    } catch (e) {
      // Manejo de errores
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  ///La función _onScroll para controlar el desplazamiento de la lista ademas _onScroll es una función que se ejecuta cuando el usuario desplaza la lista. Si llega al final de la lista (scroll position atEdge y pixels != 0), se incrementa _currentPage y se llama a _loadNoticias para cargar más noticias de la siguiente página.
  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      setState(() {
        _currentPage++;
      });
      _loadNoticias();
    }
  }

  ///En el método build, se construye la estructura visual de la página utilizando los widgets proporcionados por Flutter.
  @override
  Widget build(BuildContext context) {
    ///Scaffold es el widget base para una página que tiene una AppBar y un cuerpo.
    return Scaffold(
      ///AppBar es el encabezado de la página y muestra el título "Noticias".
      appBar: AppBar(
        title: const Text('Noticias'),
      ),

      ///El cuerpo de la página contiene un ListView.builder, que muestra la lista de noticias. La cantidad de elementos en la lista es _noticias.length * 2 + 1, y esto se debe a que se insertan divisores (Divider) entre cada noticia para separarlas visualmente. Cada noticia es representada por un ListTile que muestra el título y una imagen de la noticia.
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _noticias.length * 2 + 1,
        itemBuilder: (context, index) {
          ///Si el índice es impar, se muestra un Divider para separar las noticias.
          if (index.isOdd) {
            return Divider(
              color: Colors.grey[400],
              thickness: 1,
            );
          }

          final noticiaIndex = index ~/ 2;
          if (noticiaIndex < _noticias.length) {
            final noticia = _noticias[noticiaIndex];
            return ListTile(
              title: Text(noticia.title),
              leading: FadeInImage(
                placeholder: const AssetImage('assets/loading-cargando.gif'),
                image: NetworkImage(noticia.image.url),
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 20),
              ),

              ///Al hacer clic en una noticia, se navega a la página NoticiasDetalle pasando el id de la noticia seleccionada.
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoticiasDetalle(id: noticia.id),
                  ),
                );
              },
            );
          } else {
            return _isLoading
                ? _buildLoadingIndicator()
                : const SizedBox.shrink();
          }
        },
      ),
    );
  }

  ///La función _buildLoadingIndicator muestra un indicador de carga (CircularProgressIndicator) mientras se están cargando las noticias.
  Widget _buildLoadingIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
