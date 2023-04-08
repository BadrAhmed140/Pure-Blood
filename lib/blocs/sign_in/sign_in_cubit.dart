import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  static SignInCubit get(context)=>BlocProvider.of(context);
  var emailController = TextEditingController();
  var passController = TextEditingController();
void userSignIn({
  @required String ?email
,@required String ?password}){
  emit(LoadingSignInState());
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!).
  then((value){
    emit(SuccesSignInState(value.user!.uid));
    print(value.user!.email);
    print(value.user!.uid);
print('login');

  }).catchError((error)
  {
    emit(ErrorSignInState(error.toString()));

  }
  );

}

  

}
