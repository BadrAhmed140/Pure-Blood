import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pure_blood/blocs/sign_up/sign_up_cubit.dart';
import 'package:pure_blood/components/drop_down_button.dart';
import 'package:pure_blood/components/rounded_text_field.dart';
import 'package:pure_blood/screens/home%20_screen.dart';

import '../src/app_constants.dart';
import '../src/cash_helper.dart';
class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final _formKey_sign_up = GlobalKey<FormState>();
  int? selectedDate;

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SuccesCreateUserState) {
          CachHelper.saveDate(key: 'uid', value: state.uid);
          uid = CachHelper.getDate(key: 'uid');

          Fluttertoast.showToast(
              msg: "تم الدخول",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        } else if (state is ErrorCreateUserState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
      // TODO: implement listener
      ,
      builder: (context, state) {
        var cubit = SignUpCubit.get(context);
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_signup.jpg'),
                  fit: BoxFit.cover),
            ),
            padding:
                EdgeInsets.only(top: device.padding.top, left: 10, right: 10),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                width: 4.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Form(
                            key: _formKey_sign_up,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Center(child: Text('Name'))),
                                    Expanded(
                                      flex: 2,
                                      child: RoundedTextField(
                                          validationString:
                                              'Please enter your name',
                                          hintText: 'Name',
                                          inputType: TextInputType.name,
                                          controller: cubit.nameController),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Center(child: Text('Email'))),
                                    Expanded(
                                      flex: 2,
                                      child: RoundedTextField(
                                          validationString:
                                              'Please enter your email',
                                          hintText: 'Email',
                                          inputType: TextInputType.emailAddress,
                                          controller: cubit.emailController),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Center(child: Text('Password'))),
                                    Expanded(
                                      flex: 2,
                                      child: RoundedTextField(
                                          validationString:
                                              'Please enter your password',
                                          hintText: 'Password',
                                          inputType:
                                              TextInputType.visiblePassword,
                                          controller: cubit.passController),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Center(child: Text('Birthday'))),
                                    Expanded(
                                      flex: 2,
                                      child: RoundedTextField(
                                          readOnly: true,
                                          onTap: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime(2000),
                                                    firstDate: DateTime(1940),
                                                    lastDate: DateTime(2005))
                                                .then((value) {
                                              if (value != null) {
                                                selectedDate = value
                                                    .millisecondsSinceEpoch;
                                                if (selectedDate != null) {
                                                  cubit.birthController
                                                      .text = DateFormat
                                                          .yMMMEd()
                                                      .format(DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              selectedDate!));
                                                }
                                              }
                                            });
                                          },
                                          validationString:
                                              'Please enter your birthday',
                                          hintText: 'Birthday',
                                          inputType: TextInputType.datetime,
                                          controller: cubit.birthController),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child:
                                            Center(child: Text('Blood Type'))),
                                    Expanded(
                                        flex: 2,
                                        child: DropDownButton(
                                          onChanged: (newValue) {
                                            cubit.DropDownValueFun(newValue!);
                                          },
                                          items: cubit.items,
                                          bloodTypeController:
                                              cubit.bloodTypeController,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Center(child: Text('City'))),
                                    Expanded(
                                      flex: 2,
                                      child: RoundedTextField(
                                          validationString:
                                              'Please enter your city',
                                          hintText: 'City',
                                          inputType: TextInputType.text,
                                          controller: cubit.cityController),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Center(child: Text('Address'))),
                                    Expanded(
                                      flex: 2,
                                      child: RoundedTextField(
                                          validationString:
                                              'Please enter your address',
                                          hintText: 'Address',
                                          inputType:
                                              TextInputType.streetAddress,
                                          controller: cubit.addressController),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                            child: Text('Phone Number'))),
                                    Expanded(
                                      flex: 2,
                                      child: RoundedTextField(
                                          validationString:
                                              'Please enter your phone',
                                          hintText: 'Phone Number',
                                          inputType: TextInputType.phone,
                                          controller: cubit.phoneController),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  child: Image.asset('assets/images/ok.png'),
                                  onTap: () {
                                    if (_formKey_sign_up.currentState!
                                        .validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                      print(cubit.nameController);
                                      print(cubit.emailController);
                                      print(cubit.passController);
                                      print(cubit.bloodTypeController);
                                      print(cubit.birthController);
                                      print(selectedDate);
                                      print(cubit.cityController);
                                      print(cubit.addressController);
                                      print(cubit.phoneController);
                                      cubit.userSignUp(
                                          name: cubit.nameController.text,
                                          email: cubit.emailController.text,
                                          password: cubit.passController.text,
                                          birthday: selectedDate!,
                                          bloodType: cubit.bloodTypeController,
                                          city: cubit.cityController.text,
                                          address: cubit.addressController.text,
                                          phoneNumber:
                                              cubit.phoneController.text);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          'assets/images/logo.png',
                          width: device.size.width / 2,
                        ),
                      ],
                    ),
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
