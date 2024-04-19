import 'package:flutter/material.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/utilities/colors.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedSplashScreen(
      duration: 1000,
      splashIconSize: size.height,
      splash: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.2,
            colors: [canvas, background],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'splash',
              child: Image.asset('assets/images/logo.png', width: size.width ,height: size.height * 0.4),
            ),
            SpinKitFadingCircle(
              color: Theme.of(context).primaryColor,
              size: size.height * 0.12,
            ),
          ],
        ),
      ),
      nextScreen: const LoginScreen(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}