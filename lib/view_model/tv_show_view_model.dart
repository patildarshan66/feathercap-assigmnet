import 'package:feathercap_demo/model/apis/api_response.dart';
import 'package:feathercap_demo/model/grid_images.dart';
import 'package:feathercap_demo/model/services/urls.dart';
import 'package:feathercap_demo/model/tv_show.dart';
import 'package:feathercap_demo/utils/utils.dart';
import 'package:get/get.dart';
import '../model/tv_show_repo.dart';

class TvShowViewModel extends GetxController {
  final TvShowRepo _showRepo = TvShowRepo();
  ApiResponse _apiResponse = ApiResponse.initial('Initial');

  List<TvShow> _tvShowList = [];

  List<TvShow> get tvShowList {
    return _tvShowList;
  }

  ApiResponse get apiResponse {
    return _apiResponse;
  }

  Future<void> fetchTvShow() async {
    await isConnected().then((value) async {
      try {
        _apiResponse = ApiResponse.loading('Data Loading');
        update();
        _tvShowList = await _showRepo.fetchTvShows(tvShowUrl
            .replaceFirst('%s1', '2022-12-01')
            .replaceFirst('%s2', 'US'));
        _apiResponse = ApiResponse.completed('Data Received');
        update();
      } catch (e) {
        _apiResponse = ApiResponse.error(e.toString());
        update();
      }
    }).onError((error, stackTrace) {
      _apiResponse = ApiResponse.notInternet('No internet connection');
      showSnackBar('No internet connection', title: "Error");
      update();
    });
  }

  Future<void> fetchShowImages(int id) async {
    await isConnected().then((value) async {
      try {
       final showImages = await _showRepo.fetchShowImages(id);
       _tvShowList.where((element) => element.embedded?.show?.id == id).toList().forEach((element) {
         element.gridImages = showImages;
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
    _tvShowList.firstWhere((element) => element.id == id).showFrontSide = showFrontSide;
    update();
  }
}
