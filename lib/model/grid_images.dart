class GridImages {
  GridImages({
    required this.id,
    required this.type,
    required this.main,
    required this.resolutions,
  });

  final int id;
  final String type;
  final bool main;
  final Resolutions? resolutions;

  factory GridImages.fromJson(Map<String, dynamic> json) => GridImages(
        id: json["id"],
        type: json["type"] ?? '',
        main: json["main"],
        resolutions: json["resolutions"] != null
            ? Resolutions.fromJson(json["resolutions"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "main": main,
        "resolutions": resolutions?.toJson(),
      };
}

class Resolutions {
  Resolutions({
    required this.original,
    required this.medium,
  });

  final Original? original;
  final Original? medium;

  factory Resolutions.fromJson(Map<String, dynamic> json) => Resolutions(
        original: json["original"] == null
            ? null
            : Original.fromJson(json["original"]),
        medium:
            json["medium"] == null ? null : Original.fromJson(json["medium"]),
      );

  Map<String, dynamic> toJson() => {
        "original": original?.toJson(),
        "medium": medium?.toJson(),
      };
}

class Original {
  Original({
    required this.url,
    required this.width,
    required this.height,
  });

  final String url;
  final int width;
  final int height;

  factory Original.fromJson(Map<String, dynamic> json) => Original(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}
