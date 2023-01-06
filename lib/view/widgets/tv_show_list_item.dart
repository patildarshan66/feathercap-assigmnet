import 'package:feathercap_demo/utils/custom_text_styles.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../model/tv_show.dart';
import '../../utils/colors.dart';
import '../../utils/custom_dimensions.dart';
import '../../utils/enums.dart';

class TvShowListItem extends StatefulWidget {
  final TvShow show;
  final VoidCallback onNameClickCallBack;
   const TvShowListItem(
      {Key? key, required this.show, required this.onNameClickCallBack})
      : super(key: key);

  @override
  State<TvShowListItem> createState() => _TvShowListItemState();
}

class _TvShowListItemState extends State<TvShowListItem> {
  late FlipCardController _controller;
 @override
  void initState() {
   _controller = FlipCardController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: greyBlackColor),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlipCard(
            controller: _controller,
            fill: Fill.fillBack,
            flipOnTouch: false,
            direction: FlipDirection.HORIZONTAL,
            front: _buildFront(context),
            back: _buildRear(context),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: (){
                widget.onNameClickCallBack();
              _controller.toggleCard();
            },
            child: Text(
              widget.show.name,
              style: h4_20ptBold(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFront(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        fit: BoxFit.cover,
        imageUrl: widget.show.image?.medium ?? '',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildRear(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.3;
    double width = MediaQuery.of(context).size.width - 32;
    if ((widget.show.gridImages ?? []).isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16)
        ),
        height: height,
        width: width,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return SizedBox(
        height: height,
        width: width,
        child: GridView.builder(
          itemCount: (widget.show.gridImages ?? []).length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: spacing_m,
            mainAxisSpacing: spacing_m,
            childAspectRatio: (width / height),
          ),
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              // height: MediaQuery.of(context).size.height * 0.3,
              // width: double.infinity,
              fit: BoxFit.cover,
              imageUrl:
                  (widget.show.gridImages ?? [])[index].resolutions?.medium?.url ?? '',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          },
        ),
      );
    }
  }
}
