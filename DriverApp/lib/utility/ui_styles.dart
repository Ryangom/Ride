import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle kHeadLine1({
  Color color = Colors.black,
  fontSize = 24.0,
  FontWeight fontWeight = FontWeight.bold,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

TextStyle kTextStyle2 = GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

TextStyle kTextStyle3 = GoogleFonts.poppins(
  fontSize: 16,
  color: Color.fromARGB(255, 240, 240, 240),
);
