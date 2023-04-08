import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pure_blood/screens/home%20_screen.dart';
import 'package:pure_blood/screens/splash_screen.dart';
import 'package:pure_blood/src/app_constants.dart';
import 'package:pure_blood/src/app_root.dart';
import 'package:pure_blood/src/cash_helper.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('hiiiiiiiiiiiiiiiiiiiiiiiiiii');
  uid = await CachHelper.getDate(key: 'uid');
  print('my uid issssssss $uid');
  Widget startWidget;
  if (uid != null) {
    startWidget = HomeScreen();
  } else {
    startWidget = SplashScreen();
  }
  runApp(AppRoot(StarWidget: startWidget));
}
