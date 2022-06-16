import 'package:desafio_eduq/theme/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StylesTheme {
  static final TextStyle h1 =
      GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w900);

  static final TextStyle h2 =
      GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700);
  static final TextStyle bodyText =
      GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400);

  static final TextStyle thematicFont = TextStyle(
    fontFamily: 'rick_morty_font',
    fontWeight: FontWeight.w500,
    fontSize: 22,
  );
}
