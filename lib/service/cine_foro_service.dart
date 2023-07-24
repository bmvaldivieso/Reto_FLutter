// ignore_for_file: avoid_print
///Importa el paquete http, que proporciona funciones y clases para realizar solicitudes HTTP.
import 'package:http/http.dart' as http;

///Importa el paquete dart:convert, que proporciona funciones para codificar y decodificar datos en formato JSON.
import 'dart:convert';

///Importa el modelo CineForoModel, que contiene la estructura de datos que se espera recibir como respuesta de la solicitud HTTP.
import '../models/cine_foro_model.dart';

class CineForoService {
  /// Define la URL del servicio web al que se realizará la solicitud para obtener la lista de películas del cine foro. Se espera que este servicio web responda con datos en formato JSON.
  final String apiUrl =
      'https://appmovil.utpl.edu.ec:8080/v2/library/benjamin/cine/forum/all?page=1';

  ///Declara una lista de películas (Datum) llamada movies y la inicializa como una lista vacía.
  List<Datum> movies = [];

  ///Define el método fetchPeliculas, que es una función asíncrona que devuelve una lista de objetos Datum (probablemente representando películas) en el futuro.
  Future<List<Datum>> fetchPeliculas() async {
    try {
      ///Realiza una solicitud HTTP GET a la URL del servicio web para obtener la lista de películas del cine foro. El await espera a que se complete la solicitud y devuelve la respuesta en la variable response.
      final response = await http.get(Uri.parse(apiUrl));

      ///Verifica si la solicitud fue exitosa (código de estado HTTP 200). Si es así, decodifica el cuerpo de la respuesta JSON y lo convierte en un objeto CineForoModel.
      if (response.statusCode == 200) {
        final cineForoModel =
            CineForoModel.fromJson(json.decode(response.body));
        movies = cineForoModel.data;
        return movies;
      } else {
        // Error en la solicitud HTTP
        print('Error: ${response.statusCode}');
        throw Exception('Error en la solicitud HTTP');
      }
    } catch (e) {
      // Error en la conexión
      print('Error de conexión: $e');
      throw Exception('Error de conexión');
    }
  }
}
