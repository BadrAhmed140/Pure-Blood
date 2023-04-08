import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/blocs/pure_blood_cubit/pure_blood_cubit.dart';
import 'package:pure_blood/models/chat_model.dart';
import 'package:pure_blood/models/pureBlood_user_model.dart';

class ChatDetails extends StatefulWidget {
  PureBloodUserModel model;

  ChatDetails({required this.model});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}
class _ChatDetailsState extends State<ChatDetails> {
  String? message;

  var messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var cubit = PureBloodCubit.get(context);
    return Builder(builder: (context) {
           // PureBloodCubit.get(context).getMessages(receiverId: model.uId!);
      return BlocConsumer<PureBloodCubit, PureBloodState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.model.imageUrl!),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(widget.model.name!)
                ],
              ),
            ),
            body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(cubit.userModel!.uId)
                  .collection('chats')
                  .doc(widget.model.uId)
                  .collection('messages')
                  .orderBy('dateTime')
                  .snapshots()
                ,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return Text('error');
                }
         if(snapshot.hasData){
           return Padding(
           padding: const EdgeInsets.all(20.0),
           child: Column(
             children: [
               Expanded(
                 child: ListView.separated(
                     reverse: true,
                       controller: scrollController,
                     itemBuilder: (context, index) {
                       ChatModel message =ChatModel.fromJson(snapshot.data.docs[index].data());
                       if (cubit.userModel!.uId == message.senderId)
                         return builedMyMessage(message);
                       return builedMessage(message);
                     },
                     separatorBuilder: (context, index) =>
                         SizedBox(height: 15),
                     itemCount: snapshot.data.docs.length),
               ),
               Container(
                 decoration: BoxDecoration(
                     border: Border.all(color: Colors.grey, width: 1.0),
                     borderRadius: BorderRadius.circular(15.0)),
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                 child: Padding(
                   padding: const EdgeInsets.only(left: 10),
                   child: Row(
                     children: [
                       Expanded(
                         child: TextFormField(
                           decoration: InputDecoration(
                               border: InputBorder.none,
                               hintText:
                               'type your massage .............'),
                           controller: messageController,
                         ),
                       ),
                       Container(
                         height: 50.0,
                         color: Colors.red,
                         child: MaterialButton(
                           onPressed: () {
                             if (messageController.text != '') {
                               cubit.sendMessage(
                                   receiverId: widget.model.uId!,
                                   dateTime: DateTime.now().toString(),
                                   text: messageController.text);
                               scrollController.animateTo(
                                   scrollController
                                       .position.maxScrollExtent,
                                   duration: Duration(milliseconds: 300),
                                   curve: Curves.bounceOut);
                               messageController.clear();
                             }
                           },
                           minWidth: 1.0,
                           child: Icon(
                             Icons.send,
                             size: 16.0,
                             color: Colors.white,
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
               )
             ],
           ),
         );
         }
                return Center(child: CircularProgressIndicator());
              }
            ),
          );
        },
      );
    });
  }

  Widget builedMessage(ChatModel chatModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0))),
            child: Text(chatModel.text!)),
      );

  Widget builedMyMessage(ChatModel chatModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0))),
            child: Text(chatModel.text!)),
      );
}
