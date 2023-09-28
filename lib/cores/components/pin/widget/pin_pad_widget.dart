import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../utils/utils.dart';
import '../../components.dart';

class KeyPad extends StatelessWidget {
  static const double buttonSize = 60.0;
  final TextEditingController pinController;
  final bool showBioMetric;
  final VoidCallback? onBioMetricPressed;

  const KeyPad({
    Key? key,
    required this.pinController,
    this.showBioMetric = true,
    this.onBioMetricPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          verticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonWidget('1'),
              buttonWidget('2'),
              buttonWidget('3'),
            ],
          ),
          verticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonWidget('4'),
              buttonWidget('5'),
              buttonWidget('6'),
            ],
          ),
          verticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonWidget('7'),
              buttonWidget('8'),
              buttonWidget('9'),
            ],
          ),
          verticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBioMetric)
                iconButtonWidget(
                  context,
                  Icons.fingerprint,
                  () => onBioMetricPressed?.call(),
                )
              else
                const SizedBox(height: buttonSize, width: buttonSize),
              buttonWidget('0'),
              iconButtonWidget(
                context,
                CupertinoIcons.delete_left,
                () {
                  if (pinController.text.isNotEmpty) {
                    pinController.text = pinController.text
                        .substring(0, pinController.text.length - 1);
                  }
                  if (pinController.text.length > 5) {
                    pinController.text = pinController.text.substring(0, 3);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  buttonWidget(String buttonText) {
    return GestureDetector(
      onTap: () {
        if (pinController.text.length <= 3) {
          pinController.text = pinController.text + buttonText;
        }
      },
      child: SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Center(
            child: TextWidget(
              buttonText,
              fontWeight: FontWeight.w600,
              fontSize: sp(25),
            ),
          ),
        ),
      ),
    );
  }

  iconButtonWidget(BuildContext context, IconData icon, Function() function) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.1)
              : const Color(0xff272727).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(icon, size: sp(30)),
        ),
      ),
    );
  }
}
