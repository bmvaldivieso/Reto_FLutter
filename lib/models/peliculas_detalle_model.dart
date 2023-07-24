import 'dart:convert';

///Esta clase define un modelo de datos estructurado que contiene detalles de una película, como su título, atributos, objetos relacionados, descripción, imagen, etc. Es utilizado para mapear los datos recibidos en formato JSON desde una API a objetos de tipo PeliculasDetalleModel, lo que facilita el acceso y manipulación de los datos en la aplicación Flutter.
PeliculasDetalleModel peliculasDetalleModelFromJson(String str) =>
    PeliculasDetalleModel.fromJson(json.decode(str));

String peliculasDetalleModelToJson(PeliculasDetalleModel data) =>
    json.encode(data.toJson());

class PeliculasDetalleModel {
  int status;
  Data data;

  PeliculasDetalleModel({
    required this.status,
    required this.data,
  });

  factory PeliculasDetalleModel.fromJson(Map<String, dynamic> json) =>
      PeliculasDetalleModel(
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
  List<Attr> attrs;
  List<Related> related;
  dynamic interaction;
  String description;
  dynamic view;
  dynamic date;
  dynamic source;
  Imagee image;
  dynamic video;
  bool deprecated;
  bool enable;

  Data({
    required this.id,
    required this.title,
    required this.attrs,
    required this.related,
    this.interaction,
    required this.description,
    this.view,
    this.date,
    this.source,
    required this.image,
    this.video,
    required this.deprecated,
    required this.enable,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        attrs: List<Attr>.from(json["attrs"].map((x) => Attr.fromJson(x))),
        related:
            List<Related>.from(json["related"].map((x) => Related.fromJson(x))),
        interaction: json["interaction"],
        description: json["description"],
        view: json["view"],
        date: json["date"],
        source: json["source"],
        image: Imagee.fromJson(json["image"]),
        video: json["video"],
        deprecated: json["deprecated"],
        enable: json["enable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "attrs": List<dynamic>.from(attrs.map((x) => x.toJson())),
        "related": List<dynamic>.from(related.map((x) => x.toJson())),
        "interaction": interaction,
        "description": description,
        "view": view,
        "date": date,
        "source": source,
        "image": image.toJson(),
        "video": video,
        "deprecated": deprecated,
        "enable": enable,
      };
}

class Attr {
  String name;
  String value;

  Attr({
    required this.name,
    required this.value,
  });

  factory Attr.fromJson(Map<String, dynamic> json) => Attr(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
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
  String name;
  dynamic identifier;

  Related({
    required this.type,
    required this.name,
    this.identifier,
  });

  factory Related.fromJson(Map<String, dynamic> json) => Related(
        type: json["type"],
        name: json["name"],
        identifier: json["identifier"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "identifier": identifier,
      };
}
