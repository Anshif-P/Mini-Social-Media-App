import 'package:flutter/material.dart';
import 'package:mini_social_media_app/model/post_model.dart';
import 'package:mini_social_media_app/util/constance/text_style.dart';

class ProductGridViewWidget extends StatelessWidget {
  final List<PostModel> productList;
  ProductGridViewWidget({super.key, required this.productList});

  // Map to keep track of like and save state for each product
  final Map<int, ValueNotifier<bool>> _isLiked = {};
  final Map<int, ValueNotifier<bool>> _isSaved = {};

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        final data = productList[index];

        _isLiked.putIfAbsent(index, () => ValueNotifier(false));
        _isSaved.putIfAbsent(index, () => ValueNotifier(false));

        return InkWell(
          onTap: () {},
          child: Container(
            height: 120,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(data.image),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 15,
                              child: Text(
                                data.title,
                                style: AppText.smallDark,
                              ),
                            ),
                            SizedBox(
                              child: Text(data.description),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ValueListenableBuilder<bool>(
                                  valueListenable: _isLiked[index]!,
                                  builder: (context, isLiked, child) => InkWell(
                                    onTap: () {
                                      _isLiked[index]!.value = !isLiked;
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: isLiked ? Colors.red : Colors.grey,
                                    ),
                                  ),
                                ),
                                ValueListenableBuilder<bool>(
                                  valueListenable: _isSaved[index]!,
                                  builder: (context, isSaved, child) => InkWell(
                                    onTap: () {
                                      _isSaved[index]!.value = !isSaved;
                                    },
                                    child: Icon(
                                      Icons.bookmark,
                                      size: 22,
                                      color:
                                          isSaved ? Colors.blue : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
