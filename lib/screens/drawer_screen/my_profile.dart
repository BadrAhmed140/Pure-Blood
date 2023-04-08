import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/screens/drawer_screen/edit_profile.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    return BlocConsumer<PureBloodCubit, PureBloodState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BlocConsumer<PureBloodCubit, PureBloodState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = PureBloodCubit.get(context);

            return Scaffold(

                backgroundColor: Colors.white,
                appBar: AppBar(
                    title: Text('My Profile'),
                    centerTitle: true,
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => EditeProfile(),
                          ));
                        },
                      ),
                    ]),
                body: ConditionalBuilder(
                    condition: state is! LoadingGetUserState &&state is!LoadingUpdateUserState,
                    builder: (context) => SingleChildScrollView(
                          child: Center(
                            child: Container(
                              color: Colors.white,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: device.padding.top,
                                    left: 15,
                                    right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/logo2.png',
                                      height: 80,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      backgroundImage:
                                      cubit.userModel!.imageUrl== null
                                          ? AssetImage('assets/icons/myprofile.png') as ImageProvider
                                          : NetworkImage(cubit.userModel!.imageUrl!,),
                                      radius: 70,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      cubit.userModel!.name.toString(),
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/icons/blood tube.png',
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          cubit.userModel!.bloodType.toString(),
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      color: Color(0xff484847),
                                      height: 5,
                                      width: double.infinity,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.red,
                                                size: 40,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    cubit.userModel!.address
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        color: Colors.red)),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                color: Colors.red,
                                                size: 40,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  cubit.userModel!.phoneNumber
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.red)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.flag,
                                                color: Colors.red,
                                                size: 40,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  cubit.userModel!.city
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.red)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.email,
                                                color: Colors.red,
                                                size: 40,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  cubit.userModel!.email
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.red)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator())));
          },
        );
      },
    );
  }
}
