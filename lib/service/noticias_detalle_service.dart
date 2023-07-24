// ignore_for_file: avoid_print
/// Importa el paquete http, que proporciona funciones y clases para realizar solicitudes HTTP.
import 'package:http/http.dart' as http;

/// Importa el paquete dart:convert, que proporciona funciones para codificar y decodificar datos en formato JSON.
import 'dart:convert';

///Importa el modelo NoticiasDetalleModel, que contiene la estructura de datos que se espera recibir como respuesta de la solicitud HTTP.
import '../models/noticias_detalle_model.dart';

class NoticiasDetalleService {
  ///Define la URL del servicio web al que se realizará la solicitud para obtener los detalles de la noticia. Se espera que este servicio web responda con datos en formato JSON.
  final String apiUrl = 'https://appmovil.utpl.edu.ec:8080/v1/news/show/';

  ///Define el método fetchNoticiaDetalle, que es una función asíncrona que devuelve un objeto NoticiasDetalleModel en el futuro. Recibe un argumento id que indica el identificador único de la noticia para la cual se desea obtener los detalles.
  Future<NoticiasDetalleModel> fetchNoticiaDetalle(String id) async {
    try {
      ///Realiza una solicitud HTTP GET a la URL del servicio web concatenando el identificador id de la noticia a la URL. El await espera a que se complete la solicitud y devuelve la respuesta en la variable response.
      final response = await http.get(Uri.parse(apiUrl + id));

      ///Verifica si la solicitud fue exitosa (código de estado HTTP 200). Si es así, decodifica el cuerpo de la respuesta JSON y lo convierte en un objeto NoticiasDetalleModel.
      if (response.statusCode == 200) {
        final noticiasDetalleModel =
            NoticiasDetalleModel.fromJson(json.decode(response.body));
        return noticiasDetalleModel;
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
