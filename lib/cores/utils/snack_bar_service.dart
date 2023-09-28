// import 'package:flash/flash.dart';
// import 'package:flutter/material.dart';

// import '../components/custom_text_widget.dart';
// import '../constants/constants.dart';

// class SnackBarService {
//   static void showErrorSnackBar({
//     required BuildContext context,
//     required String message,
//     Duration duration = const Duration(milliseconds: 2000),
//   }) {
//     showFlash(
//       context: context,
//       duration: duration,
//       builder: (context, controller) {
//         return Flash(
//           margin: const EdgeInsets.symmetric(horizontal: kGlobalPadding),
//           controller: controller,
//           backgroundColor: Colors.white,
//           brightness: Brightness.light,
//           boxShadows: const [BoxShadow(blurRadius: 4)],
//           barrierBlur: 3.0,
//           barrierColor: Colors.black38,
//           barrierDismissible: true,
//           behavior: FlashBehavior.floating,
//           position: FlashPosition.top,
//           horizontalDismissDirection: HorizontalDismissDirection.horizontal,
//           child: FlashBar(
//             shouldIconPulse: false,
//             indicatorColor: kcErrorColor,
//             icon: const Icon(Icons.error, color: kcErrorColor),
//             content: TextWidget(
//               message,
//               textAlign: TextAlign.left,
//               textColor: kcPrimaryColor,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   static void showSuccessSnackBar({
//     required BuildContext context,
//     required String message,
//     Duration duration = const Duration(milliseconds: 2000),
//   }) {
//     showFlash(
//       context: context,
//       duration: duration,
//       builder: (context, controller) {
//         return Flash(
//           margin: const EdgeInsets.symmetric(horizontal: kGlobalPadding),
//           controller: controller,
//           backgroundColor: Colors.white,
//           brightness: Brightness.light,
//           boxShadows: const [BoxShadow(blurRadius: 4)],
//           barrierBlur: 3.0,
//           barrierColor: Colors.black38,
//           barrierDismissible: true,
//           behavior: FlashBehavior.floating,
//           position: FlashPosition.top,
//           horizontalDismissDirection: HorizontalDismissDirection.horizontal,
//           child: FlashBar(
//             shouldIconPulse: false,
//             indicatorColor: kcSuccessColor,
//             icon: const Icon(Icons.check_circle, color: kcSuccessColor),
//             content: TextWidget(
//               message,
//               textAlign: TextAlign.left,
//               textColor: kcPrimaryColor,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   static void showWarningSnackBar({
//     required BuildContext context,
//     required String message,
//     Duration duration = const Duration(milliseconds: 1500),
//   }) {
//     showFlash(
//       context: context,
//       duration: duration,
//       builder: (context, controller) {
//         return Flash(
//           margin: const EdgeInsets.symmetric(horizontal: kGlobalPadding),
//           controller: controller,
//           backgroundColor: Colors.white,
//           brightness: Brightness.light,
//           boxShadows: const [BoxShadow(blurRadius: 4)],
//           barrierBlur: 3.0,
//           barrierColor: Colors.black38,
//           barrierDismissible: true,
//           behavior: FlashBehavior.floating,
//           position: FlashPosition.top,
//           horizontalDismissDirection: HorizontalDismissDirection.horizontal,
//           child: FlashBar(
//             shouldIconPulse: false,
//             indicatorColor: kcGrey400,
//             icon: const Icon(Icons.lightbulb, color: kcGrey400),
//             content: TextWidget(
//               message,
//               textAlign: TextAlign.left,
//               textColor: kcPrimaryColor,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
