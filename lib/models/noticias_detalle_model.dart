import 'dart:convert';

///Esta clase define un modelo de datos estructurado que contiene información detallada sobre los detalles de una noticia, incluidos el título, la descripción, la fecha, la imagen y objetos relacionados con la noticia. Es utilizado para mapear los datos recibidos en formato JSON desde una API a objetos de tipo NoticiasDetalleModel, lo que facilita el acceso y manipulación de los detalles de la noticia en la aplicación Flutter.
NoticiasDetalleModel noticiasDetalleModelFromJson(String str) =>
    NoticiasDetalleModel.fromJson(json.decode(str));

String noticiasDetalleModelToJson(NoticiasDetalleModel data) =>
    json.encode(data.toJson());

class NoticiasDetalleModel {
  int status;
  Data data;

  NoticiasDetalleModel({
    required this.status,
    required this.data,
  });

  factory NoticiasDetalleModel.fromJson(Map<String, dynamic> json) =>
      NoticiasDetalleModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String title;
  String description;
  Imagee image;
  DateTime date;
  List<Related> related;
  String interaction;
  Endpoint endpoint;

  Data({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    required this.related,
    required this.interaction,
    required this.endpoint,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: Imagee.fromJson(json["image"]),
        date: DateTime.parse(json["date"]),
        related:
            List<Related>.from(json["related"].map((x) => Related.fromJson(x))),
        interaction: json["interaction"],
        endpoint: Endpoint.fromJson(json["endpoint"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image.toJson(),
        "date": date.toIso8601String(),
        "related": List<dynamic>.from(related.map((x) => x.toJson())),
        "interaction": interaction,
        "endpoint": endpoint.toJson(),
      };
}

class Endpoint {
  String urlBase;
  String urlPath;
  bool authentication;
  String version;
  String method;
  dynamic headers;
  List<dynamic> queryParams;
  List<PathVariable> pathVariables;
  Gui gui;

  Endpoint({
    required this.urlBase,
    required this.urlPath,
    required this.authentication,
    required this.version,
    required this.method,
    this.headers,
    required this.queryParams,
    required this.pathVariables,
    required this.gui,
  });

  factory Endpoint.fromJson(Map<String, dynamic> json) => Endpoint(
        urlBase: json["url_base"],
        urlPath: json["url_path"],
        authentication: json["authentication"],
        version: json["version"],
        method: json["method"],
        headers: json["headers"],
        queryParams: List<dynamic>.from(json["query_params"].map((x) => x)),
        pathVariables: List<PathVariable>.from(
            json["path_variables"].map((x) => PathVariable.fromJson(x))),
        gui: Gui.fromJson(json["gui"]),
      );

  Map<String, dynamic> toJson() => {
        "url_base": urlBase,
        "url_path": urlPath,
        "authentication": authentication,
        "version": version,
        "method": method,
        "headers": headers,
        "query_params": List<dynamic>.from(queryParams.map((x) => x)),
        "path_variables":
            List<dynamic>.from(pathVariables.map((x) => x.toJson())),
        "gui": gui.toJson(),
      };
}

class Gui {
  String layout;
  dynamic cardtype;

  Gui({
    required this.layout,
    this.cardtype,
  });

  factory Gui.fromJson(Map<String, dynamic> json) => Gui(
        layout: json["layout"],
        cardtype: json["cardtype"],
      );

  Map<String, dynamic> toJson() => {
        "layout": layout,
        "cardtype": cardtype,
      };
}

class PathVariable {
  String name;
  String value;
  String type;
  dynamic defaultValue;

  PathVariable({
    required this.name,
    required this.value,
    required this.type,
    this.defaultValue,
  });

  factory PathVariable.fromJson(Map<String, dynamic> json) => PathVariable(
        name: json["name"],
        value: json["value"],
        type: json["type"],
        defaultValue: json["default_value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "type": type,
        "default_value": defaultValue,
      };
}

class Imagee {
  String url;
  String thumb;
  String medium;

  Imagee({
    required this.url,
    required this.thumb,
    required this.medium,
  });

  factory Imagee.fromJson(Map<String, dynamic> json) => Imagee(
        url: json["url"],
        thumb: json["thumb"],
        medium: json["medium"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "thumb": thumb,
        "medium": medium,
      };
}

class Related {
  String type;
  String id;
  String name;
  bool deprecated;
  bool enable;

  Related({
    required this.type,
    required this.id,
    required this.name,
    required this.deprecated,
    required this.enable,
  });

  factory Related.fromJson(Map<String, dynamic> json) => Related(
        type: json["type"],
        id: json["id"],
        name: json["name"],
        deprecated: json["deprecated"],
        enable: json["enable"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "name": name,
        "deprecated": deprecated,
        "enable": enable,
      };
}
