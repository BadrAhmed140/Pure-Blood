import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pure_blood/screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double logoScale = 0;
  double loading_turns = 0;
  bool loading_visibility = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 600), () {
      setState(() {
        logoScale = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AnimatedScale(
                onEnd: () {
                  setState(() {
                    loading_visibility = true;
                  });
                  Timer(Duration(milliseconds: 3), () {
                    setState(() {
                      loading_turns = 3;
                    });
                  });
                },
                duration: Duration(seconds: 1),
                scale: logoScale,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width / 1.5,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: Visibility(
                visible: loading_visibility,
                child: AnimatedRotation(
                  onEnd: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      )),
                  duration: Duration(seconds: 2),
                  turns: loading_turns,
                  child: Image.asset(
                    'assets/images/progress_bar.png',
                    width: MediaQuery.of(context).size.width / 7,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
