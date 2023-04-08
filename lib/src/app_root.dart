import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/blocs/sign_up/sign_up_cubit.dart';

import 'app_constants.dart';

class AppRoot extends StatelessWidget {
  Widget StarWidget;

  AppRoot({required this.StarWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(create: (context) => PureBloodCubit()..getUser())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: redApp,
        ),
        title: 'Pure Blood',
        home: StarWidget,
      ),
    );
  }
}
