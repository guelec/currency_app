import 'package:currency_app/models/network.dart';
import 'package:currency_app/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash_Screen extends StatefulWidget {
  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  void initState() {
    super.initState();
    getData();      // In here we fetch data before launching main screen
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 2,
      backgroundColor: Colors.black45,
      loaderColor: Colors.deepPurple,
      navigateAfterSeconds: HomePage(),
      image: new Image.asset("assets/icons/splash.png"),
      photoSize: 100,
    );
  }
}
