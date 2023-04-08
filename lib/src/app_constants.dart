import 'package:flutter/material.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/screens/sign_in_screen.dart';

import 'cash_helper.dart';

///////  colors/////////
Color redApp = const Color(0xfff9372d);
String? uid;


void signOut(context)
{
  CachHelper.removeDate(key: 'uid').then((value) {
uid=null;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ));

  });

}