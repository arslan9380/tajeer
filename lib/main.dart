import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tajeer/view/ui/splash/splash_view.dart';

import 'app/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

///-------------------------------------------------
///   MyWhatsapp +923039380800
///   My email : mian.arslan9380@gmail.com
///   Send me your email so i can add you on firebase
///   -----------------------------------------------

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "TAJEER",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.adamina().fontFamily,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xff152e71),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
          ),
          primaryColorDark: Color(0xfffdd900)),
      home: SplashView(),
    );
  }
}
