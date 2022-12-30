import 'package:flutter/material.dart';

import 'app_color.dart';

class AppBackground extends StatefulWidget {
  const AppBackground({Key? key}) : super(key: key);

  @override
  State<AppBackground> createState() => _AppBackgroundState();
}

class _AppBackgroundState extends State<AppBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColor.darkBlue, AppColor.midBlue]),
      ),
    );
  }
}
