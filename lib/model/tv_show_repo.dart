
import 'package:feathercap_demo/model/grid_images.dart';
import 'package:feathercap_demo/model/search_tv_show.dart';
import 'package:feathercap_demo/model/services/tv_show_services.dart';
import 'package:feathercap_demo/model/services/urls.dart';
import 'package:feathercap_demo/model/tv_show.dart';

class TvShowRepo {
  final TvShowServices _tvShowServices = TvShowServices();

  Future<List<TvShow>> fetchTvShows(String endpoint) async {
    dynamic response = await _tvShowServices.getResponse(endpoint);
    List<TvShow> tvShowList = List<TvShow>.from(response.map((tagJson) => TvShow.fromJson(tagJson)));
    return tvShowList;
  }

  Future<List<SearchTvShow>> searchTvShows(String search) async {
    dynamic response = await _tvShowServices.getResponse(searchShowUrl+search);
    List<SearchTvShow> tvShowList = List<SearchTvShow>.from(response.map((tagJson) => SearchTvShow.fromJson(tagJson)));
    return tvShowList;
  }

  Future<List<GridImages>> fetchShowImages(int id) async {
    dynamic response = await _tvShowServices.getResponse(showImagesUrl.replaceFirst('%id', '$id'));
    List<GridImages> images = List<GridImages>.from(response.map((tagJson) => GridImages.fromJson(tagJson)));
    return images;
  }
}