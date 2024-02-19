import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';

// colors
const Color kMikadoYellow = Color(0xFFffc300);

// text style
final TextStyle headlineSmall =
    GoogleFonts.roboto(fontSize: 23, fontWeight: FontWeight.w300, color: Colors.deepPurple);
final TextStyle appTitleLarge =
GoogleFonts.roboto(fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: Colors.deepPurple);
final TextStyle titleLarge =
    GoogleFonts.roboto(fontSize: 19, fontWeight: FontWeight.w300, letterSpacing: 0.15, color: Colors.deepPurple);
final TextStyle titleMedium =
    GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w300, letterSpacing: 0.15, color: Colors.deepPurple);
final TextStyle bodyMedium =
    GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w300, letterSpacing: 0.25, color: Colors.deepPurple);

// text theme
final textTheme = TextTheme(
  headlineSmall: headlineSmall,
  titleLarge: titleLarge,
  titleMedium: titleMedium,
  bodyMedium: bodyMedium,
);

