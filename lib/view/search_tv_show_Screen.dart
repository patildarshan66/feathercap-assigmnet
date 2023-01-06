import 'package:feathercap_demo/view/widgets/tv_show_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/enums.dart';
import '../view_model/search_show_view_model.dart';

class SearchTvShowScreen extends StatefulWidget {
  const SearchTvShowScreen({Key? key}) : super(key: key);

  @override
  State<SearchTvShowScreen> createState() => _SearchTvShowScreenState();
}

class _SearchTvShowScreenState extends State<SearchTvShowScreen> {

  final SearchShowViewModel _searchShowViewModel = Get.put(SearchShowViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder(
          init: _searchShowViewModel,
          builder: (controller) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin:
                  const EdgeInsets.only(bottom: 20, top: 30, left: 16, right: 16),
                  child: TextField(
                    onSubmitted: _searchShowViewModel.searchTvShow,
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: 'Search shows',
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                _getBody(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _getBody() {
    if (_searchShowViewModel.apiResponse.status == Status.error ||
        _searchShowViewModel.apiResponse.status == Status.noInternet) {
      return Expanded(
        child: Center(
          child: Text(
              _searchShowViewModel.apiResponse.message ?? "Something went wrong"),
        ),
      );
    } else if (_searchShowViewModel.apiResponse.status == Status.loading) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    } else if (_searchShowViewModel.apiResponse.status == Status.complete) {
      return Expanded(
        child: ListView.builder(
          itemCount: _searchShowViewModel.searchShowList.length,
          itemBuilder: (ctx, i) {
            return TvShowListItem(
              show: _searchShowViewModel.searchShowList[i].show,
              onNameClickCallBack: (){
                if(_searchShowViewModel.searchShowList[i].show.showFrontSide){
                  _searchShowViewModel.fetchShowImages(_searchShowViewModel.searchShowList[i].show?.id ?? 0);
                }
                _searchShowViewModel.flipCard(_searchShowViewModel.searchShowList[i].show.id, !_searchShowViewModel.searchShowList[i].show.showFrontSide);
              },
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
