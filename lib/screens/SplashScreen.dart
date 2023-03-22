import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'Login&RegisterScreen/Login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Lottie.asset('assets/lottie/9103-entertainment.json'),
        splashIconSize: 250,
        backgroundColor: Theme.of(context).backgroundColor,
        pageTransitionType: PageTransitionType.fade,
        duration: 2500,
        nextScreen: const Login());
  }
}
