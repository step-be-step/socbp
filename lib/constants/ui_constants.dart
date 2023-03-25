import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socbp/constants/constants.dart';
import 'package:socbp/features/explore/view/explore_view.dart';
import 'package:socbp/features/post/widgets/post_list.dart';
import 'package:socbp/theme/pallete.dart';

class UICosntants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.logo,
        color: Pallete.orangeColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> bottomTabBarPages = [
    PostList(),
    ExploreView(),
    Text('Notification'),
  ];
}
