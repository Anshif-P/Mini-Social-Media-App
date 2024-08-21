import 'package:flutter/material.dart';
import 'package:mini_social_media_app/widgets/comman/list_.dart';
import 'package:mini_social_media_app/widgets/home_widget/product_gridview_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: ProductGridViewWidget(
        productList: demoPosts.posts.value,
      ),
    )));
  }
}
