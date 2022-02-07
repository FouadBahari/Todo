import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color tealClr = Color(0xFF33d9b2);
const Color blueClr = Color(0xFF34ace0);
const Color orangeClr = Color(0xFFff5252);
const Color white = Colors.white;
const Color black = Colors.black;

const primaryClr = tealClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
      primaryColor: primaryClr,
      backgroundColor: white,
      brightness: Brightness.light);
  static final dark = ThemeData(
      primaryColor: darkGreyClr,
      backgroundColor: darkGreyClr,
      brightness: Brightness.dark);

  TextStyle get headingStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle get subHeadingStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle get titleStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextStyle get subTitleStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  TextStyle get hintStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Colors.grey[600],
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  TextStyle get bodyStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  TextStyle get body2Style {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.grey[200] : Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
