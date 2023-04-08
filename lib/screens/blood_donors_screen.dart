import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/models/pureBlood_user_model.dart';
import 'package:pure_blood/models/user_model.dart';
import 'package:pure_blood/screens/chat_details.dart';
import 'package:url_launcher/url_launcher.dart';

import '../src/app_constants.dart';

class BloodDonorsScreen extends StatefulWidget {
  const BloodDonorsScreen({Key? key}) : super(key: key);

  @override
  State<BloodDonorsScreen> createState() => _BloodDonorsScreenState();
}

class _BloodDonorsScreenState extends State<BloodDonorsScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = PureBloodCubit.get(context);

cubit.userModel.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donors'),
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 40),
            child: Container(
              color: cubit.userModel!.isDonor ? Colors.green : Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    cubit.userModel!.isDonor
                        ? 'Your current state is Donor'
                        : 'Add yourself as a Donor',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () async {
                        cubit.userModel!.isDonor = !cubit.userModel!.isDonor;
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .update({'isDonor': cubit.userModel!.isDonor});
                        setState(() {});
                      },
                      child: Text(
                          cubit.userModel!.isDonor
                              ? 'Change'
                              : "Become A Donor",
                          style: TextStyle(
                              color: cubit.userModel!.isDonor
                                  ? Colors.black
                                  : Colors.green,
                              fontWeight: FontWeight.bold)))
                ],
              ),
            )),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uId', isNotEqualTo:uid)
            .where('isDonor', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text('error');
          }
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(8),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
           PureBloodUserModel user =   PureBloodUserModel.fromJson(snapshot.data.docs[index].data());
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage: snapshot.data.docs[index]
                                              .data()['imageUrl'] ==
                                          null
                                      ? AssetImage('assets/icons/myprofile.png')
                                          as ImageProvider
                                      : NetworkImage(snapshot.data.docs[index]
                                          .data()['imageUrl']),
                                  radius: 35,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data.docs[index].data()['name']}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                            'assets/icons/blood tube.png',
                                            width: 25),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${snapshot.data.docs[index].data()['bloodType']}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.flag_circle,
                                  size: 25,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  '${snapshot.data.docs[index].data()['city']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.home,
                                  size: 25,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  '${snapshot.data.docs[index].data()['address']}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ))
                              ],
                            ),
                          ],
                        )),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                launchUrl(Uri.parse(
                                    'tel:${snapshot.data.docs[index].data()['phoneNumber']}'));
                              },
                              child: Icon(
                                Icons.call,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                //todo: go to chat screen
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => ChatDetails(model: user),
                                ));
                              },
                              child: Image.asset(
                                'assets/icons/chat.png',
                                color: Colors.red,
                                width: 20,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );

                // Text('${snapshot.data.docs[index].data()['name']}');
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
