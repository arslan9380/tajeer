import 'package:event_app/view/ui/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "What's the move",
      theme: ThemeData(
          primarySwatch: Colors.brown,
          fontFamily: GoogleFonts.abrilFatface().fontFamily,
          primaryColor: Color(0xffddbd69),
          primaryColorDark: Color(0xff785d2e)),
      home: SplashView(),
    );
  }
}
