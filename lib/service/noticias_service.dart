// ignore_for_file: avoid_print
///Importa el paquete http, que proporciona funciones y clases para realizar solicitudes HTTP.
import 'package:http/http.dart' as http;

///Importa el paquete dart:convert, que proporciona funciones para codificar y decodificar datos en formato JSON.
import 'dart:convert';

///Importa el modelo NoticiasModel, que contiene la estructura de datos que se espera recibir como respuesta de la solicitud HTTP.
import '../models/noticias_model.dart';

class NoticiasService {
  /// Define la URL del servicio web al que se realizará la solicitud para obtener las noticias. Se espera que este servicio web responda con datos en formato JSON.
  final String apiUrl = 'https://appmovil.utpl.edu.ec:8080/v1/news/all';

  ///Define el método fetchNoticias, que es una función asíncrona que devuelve una lista de objetos Datum en el futuro. Recibe un argumento opcional page que indica el número de página de noticias que se desea obtener (el valor predeterminado es 1).
  Future<List<Datum>> fetchNoticias({int page = 1}) async {
    try {
      ///Realiza una solicitud HTTP GET a la URL del servicio web concatenando el número de página page a la URL. El await espera a que se complete la solicitud y devuelve la respuesta en la variable response.
      final response = await http.get(Uri.parse('$apiUrl?page=$page'));

      ///Verifica si la solicitud fue exitosa (código de estado HTTP 200). Si es así, decodifica el cuerpo de la respuesta JSON y lo convierte en un objeto NoticiasModel.
      if (response.statusCode == 200) {
        final noticiasModel =
            NoticiasModel.fromJson(json.decode(response.body));
        return noticiasModel.data;
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
