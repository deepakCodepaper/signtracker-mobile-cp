import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigNumbersStyle extends TextStyle {
  BigNumbersStyle({Color color = Colors.black})
      : super(
          fontWeight: FontWeight.bold,
          fontSize: 40,
          letterSpacing: Platform.isIOS ? 0.4 : 0,
          color: color,
        );
}

class TitleAndPriceStyle extends TextStyle {
  TitleAndPriceStyle({Color color = Colors.black})
      : super(
          fontWeight: FontWeight.bold,
          fontSize: 21,
          letterSpacing: Platform.isIOS ? 0.36 : 0,
          color: color,
        );
}

class SmallPricesStyle extends TextStyle {
  SmallPricesStyle({Color color = Colors.black})
      : super(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          letterSpacing: Platform.isIOS ? -0.41 : 0,
          color: color,
        );
}

class ProductNamesStyle extends TextStyle {
  ProductNamesStyle({Color color = Colors.black})
      : super(
          fontWeight: FontWeight.w600,
          fontSize: 17,
          letterSpacing: Platform.isIOS ? -0.41 : 0,
          color: color,
        );
}

class CatalogTitleStyle extends TextStyle {
  CatalogTitleStyle({Color color = Colors.black})
      : super(
          fontWeight: FontWeight.normal,
          fontSize: 17,
          letterSpacing: Platform.isIOS ? -0.41 : 0,
          color: color,
        );
}

class ButtonsStyle extends TextStyle {
  ButtonsStyle({Color color = Colors.black})
      : super(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          letterSpacing: Platform.isIOS ? -0.24 : 0,
          color: color,
        );
}

class NormalDescriptiveStyle extends TextStyle {
  NormalDescriptiveStyle({Color color = Colors.black})
      : super(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          letterSpacing: Platform.isIOS ? -0.24 : 0,
          color: color,
        );
}

class PuffTextStyle extends TextStyle {
  PuffTextStyle({Color color = Colors.black})
      : super(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          letterSpacing: Platform.isIOS ? -0.08 : 0,
          color: color,
        );
}

class NormalTextStyle extends TextStyle {
  NormalTextStyle({Color color = Colors.black})
      : super(
          fontWeight: FontWeight.normal,
          fontSize: 13,
          letterSpacing: Platform.isIOS ? -0.08 : 0,
          color: color,
        );
}

class BadgeTextStyle extends TextStyle {
  BadgeTextStyle({Color color = Colors.black})
      : super(
          fontWeight: FontWeight.w600,
          fontSize: 11,
          letterSpacing: Platform.isIOS ? 0.07 : 0,
          color: color,
        );
}

class MicroTextStyle extends TextStyle {
  MicroTextStyle({Color color = Colors.black})
      : super(
          fontWeight: FontWeight.normal,
          fontSize: 11,
          letterSpacing: Platform.isIOS ? 0.07 : 0,
          color: color,
        );
}
