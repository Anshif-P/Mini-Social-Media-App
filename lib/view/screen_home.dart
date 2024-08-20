import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media_app/widgets/comman/list_.dart';
import 'package:mini_social_media_app/widgets/home_widget/product_gridview_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ProductGridViewWidget(
      productList: demoPosts,
    )));
  }
}
