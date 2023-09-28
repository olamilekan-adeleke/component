import 'package:flutter/material.dart';

import '../constants/color.dart';
import 'sizer_utils.dart';

class BottomSheetHelper {
  static Future<dynamic> show({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
  }) async {
    return await showModalBottomSheet(
      backgroundColor: kcGrey100.withOpacity(0.05),
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      isDismissible: isDismissible,
      builder: (BuildContext context) => SingleChildScrollView(
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(20)),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(sp(15)),
                topRight: Radius.circular(sp(15)),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
