import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// const splashBackground = Color(0xff0E0915);
final splashBackground = Color(0xff0447B9);
const lightBackground = Color(0xffF1EDF7);
// const lightBackground = Colors.white;
const blackColor = Color(0xff000000);
const primaryColor = Color(0xff0447B9);
const greenColor = Color(0xff00C59B);
const KPurpleColor = Color(0xff9270C2);
const redColor = Color(0xffFF2323);
const primaryLogoColor = Color(0xff0447B9);
const secondaryLogoColor = Color(0xffFF9839);

Widget sizeVer(double size) {
  return SizedBox(height: size);
}

Widget sizeHor(double size) {
  return SizedBox(width: size);
}

Widget backButton(context) {
  return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(Icons.arrow_back_ios));
}

Widget splashLogoText(String text, Color color) {
  return Text(text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: 52,
      ));
}

Widget tinyCaptionText(String text, Color color) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w400),
  );
}

Widget headerText(String text, Color color,
    {TextAlign textAlign = TextAlign.center}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: 25,
    ),
  );
}

Widget subHeaderText(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
  );
}

Widget normalText(String text, Color color,
    {TextAlign textAlign = TextAlign.center}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: 3,
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color,
      fontWeight: FontWeight.w400,
      fontSize: 17,
    ),
  );
}

Widget normalTextHeavy(String text, Color color) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: 17,
    ),
  );
}

Widget skipText(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: primaryColor,
      fontSize: 13.74,
      fontFamily: 'Inter',
      height: 0,
    ),
  );
}
