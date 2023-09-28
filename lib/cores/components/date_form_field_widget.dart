import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'components.dart';

class DateFormFieldWidget extends StatefulWidget {
  final String? title;
  final String hintText;
  final Function(DateTime data) onSelect;
  final DateTime? startDate;
  final DateTime? endDate;

  const DateFormFieldWidget({
    Key? key,
    this.title,
    required this.hintText,
    required this.onSelect,
    this.startDate,
    this.endDate,
  }) : super(key: key);

  @override
  State<DateFormFieldWidget> createState() => _DateFormFieldWidgetState();
}

class _DateFormFieldWidgetState extends State<DateFormFieldWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: widget.startDate ?? DateTime.now(),
          firstDate: widget.startDate ?? DateTime(1900),
          lastDate: widget.endDate ?? DateTime(2100),
        );

        if (picked != null) {
          String formattedDate = DateTimeHelper.formatDateYYMMDD(picked);
          controller.text = formattedDate;
          widget.onSelect(picked);
        }
      },
      child: AbsorbPointer(
        child: TextFieldWidget(
          textEditingController: controller,
          title: widget.title,
          hintText: widget.hintText,
          suffixWidget: Container(
            padding: EdgeInsets.only(left: w(5)),
            child: Icon(CupertinoIcons.calendar, size: sp(20)),
          ),
        ),
      ),
    );
  }
}
