import 'dart:convert';

///Esta clase define un modelo de datos estructurado que contiene información sobre noticias, incluidos detalles como título, descripción, fecha, imagen y objetos relacionados. Es utilizado para mapear los datos recibidos en formato JSON desde una API a objetos de tipo NoticiasModel, lo que facilita el acceso y manipulación de los datos en la aplicación Flutter.
NoticiasModel noticiasModelFromJson(String str) =>
    NoticiasModel.fromJson(json.decode(str));

String noticiasModelToJson(NoticiasModel data) => json.encode(data.toJson());

class NoticiasModel {
  int status;
  int page;
  int total;
  List<Datum> data;

  NoticiasModel({
    required this.status,
    required this.page,
    required this.total,
    required this.data,
  });

  factory NoticiasModel.fromJson(Map<String, dynamic> json) => NoticiasModel(
        status: json["status"],
        page: json["page"],
        total: json["total"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "page": page,
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String title;
  String description;
  Imagee image;
  DateTime date;
  List<Related> related;
  Interaction interaction;
  Endpoint endpoint;

  Datum({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    required this.related,
    required this.interaction,
    required this.endpoint,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: Imagee.fromJson(json["image"]),
        date: DateTime.parse(json["date"]),
        related:
            List<Related>.from(json["related"].map((x) => Related.fromJson(x))),
        interaction: interactionValues.map[json["interaction"]]!,
        endpoint: Endpoint.fromJson(json["endpoint"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image.toJson(),
        "date": date.toIso8601String(),
        "related": List<dynamic>.from(related.map((x) => x.toJson())),
        "interaction": interactionValues.reverse[interaction],
        "endpoint": endpoint.toJson(),
      };
}

class Endpoint {
  String urlBase;
  UrlPath urlPath;
  bool authentication;
  Version version;
  Method method;
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
        urlPath: urlPathValues.map[json["url_path"]]!,
        authentication: json["authentication"],
        version: versionValues.map[json["version"]]!,
        method: methodValues.map[json["method"]]!,
        headers: json["headers"],
        queryParams: List<dynamic>.from(json["query_params"].map((x) => x)),
        pathVariables: List<PathVariable>.from(
            json["path_variables"].map((x) => PathVariable.fromJson(x))),
        gui: Gui.fromJson(json["gui"]),
      );

  Map<String, dynamic> toJson() => {
        "url_base": urlBase,
        "url_path": urlPathValues.reverse[urlPath],
        "authentication": authentication,
        "version": versionValues.reverse[version],
        "method": methodValues.reverse[method],
        "headers": headers,
        "query_params": List<dynamic>.from(queryParams.map((x) => x)),
        "path_variables":
            List<dynamic>.from(pathVariables.map((x) => x.toJson())),
        "gui": gui.toJson(),
      };
}

class Gui {
  Layout layout;
  dynamic cardtype;

  Gui({
    required this.layout,
    this.cardtype,
  });

  factory Gui.fromJson(Map<String, dynamic> json) => Gui(
        layout: layoutValues.map[json["layout"]]!,
        cardtype: json["cardtype"],
      );

  Map<String, dynamic> toJson() => {
        "layout": layoutValues.reverse[layout],
        "cardtype": cardtype,
      };
}

enum Layout { show }

final layoutValues = EnumValues({"show": Layout.show});

enum Method { get }

final methodValues = EnumValues({"GET": Method.get});

class PathVariable {
  Name name;
  String value;
  PathVariableType type;
  dynamic defaultValue;

  PathVariable({
    required this.name,
    required this.value,
    required this.type,
    this.defaultValue,
  });

  factory PathVariable.fromJson(Map<String, dynamic> json) => PathVariable(
        name: nameValues.map[json["name"]]!,
        value: json["value"],
        type: pathVariableTypeValues.map[json["type"]]!,
        defaultValue: json["default_value"],
      );

  Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "value": value,
        "type": pathVariableTypeValues.reverse[type],
        "default_value": defaultValue,
      };
}

enum Name { the_1 }

final nameValues = EnumValues({"{1}": Name.the_1});

enum PathVariableType { body }

final pathVariableTypeValues = EnumValues({"body": PathVariableType.body});

enum UrlPath { newsshow1 }

final urlPathValues = EnumValues({"news/show/{1}": UrlPath.newsshow1});

enum Version { v1 }

final versionValues = EnumValues({"/v1/": Version.v1});

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

enum Interaction { endpoint }

final interactionValues = EnumValues({"endpoint": Interaction.endpoint});

class Related {
  RelatedType type;
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
        type: relatedTypeValues.map[json["type"]]!,
        id: json["id"],
        name: json["name"],
        deprecated: json["deprecated"],
        enable: json["enable"],
      );

  Map<String, dynamic> toJson() => {
        "type": relatedTypeValues.reverse[type],
        "id": id,
        "name": name,
        "deprecated": deprecated,
        "enable": enable,
      };
}

enum RelatedType { categora }

final relatedTypeValues = EnumValues({"categoría": RelatedType.categora});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
