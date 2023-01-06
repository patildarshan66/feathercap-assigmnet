import 'package:feathercap_demo/model/tv_show.dart';

class SearchTvShow {
  SearchTvShow({
    required this.score,
    required this.show,
  });

  final double score;
  final TvShow show;

  factory SearchTvShow.fromJson(Map<String, dynamic> json) => SearchTvShow(
    score: json["score"] ?? 0.toDouble(),
    show: TvShow.fromJson(json["show"]),
  );

  Map<String, dynamic> toJson() => {
    "score": score,
    "show": show.toJson(),
  };
}
