import 'dart:developer';
import 'dart:ffi';


import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pure_blood/models/chat_model.dart';
import 'package:pure_blood/models/pureBlood_user_model.dart';
import 'package:pure_blood/models/user_model.dart';
import 'package:pure_blood/src/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import '../../src/cash_helper.dart';

part 'pure_blood_state.dart';

class PureBloodCubit extends Cubit<PureBloodState> {
  PureBloodCubit() : super(PureBloodInitial());

  static PureBloodCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
List<PureBloodUserModel> usersChat = [] ;


  Future<void> chatUsers() async {
    usersChat =[];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs)  {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(doc.id)
            .get()
            .then((value) {
          print('chat user is : ' + value.data().toString());
          PureBloodUserModel userModelChat = PureBloodUserModel.fromJson(value.data()!);
          usersChat.add(userModelChat);
        }).catchError((error) {
          print(error);
        });
      }
    }).catchError((error) {
      print(error);
    });
    log('iam inside chats methods ${usersChat.length}');

  }

//get user
  Future<void> getUser() async {
    emit(LoadingGetUserState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      print(value.data().toString());

      userModel = UserModel.fromJson(value.data()!);
      emit(SuccesGetUserState());
//userModel=UserModel.fromJson(value.data());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetUserState(error.toString()));
    });
  }

  var picker = ImagePicker();
  File? profileImage;

// post image
  Future<void> getimage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SuccessGetImageState());
    } else {
      print('No image selected');
      emit(ErrorGetImageState());
    }
  }

  //upload image
  Future<void> uploadImage() async {
    await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((p0) => p0.ref.getDownloadURL().then((value) async {
              userModel!.imageUrl = value;
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .set(userModel!.toMap())
                  .catchError((error) {
                log(error.toString());
              });
            }));
  }

//update user
  Future<void> updateUser({
    required String name,
    required String address,
    required String phone,
    required String city,
  }) async {
    emit(LoadingUpdateUserState());
    if (profileImage != null) {
      uploadImage();
      UserModel model = UserModel(
          name: name,
          address: address,
          phoneNumber: phone,
          city: city,
          bloodType: userModel!.bloodType,
          birthday: userModel!.birthday,
          password: userModel!.password,
          email: userModel!.email,
          uId: userModel!.uId,
          imageUrl: userModel!.imageUrl);
      print(userModel!.uId);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .update(model.toMap())
          .then((value) {
        emit(SuccessUpdateUserState());
        getUser();
      }).catchError((error) {
        emit(ErrorUpdateUserState(error));
      });
    } else {
      UserModel model = UserModel(
          name: name,
          address: address,
          phoneNumber: phone,
          city: city,
          bloodType: userModel!.bloodType,
          birthday: userModel!.birthday,
          password: userModel!.password,
          email: userModel!.email,
          uId: userModel!.uId,
          imageUrl: userModel!.imageUrl);
      print(userModel!.uId);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .update(model.toMap())
          .then((value) {
        emit(SuccessUpdateUserState());
        getUser();
      }).catchError((error) {
        emit(ErrorUpdateUserState(error));
      });
    }
  }

  //chat

  void sendMessage(
      {required String receiverId,
      required String dateTime,
      required String text
      }) {
    ChatModel model = ChatModel(
        text: text,
        senderId: userModel!.uId,
        receiverId: receiverId,
        dateTime: dateTime);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError((error) {
      emit(ErrorSendMessageState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError((error) {
      emit(ErrorSendMessageState());
    });
  }

  //List<ChatModel> messages = [];

  /*void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatModel.fromJson(element.data()));
      });

      emit(SuccessGetMessageState());
    });
  }*/
}
