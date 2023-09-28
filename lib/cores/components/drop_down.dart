import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color.dart';
import '../utils/sizer_utils.dart';
import 'custom_text_widget.dart';

class DropDownWidget<T> extends StatelessWidget {
  const DropDownWidget({
    Key? key,
    required this.items,
    required this.title,
    this.value,
    this.onTap,
    this.hintText,
    this.fillColor,
  }) : super(key: key);

  final List<T> items;
  final String title;
  final String? hintText;
  final T? value;
  final Function(T val)? onTap;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(title, fontSize: sp(16), fontWeight: FontWeight.w600),
        verticalSpace(5),
        SizedBox(
          height: sp(55),
          child: DropdownButtonFormField<T>(
            isDense: true,
            borderRadius: BorderRadius.circular(sr(8.0)),
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down),
            style: GoogleFonts.inter(
              color: Theme.of(context).textTheme.titleMedium!.color,
              fontWeight: FontWeight.w600,
              fontSize: sp(16),
            ),
            items: items.map((T items) {
              return DropdownMenuItem(
                value: items,
                child: TextWidget(items.toString()),
              );
            }).toList(),
            onChanged: (T? newValue) {
              if (newValue == null && onTap == null) return;

              onTap!(newValue as T);
            },
            iconEnabledColor: kcPrimaryColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: context.isDarkMode
                  ? Colors.transparent
                  : const Color(0xFFF5F6F6),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.isDarkMode ? kcGrey400 : kcPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(sr(5.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.isDarkMode ? kcPrimaryColor : kcGrey400,
                ),
                borderRadius: BorderRadius.circular(sr(5.0)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.isDarkMode ? kcPrimaryColor : kcGrey400,
                ),
                borderRadius: BorderRadius.circular(sr(5.0)),
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                color: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .color!
                    .withOpacity(0.5),
                fontWeight: FontWeight.w300,
                fontSize: sp(13),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
