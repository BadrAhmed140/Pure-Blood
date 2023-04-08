import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pure_blood/blocs/sign_in/sign_in_cubit.dart';
import 'package:pure_blood/components/rounded_text_field.dart';
import 'package:pure_blood/screens/home%20_screen.dart';
import 'package:pure_blood/screens/sign_up_screen.dart';

import '../src/app_constants.dart';
import '../src/cash_helper.dart';

class SignInScreen extends StatelessWidget {
  final passController = TextEditingController();
  final emailController = TextEditingController();

  SignInScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SuccesSignInState) {
            print(state.uid);
            print('اهةوووةغتةخلكيؤلا');
            CachHelper.saveDate(key: 'uid', value: state.uid);
            uid = CachHelper.getDate(key: 'uid');

            print(state.uid);
            Fluttertoast.showToast(
                msg: "تم تسجيل الدخول",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
          } else if (state is ErrorSignInState) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          var cubit = SignInCubit.get(context);
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background_login.jpg'),
                    fit: BoxFit.cover),
              ),
              padding:
                  EdgeInsets.only(top: device.padding.top, left: 25, right: 25),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: device.size.width / 1.5,
                        ),

                        ///// form ///
                        Form(
                          key: _formKey,
                          child: Column(
                            ///// email////
                            children: [
                              RoundedTextField(
                                validationString: 'Please enter your Email',
                                hintText: 'Email',
                                inputType: TextInputType.emailAddress,
                                controller: cubit.emailController,
                                icon: Image.asset(
                                  'assets/images/user_name_icon.png',
                                ),
                              ),

                              ///////////
                              SizedBox(
                                height: 10,
                              ),
                              //////////
                              ////// password /////

                              RoundedTextField(
                                  validationString:
                                      'Please enter your password',
                                  hintText: 'Password',
                                  inputType: TextInputType.visiblePassword,
                                  icon: Image.asset(
                                    'assets/images/password_icon.png',
                                  ),
                                  obscureText: true,
                                  controller: cubit.passController),

                              ////// sign up & forgot password /////
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'forgot password',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => SignUpScreen(),
                                      ));
                                    },
                                    child: Text(
                                      'sign up',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        ////// sign in////
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                              cubit.userSignIn(
                                  email: cubit.emailController.text,
                                  password: cubit.passController.text);
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff484847))),
                            child: Text('sign in'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
