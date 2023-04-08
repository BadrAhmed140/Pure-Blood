import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pure_blood/models/user_model.dart';
import 'package:pure_blood/src/app_constants.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

/////////////////// blood request //////////
  var nameBloodRequestController = TextEditingController();
  var birthBloodRequestController = TextEditingController();
  var cityBloodRequestController = TextEditingController();
  var addressBloodRequestController = TextEditingController();
  var phoneBloodRequestController = TextEditingController();

  /////////////////// new user signup //////////
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var birthController = TextEditingController();
  String bloodTypeController = '-O';
  var items = ['-O', '+O', '-A', '+A', '-B', '+B', '-AB', '+AB', 'other'];

  DropDownValueFun(String newValu) {
    bloodTypeController = newValu;
    emit(DropDownValueState());
  }

  var cityController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();

  void userSignUp({
    required String name,
    required String email,
    required String password,
    required int birthday,
    required String bloodType,
    required String city,
    required String address,
    required String phoneNumber,
  }) {
    emit(LoadingSignUpState());
    print('loading');
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      print('login');
         uid=value.user!.uid;
      creatUser(
          name: name,
          email: email,
          password: password,
          birthday: birthday,
          bloodType: bloodType,
          city: city,
          address: address,
          phoneNumber: phoneNumber,
          uId: value.user!.uid,);
    }).catchError((error) {
      emit(ErrorSignUpState(error.toString()));
    });
  }

  void creatUser({
    required String name,
    required String email,
    required String password,
    required int birthday,
    required String bloodType,
    required String city,
    required String address,
    required String phoneNumber,
    required String uId,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        password: password,
        birthday: birthday,
        bloodType: bloodType,
        city: city,
        address: address,
        phoneNumber: phoneNumber,
        uId: uId);
    emit(SuccesSignUpState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SuccesCreateUserState(uId));
      print('create user succes');
    }).catchError((error) {
      emit(ErrorCreateUserState(error.toString()));
    });
  }
}
