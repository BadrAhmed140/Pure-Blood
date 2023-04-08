import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../chat_details.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PureBloodCubit, PureBloodState>(

      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=PureBloodCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Chats'),
          ),
          body:ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(8),
            itemCount: cubit.usersChat.length,
            itemBuilder: (context, index){
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(

        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            backgroundImage: cubit.usersChat[index].imageUrl==
                null
                ? AssetImage('assets/icons/myprofile.png')
            as ImageProvider
                : NetworkImage(cubit.usersChat[index].imageUrl.toString()),
            radius: 35,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            cubit.usersChat[index].name.toString()
            ,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              launchUrl(Uri.parse(
                  'tel:${cubit.usersChat[index].phoneNumber}'));
            },
            child: Icon(
              Icons.call,
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              //todo: go to chat screen
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    ChatDetails(model:cubit.usersChat[index]),
              ));
            },
            child: Image.asset(
              'assets/icons/chat.png',
              color: Colors.red,
              width: 20,
            ),
          )
        ],
      ),
    ),
  );
            },
          )
        );
      },
    );
  }
}
