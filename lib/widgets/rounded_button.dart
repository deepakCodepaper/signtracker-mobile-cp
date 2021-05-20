import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    @required this.onPressed,
    this.borderColor,
    this.textColor,
    this.color,
    this.text,
    this.textSize = 14.0,
    this.radius = 30.0,
    this.height = 40.0,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(1.0),
    this.elevation = 5.0,
    this.leading,
    this.trailing,
    this.fontWeight,
    this.borderWidth = 1.0,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double radius;
  final double textSize;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final Widget leading;
  final Widget trailing;
  final FontWeight fontWeight;
  final double borderWidth;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: width,
        height: height,
        child: RaisedButton(
          elevation: elevation,
          onPressed: onPressed,
          child: Row(
            children: [
              if (leading != null) ...[
                leading,
                SizedBox(width: 40),
              ],
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.montserrat(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: textAlign,
                ),
              ),
              if (trailing != null) ...[SizedBox(width: 40), trailing],
            ],
          ),
          shape: RoundedRectangleBorder(
            side: borderColor == null
                ? BorderSide.none
                : BorderSide(
                    color: borderColor,
                    width: borderWidth,
                  ),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          color: color,
        ),
      ),
    );
  }
}
