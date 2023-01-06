import 'package:feathercap_demo/model/grid_images.dart';

class TvShow {
  TvShow({
    required this.id,
    required this.url,
    required this.name,
    this.image,
    this.embedded,
    this.showFrontSide = true,
    this.gridImages
  });

  final int id;
  final String url;
  final String name;
  bool showFrontSide;
  final Image? image;
  final Embedded? embedded;
  List<GridImages>? gridImages;

  factory TvShow.fromJson(Map<String, dynamic> json) => TvShow(
        id: json["id"] ?? 0,
        url: json["url"] ?? '',
        name: json["name"] ?? '',
        image: json["image"] != null ? Image.fromJson(json["image"]) : null,
        embedded: json["_embedded"] != null
            ? Embedded.fromJson(json["_embedded"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "image": image?.toJson(),
        "_embedded": embedded?.toJson(),
      };
}

class Embedded {
  Embedded({
    this.show,
  });

  final Show? show;

  factory Embedded.fromJson(Map<String, dynamic> json) => Embedded(
        show: json["show"]!=null ? Show.fromJson(json["show"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "show": show?.toJson(),
      };
}

class Show {
  Show({
    required this.id,
  });

  final int id;

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Image {
  Image({
    required this.medium,
    required this.original,
  });

  final String medium;
  final String original;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        medium: json["medium"],
        original: json["original"],
      );

  Map<String, dynamic> toJson() => {
        "medium": medium,
        "original": original,
      };
}