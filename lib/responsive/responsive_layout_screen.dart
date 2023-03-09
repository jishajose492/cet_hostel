import 'package:cet_hostel/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget WebScreenLayout;
  final Widget MobileScreenLayout;

  const ResponsiveLayout(
      {Key? key,
      required this.WebScreenLayout,
      required this.MobileScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > WebScreenSize) {
          //web screen
          return WebScreenLayout;
        }
        //mobile screen
        return MobileScreenLayout;
      },
    );
  }
}
