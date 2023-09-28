import 'package:flutter/services.dart';

class ClipBoardHelper {
  static Future<String?> getClipBoardData() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }

  static Future<void> copyToClipBoard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
