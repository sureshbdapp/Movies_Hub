import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pixeltrue/screens/LoginButtonScreen.dart';

import '../utils/Constant.dart';
import 'Dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this, // Pass `this` as the vsync parameter
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).push(createRoute(LoginButtonScreen()));
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            Center(child: Lottie.asset('assets/animation/bubble.json')),
            Center(
              child: SizedBox(
                height: 50,
                width: 140,
                child: ScaleTransition(
                    scale: _animation,
                    child: const Image(
                        image: AssetImage('assets/images/neatflix_name.png'))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
