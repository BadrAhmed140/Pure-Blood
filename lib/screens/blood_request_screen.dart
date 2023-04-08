import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/models/pureBlood_user_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../src/app_constants.dart';
import 'chat_details.dart';

class BloodRequestScreen extends StatefulWidget {
  const BloodRequestScreen({Key? key}) : super(key: key);

  @override
  State<BloodRequestScreen> createState() => _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<BloodRequestScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = PureBloodCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Requests'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('request')
            .where('uId', isNotEqualTo: uid)
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
                PureBloodUserModel userModel = PureBloodUserModel.fromJson(
                    snapshot.data.docs[index].data());
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
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) =>
                                      ChatDetails(model: userModel),
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
