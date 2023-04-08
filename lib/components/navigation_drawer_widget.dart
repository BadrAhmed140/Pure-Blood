import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/blocs/sign_up/sign_up_cubit.dart';
import 'package:pure_blood/components/drawer_list_title.dart';
import 'package:pure_blood/components/drop_down_button.dart';
import 'package:pure_blood/components/rounded_text_field.dart';
import 'package:pure_blood/models/blood_request_model.dart';
import 'package:pure_blood/screens/drawer_screen/blood_banks.dart';
import 'package:pure_blood/screens/drawer_screen/chats.dart';
import 'package:pure_blood/screens/drawer_screen/my_profile.dart';
import 'package:pure_blood/screens/drawer_screen/tips_screen.dart';
import 'package:pure_blood/src/app_constants.dart';

class NavigationDrawerWidget extends StatelessWidget {
  NavigationDrawerWidget({Key? key}) : super(key: key);
  final _formKeyBloodRequest = GlobalKey<FormState>();
  int? selectedDate;

  @override
  Widget build(BuildContext context) {
    var cubit = PureBloodCubit.get(context);
    var signUpCubit = SignUpCubit.get(context);
    return ClipRRect(
      borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
      child: Drawer(
        child: Container(
          color: Colors.red,
          child: ListView(
            children: [
              DrawerHeader(child: Image.asset('assets/images/logo.png')),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //home//////
                        DrawerListTitle(
                          text: 'Home',
                          text_icon: 'assets/icons/home.png',
                          on_tab: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        //my profile///////
                        DrawerListTitle(
                          text: 'My Profile',
                          text_icon: 'assets/icons/myprofile.png',
                          on_tab: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyProfile(),
                            ));
                          },
                        ),
                        ////doner blood///
                        DrawerListTitle(
                          text: 'Become Donor',
                          text_icon: 'assets/icons/add donor.png',
                          on_tab: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                      backgroundColor: Colors.transparent,
                                      insetPadding: const EdgeInsets.all(10),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: double.infinity,
                                            height: 250,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white),
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 40, 20, 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const ListTile(
                                                  title: Text(
                                                    "Are you sure you want to set your profile as a donor?",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  subtitle: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8.0),
                                                    child: Text(
                                                      'other users will be able to chat or call you at any time.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          cubit.userModel!
                                                              .isDonor = true;

                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(uid)
                                                              .set(cubit
                                                                  .userModel!
                                                                  .toMap())
                                                              .catchError(
                                                                  (error) {
                                                            log(error
                                                                .toString());
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'Confirm',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.green),
                                                        )),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                              top: -100,
                                              child: Image.asset(
                                                'assets/images/logo.png',
                                                width: 170,
                                                height: 150,
                                              ))
                                        ],
                                      ));
                                });
                          },
                        ),
                        //blood request/////////
                        DrawerListTitle(
                          text: 'Request Blood',
                          text_icon: 'assets/icons/add blood request.png',
                          on_tab: () async {
                            showDialog(
                              context: context,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );

                            final requestData = await FirebaseFirestore.instance
                                .collection('request')
                                .doc('${uid}0')
                                .get();
                            Navigator.pop(context);
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                      backgroundColor: Colors.transparent,
                                      insetPadding: const EdgeInsets.all(10),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: double.infinity,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3.5,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white),
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 40, 20, 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    requestData.exists
                                                        ? "You already have a blood request for you"
                                                        : "Is this Blood request for you?",
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                  subtitle: const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8.0),
                                                    child: Text(
                                                      'Press on another person if you want to request blood for someone else. You can only have one request for another person!',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          if (requestData
                                                              .exists) {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                            );
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'request')
                                                                .doc('${uid}0')
                                                                .delete();
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          } else {
                                                            cubit.userModel!
                                                                    .isDonor =
                                                                false;
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                            );
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'users')
                                                                .doc(uid)
                                                                .set(cubit
                                                                    .userModel!
                                                                    .toMap())
                                                                .catchError(
                                                                    (error) {
                                                              log(error
                                                                  .toString());
                                                            });

                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'request')
                                                                .doc('${uid}0')
                                                                .set(BloodRequestModel(
                                                                        cubit
                                                                            .userModel!
                                                                            .name,
                                                                        cubit
                                                                            .userModel!
                                                                            .birthday,
                                                                        cubit
                                                                            .userModel!
                                                                            .bloodType,
                                                                        cubit
                                                                            .userModel!
                                                                            .city,
                                                                        cubit
                                                                            .userModel!
                                                                            .address,
                                                                        cubit
                                                                            .userModel!
                                                                            .phoneNumber,
                                                                        cubit
                                                                            .userModel!
                                                                            .uId,
                                                                        cubit
                                                                            .userModel!
                                                                            .imageUrl)
                                                                    .toMap())
                                                                .catchError(
                                                                    (error) {
                                                              log(error
                                                                  .toString());
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        },
                                                        child: Text(
                                                          requestData.exists
                                                              ? "Cancel mine"
                                                              : 'Yes, for me',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: requestData
                                                                      .exists
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .green),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          showModalBottomSheet(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            backgroundColor:
                                                                Colors.yellow[
                                                                    700],
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 4.0,
                                                                    style: BorderStyle
                                                                        .solid),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                              ),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Form(
                                                                  key:
                                                                      _formKeyBloodRequest,
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const Expanded(
                                                                              child: Center(child: Text('Name'))),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child: RoundedTextField(
                                                                                validationString: 'Please enter your name',
                                                                                hintText: 'Name',
                                                                                inputType: TextInputType.name,
                                                                                controller: signUpCubit.nameBloodRequestController),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Expanded(
                                                                              child: Center(child: Text('Birthday'))),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child: RoundedTextField(
                                                                                readOnly: true,
                                                                                onTap: () {
                                                                                  showDatePicker(context: context, initialDate: DateTime(2000), firstDate: DateTime(1940), lastDate: DateTime(2005)).then((value) {
                                                                                    if (value != null) {
                                                                                      selectedDate = value.millisecondsSinceEpoch;
                                                                                      signUpCubit.birthBloodRequestController.text = DateFormat.yMMMEd().format(value);
                                                                                    }
                                                                                  });
                                                                                },
                                                                                validationString: 'Please enter your birthday',
                                                                                hintText: 'Birthday',
                                                                                inputType: TextInputType.datetime,
                                                                                controller: signUpCubit.birthBloodRequestController),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Expanded(
                                                                              child: Center(child: Text('Blood Type'))),
                                                                          Expanded(
                                                                              flex: 2,
                                                                              child: DropDownButton(
                                                                                onChanged: (newValue) {
                                                                                  signUpCubit.DropDownValueFun(newValue!);
                                                                                },
                                                                                items: signUpCubit.items,
                                                                                bloodTypeController: signUpCubit.bloodTypeController,
                                                                              )),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Expanded(
                                                                              child: Center(child: Text('City'))),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child: RoundedTextField(
                                                                                validationString: 'Please enter your city',
                                                                                hintText: 'City',
                                                                                inputType: TextInputType.text,
                                                                                controller: signUpCubit.cityBloodRequestController),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Expanded(
                                                                              child: Center(child: Text('Address'))),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child: RoundedTextField(
                                                                                validationString: 'Please enter your address',
                                                                                hintText: 'Address',
                                                                                inputType: TextInputType.streetAddress,
                                                                                controller: signUpCubit.addressBloodRequestController),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Expanded(
                                                                              child: Center(child: Text('Phone Number'))),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child: RoundedTextField(
                                                                                validationString: 'Please enter your phone',
                                                                                hintText: 'Phone Number',
                                                                                inputType: TextInputType.phone,
                                                                                controller: signUpCubit.phoneBloodRequestController),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      InkWell(
                                                                        child: Image.asset(
                                                                            'assets/images/ok.png'),
                                                                        onTap:
                                                                            () async {
                                                                          if (_formKeyBloodRequest
                                                                              .currentState!
                                                                              .validate()) {
                                                                            await FirebaseFirestore.instance.collection('request').doc('${uid}1').set(BloodRequestModel(signUpCubit.nameBloodRequestController.text, selectedDate, signUpCubit.bloodTypeController, signUpCubit.cityBloodRequestController.text, signUpCubit.addressBloodRequestController.text, signUpCubit.phoneBloodRequestController.text, cubit.userModel!.uId, cubit.userModel!.imageUrl).toMap()).catchError((error) {
                                                                              log(error.toString());
                                                                            });
                                                                            Navigator.pop(context);
                                                                          }
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          'Another Person',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .yellow[700]),
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top: -100,
                                              child: Image.asset(
                                                'assets/images/logo.png',
                                                width: 170,
                                                height: 150,
                                              ))
                                        ],
                                      ));
                                });
                          },
                        ),
                        //banks///
                        DrawerListTitle(
                          text: 'Banks',
                          text_icon: 'assets/icons/Bank.png',
                          on_tab: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BloodBanks(),
                            ));
                          },
                        ),
                        //chat////
                        DrawerListTitle(
                          text: 'Chat',
                          text_icon: 'assets/icons/chat.png',
                          on_tab: () async {
                            await cubit.chatUsers();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Chats()));
                          },
                        ),
                        //tips///
                        DrawerListTitle(
                          text: 'Tips',
                          text_icon: 'assets/icons/about.png',
                          on_tab: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TipsScreen(),
                                ));
                          },
                        ),
                        //setting///
                        DrawerListTitle(
                          text: 'Settings',
                          text_icon: 'assets/icons/Setting.png',
                          on_tab: () {},
                        ),
                        //about/////
                        DrawerListTitle(
                          text: 'About',
                          text_icon: 'assets/icons/about.png',
                          on_tab: () {},
                        ),
                        //sign out///////////////
                        DrawerListTitle(
                          text: 'Sign Out',
                          text_icon: 'assets/icons/logout.png',
                          on_tab: () {
                            PureBloodCubit.get(context).userModel = null;
                            signOut(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
