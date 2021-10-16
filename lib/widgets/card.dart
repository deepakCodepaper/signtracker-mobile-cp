import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CardButtons extends StatelessWidget {
  const CardButtons({
    this.backgroundGradient,
    this.backgroundColor = Colors.white,
    this.imagePath,
    this.text,
    this.onPressed,
  });

  final LinearGradient backgroundGradient;
  final Color backgroundColor;
  final String imagePath;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: backgroundGradient,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(imagePath, allowDrawingOutsideViewBox: true),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle: textTheme.bodyText1.copyWith(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
