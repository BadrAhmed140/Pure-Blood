import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/components/edit_text_field.dart';
import 'package:pure_blood/screens/drawer_screen/my_profile.dart';

import '../../components/drop_down_button.dart';

class EditeProfile extends StatelessWidget {
  var cityControllerEdite = TextEditingController();
  var addressControllerEdite = TextEditingController();
  var phoneControllerEdite = TextEditingController();
  var nameControllerEdite = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    return BlocConsumer<PureBloodCubit, PureBloodState>(
      listener: (context, state) {
        // TODO: implement listener

      },
      builder: (context, state) {
        var cubit = PureBloodCubit.get(context);
        nameControllerEdite.text = cubit.userModel!.name.toString();
        cityControllerEdite.text = cubit.userModel!.city.toString();
        addressControllerEdite.text = cubit.userModel!.address.toString();
        phoneControllerEdite.text = cubit.userModel!.phoneNumber.toString();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text('Update Profile'),
              centerTitle: true,
              actions: <Widget>[
                TextButton(
                    onPressed: () async{


                      cubit.updateUser(
                          name: nameControllerEdite.text,
                          address: addressControllerEdite.text,
                          phone: phoneControllerEdite.text,
                          city: cityControllerEdite.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MyProfile(),
                      ));
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ))
              ]),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: device.padding.top, left: 15, right: 15),
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
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                         /*(state is SuccessGetImageState)
                         //     ? Container(
                                  child: Image.file(cubit!.profileImage!)*/

                             /* : Container(
                                  child: Text('no image'),
                                ),*/

                        CircleAvatar(
                        backgroundColor: Colors.red,
                          backgroundImage:
                          cubit.profileImage!=null?
                          FileImage(cubit!.profileImage!):
                          cubit.userModel!.imageUrl == null
                              ? AssetImage('assets/icons/myprofile.png') as ImageProvider
                              : NetworkImage(cubit.userModel!.imageUrl!,
                          ),
                        radius: 70,
                      ),
                          IconButton(
                              onPressed: () {
                               cubit.getimage();
                              },
                              icon: CircleAvatar(
                                radius: 20,
                                child: Icon(Icons.add_a_photo_outlined),
                                backgroundColor: Colors.grey,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: nameControllerEdite,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 5,
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
                            EditTextField(
                              Icon: Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40,
                              ),
                              controller: addressControllerEdite,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            EditTextField(
                              controller: phoneControllerEdite,
                              Icon: Icon(
                                Icons.phone,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            EditTextField(
                              controller: cityControllerEdite,
                              Icon: Icon(
                                Icons.flag,
                                color: Colors.red,
                                size: 40,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    ;
  }
}
