// ignore_for_file: avoid_print
///Importa el paquete http, que proporciona funciones y clases para realizar solicitudes HTTP.
import 'package:http/http.dart' as http;

///Importa el paquete dart:convert, que proporciona funciones para codificar y decodificar datos en formato JSON.
import 'dart:convert';

///Importa el modelo PeliculasDetalleModel, que contiene la estructura de datos que se espera recibir como respuesta de la solicitud HTTP.
import '../models/peliculas_detalle_model.dart';

class PeliculasDetalleService {
  ///Define la URL base del servicio web al que se realizará la solicitud para obtener los detalles de la película. Se espera que este servicio web responda con datos en formato JSON.
  final String apiUrl =
      'https://appmovil.utpl.edu.ec:8080/v2/library/benjamin/cine/forum/show/';

  ///Define el método fetchPeliculaDetalle, que es una función asíncrona que devuelve un objeto PeliculasDetalleModel en el futuro. Recibe como argumento el id de la película que se desea obtener.
  Future<PeliculasDetalleModel> fetchPeliculaDetalle(String id) async {
    try {
      ///Realiza una solicitud HTTP GET a la URL del servicio web concatenando el id de la película. El await espera a que se complete la solicitud y devuelve la respuesta en la variable response.
      final response = await http.get(Uri.parse(apiUrl + id));

      ///Verifica si la solicitud fue exitosa (código de estado HTTP 200). Si es así, decodifica el cuerpo de la respuesta JSON y lo convierte en un objeto PeliculasDetalleModel.
      if (response.statusCode == 200) {
        final peliculasDetalleModel =
            PeliculasDetalleModel.fromJson(json.decode(response.body));
        return peliculasDetalleModel;
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
