import 'dart:math';

import 'package:feathercap_demo/utils/colors.dart';
import 'package:feathercap_demo/utils/custom_dimensions.dart';
import 'package:feathercap_demo/utils/enums.dart';
import 'package:feathercap_demo/view/search_tv_show_Screen.dart';
import 'package:feathercap_demo/view/widgets/tv_show_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/custom_text_styles.dart';
import '../view_model/tv_show_view_model.dart';

class TvShowScreen extends StatefulWidget {
  const TvShowScreen({Key? key}) : super(key: key);

  @override
  State<TvShowScreen> createState() => _TvShowScreenState();
}

class _TvShowScreenState extends State<TvShowScreen> {
  final TvShowViewModel _tvShowViewModel = Get.put(TvShowViewModel());
  @override
  void initState() {
    _tvShowViewModel.fetchTvShow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: GetBuilder(
        init: _tvShowViewModel,
        builder: (controller) {
          return _getBody();
        },
      )),
    );
  }

  Widget _getBody() {
    if (_tvShowViewModel.apiResponse.status == Status.error ||
        _tvShowViewModel.apiResponse.status == Status.noInternet) {
      return Center(
        child: Text(
            _tvShowViewModel.apiResponse.message ?? "Something went wrong"),
      );
    } else if (_tvShowViewModel.apiResponse.status == Status.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_tvShowViewModel.apiResponse.status == Status.complete) {
      return Column(
        children: [
          InkWell(
            onTap: (){
              Get.to(const SearchTvShowScreen());
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: greyBlackColor),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20, top: 30,left: 16,right: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text('Search show',style: subTitle1_16ptBold()),
                  const SizedBox(width: spacing_xxl_2),
                  const Icon(Icons.search),
                ],
              )
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tvShowViewModel.tvShowList.length,
              itemBuilder: (ctx, i) {
                return TvShowListItem(
                  show: _tvShowViewModel.tvShowList[i],
                  onNameClickCallBack: (){
                    if(_tvShowViewModel.tvShowList[i].showFrontSide){
                      _tvShowViewModel.fetchShowImages(_tvShowViewModel.tvShowList[i].embedded?.show?.id ?? 0);
                    }
                    _tvShowViewModel.flipCard(_tvShowViewModel.tvShowList[i].id, !_tvShowViewModel.tvShowList[i].showFrontSide);
                  },
                );
              },
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
