import 'package:feathercap_demo/model/apis/api_response.dart';
import 'package:feathercap_demo/model/services/urls.dart';
import 'package:feathercap_demo/model/tv_show.dart';
import 'package:feathercap_demo/utils/utils.dart';
import 'package:get/get.dart';

import '../model/search_tv_show.dart';
import '../model/tv_show_repo.dart';

class SearchShowViewModel extends GetxController {
  final TvShowRepo _showRepo = TvShowRepo();
  ApiResponse _apiResponse = ApiResponse.initial('Initial');

  List<SearchTvShow> _searchShowList = [];

  List<SearchTvShow> get searchShowList {
    return _searchShowList;
  }

  ApiResponse get apiResponse {
    return _apiResponse;
  }

  Future<void> searchTvShow(String search) async {
    await isConnected().then((value) async {
      try {
        _apiResponse = ApiResponse.loading('Data Loading');
        update();
        _searchShowList = await _showRepo.searchTvShows(search);
        _apiResponse = ApiResponse.completed('Data Received');
        update();
      } catch (e) {
        _apiResponse = ApiResponse.error(e.toString());
        update();
      }
    }).onError((error, stackTrace) {
      _apiResponse = ApiResponse.notInternet('No internet connection');
      showSnackBar('No internet connection', title: "Error");
    });
  }

  Future<void> fetchShowImages(int id) async {
    await isConnected().then((value) async {
      try {
        final showImages = await _showRepo.fetchShowImages(id);
        _searchShowList.where((element) => element.show.id == id).toList().forEach((element) {
          element.show.gridImages = showImages;
        });
      } catch (e) {
        showSnackBar(e.toString(),title: "Error");
      }
      update();
    }).onError((error, stackTrace) {
      showSnackBar('No internet connection', title: "Error");
    });
  }

  void flipCard(int id, bool showFrontSide){
    _searchShowList.firstWhere((element) => element.show.id == id).show.showFrontSide = showFrontSide;
    update();
  }
}
