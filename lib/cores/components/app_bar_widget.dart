import 'package:flutter/material.dart';

import '../navigator/app_router.dart';
import '../utils/sizer_utils.dart';
import 'custom_text_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
    this.title, {
    Key? key,
    this.showBackButton = true,
    this.centerText = true,
    this.trilling,
  }) : super(key: key);

  final String title;
  final bool showBackButton;
  final bool centerText;
  final Widget? trilling;

  @override
  Widget build(BuildContext context) {
    if (centerText == false) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextWidget(title, fontSize: sp(18), fontWeight: FontWeight.w700),
          trilling ?? SizedBox(height: sp(20), width: sp(50)),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (showBackButton)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: AppRouter.instance.goBack,
            child: Container(
              // color: Colors.red,
              transform: Matrix4.translationValues(-20, 0, 0),
              padding: EdgeInsets.all(w(20)),
              child: Center(child: Icon(Icons.arrow_back_ios, size: sp(20))),
            ),
          )
        else
          SizedBox(height: sp(20), width: sp(40)),
        TextWidget(title, fontSize: sp(18), fontWeight: FontWeight.w700),
        trilling ?? SizedBox(height: sp(20), width: sp(50)),
      ],
    );
  }
}
