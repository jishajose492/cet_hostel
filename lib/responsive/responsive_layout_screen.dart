import 'package:cet_hostel/providers/user_provider.dart';
import 'package:cet_hostel/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget WebScreenLayout;
  final Widget MobileScreenLayout;

  const ResponsiveLayout(
      {Key? key,
      required this.WebScreenLayout,
      required this.MobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    print("1");
    UserProvider _userProvider = Provider.of(context, listen: false);
    print("4");
    print(_userProvider);
    print("345");
    await _userProvider.refreshuser();
    print('2');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > WebScreenSize) {
          //web screen
          return widget.WebScreenLayout;
        }
        //mobile screen
        return widget.MobileScreenLayout;
      },
    );
  }
}
