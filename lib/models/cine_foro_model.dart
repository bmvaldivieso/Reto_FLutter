import 'dart:convert';

/// Esta clase define un modelo de datos estructurado para el Cine Foro de la aplicación Flutter. Es utilizado para mapear los datos recibidos en formato JSON desde una API a objetos de tipo CineForoModel, lo que facilita el acceso y manipulación de los elementos del Cine Foro en la aplicación Flutter.
CineForoModel cineForoModelFromJson(String str) =>
    CineForoModel.fromJson(json.decode(str));

String cineForoModelToJson(CineForoModel data) => json.encode(data.toJson());

class CineForoModel {
  int total;
  int status;
  String page;
  List<Datum> data;

  CineForoModel({
    required this.total,
    required this.status,
    required this.page,
    required this.data,
  });

  factory CineForoModel.fromJson(Map<String, dynamic> json) => CineForoModel(
        total: json["total"],
        status: json["status"],
        page: json["page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "status": status,
        "page": page,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String title;
  List<Related> related;
  String interaction;
  String description;
  dynamic view;
  dynamic date;
  dynamic source;
  Imagee image;
  dynamic video;
  bool deprecated;
  bool enable;
  dynamic endpoint;

  Datum({
    required this.id,
    required this.title,
    required this.related,
    required this.interaction,
    required this.description,
    this.view,
    this.date,
    this.source,
    required this.image,
    this.video,
    required this.deprecated,
    required this.enable,
    this.endpoint,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
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
        endpoint: json["endpoint"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
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
        "endpoint": endpoint,
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
  Type type;
  String name;
  dynamic identifier;

  Related({
    required this.type,
    required this.name,
    this.identifier,
  });

  factory Related.fromJson(Map<String, dynamic> json) => Related(
        type: typeValues.map[json["type"]]!,
        name: json["name"],
        identifier: json["identifier"],
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "name": name,
        "identifier": identifier,
      };
}

enum Type { fecha, duracion }

final typeValues = EnumValues({"Duración": Type.duracion, "Fecha": Type.fecha});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
