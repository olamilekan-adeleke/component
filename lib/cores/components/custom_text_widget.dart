import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/font_size.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    Key? key,
    this.fontSize = kfsMedium,
    this.textColor,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.justify,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.height,
    this.withOpacity,
  }) : super(key: key);

  const TextWidget.bold(
    this.text, {
    Key? key,
    this.fontSize = kfsMedium,
    this.textColor,
    this.textAlign = TextAlign.justify,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.height = 1,
    this.withOpacity,
  })  : fontWeight = FontWeight.w700,
        super(key: key);

  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? height;
  final double? withOpacity;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: fontSize,
        color: (textColor ?? Theme.of(context).textTheme.titleMedium!.color)!
            .withOpacity(withOpacity ?? 1.0),
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor:
            (textColor ?? Theme.of(context).textTheme.titleMedium!.color)!
                .withOpacity(withOpacity ?? 1.0),
        height: height,
      ),
      textAlign: textAlign,
      overflow: overflow,
      softWrap: true,
      maxLines: maxLines,
      textScaleFactor: 0.8,
    );
  }
}

class TwoSpanTextWidget extends StatelessWidget {
  const TwoSpanTextWidget(
    this.text,
    this.text2, {
    Key? key,
    this.fontSize = kfsMedium,
    this.fontSize2 = kfsMedium,
    this.textColor,
    this.textColor2,
    this.fontWeight = FontWeight.w400,
    this.fontWeight2 = FontWeight.w400,
    this.textAlign = TextAlign.justify,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.decoration2,
  }) : super(key: key);

  final String text;
  final String text2;
  final double? fontSize;
  final double? fontSize2;
  final Color? textColor;
  final Color? textColor2;
  final FontWeight? fontWeight;
  final FontWeight? fontWeight2;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final TextDecoration? decoration2;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: GoogleFonts.inter(
          fontSize: fontSize,
          color: (textColor ?? Theme.of(context).textTheme.titleMedium!.color),
          fontWeight: fontWeight,
          decoration: decoration,
        ),
        children: <InlineSpan>[
          TextSpan(
            text: text2,
            style: GoogleFonts.inter(
              fontSize: fontSize2,
              color:
                  textColor2 ?? Theme.of(context).textTheme.titleMedium!.color,
              fontWeight: fontWeight2,
              decoration: decoration2,
            ),
          )
        ],
      ),
    );
  }
}
