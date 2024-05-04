import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

Widget primaryButton(String title, VoidCallback onTap, bool isLoading,
    var context, Color buttonColor, Color textColor, Widget? image) {
  Size size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: size.width,
      height: size.height * 0.07,
      decoration: ShapeDecoration(
        color: buttonColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image!,
                sizeHor(5),
                Center(child: normalTextHeavy(title, textColor)),
              ],
            ),
    ),
  );
}

class ErrorSnackbar {
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: redColor,
        padding: const EdgeInsets.all(25),
        margin: EdgeInsets.all(8),
        behavior: SnackBarBehavior.floating,
        content: Text(text),
      ),
    );
  }
}

class SuccessSnackbar {
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: greenColor,
        padding: const EdgeInsets.all(25),
        margin: EdgeInsets.all(8),
        behavior: SnackBarBehavior.floating,
        content: Text(text),
      ),
    );
  }
}

class DialogGradientButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Gradient? color;
  final bool? isLoading;
  const DialogGradientButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: color ??
              const LinearGradient(
                  colors: [Color(0xff29844B), Color(0xff072C27)])),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: isLoading ?? false
              ? const CircularProgressIndicator(color: Colors.white)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
                    const SizedBox(width: 10.0),
                    Flexible(child: const Icon(Icons.arrow_forward)),
                  ],
                )),
    );
  }
}

class DialogWhiteButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const DialogWhiteButton(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(color: Color(0xff29844B))),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(color: Color(0xff29844B)),
              ),
              const SizedBox(width: 10.0),
              const Icon(
                Icons.arrow_forward,
                color: Color(0xff29844B),
              ),
            ],
          )),
    );
  }
}
