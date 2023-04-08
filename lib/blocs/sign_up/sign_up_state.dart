part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}


class SuccesSignUpState extends SignUpState{

}
class LoadingSignUpState extends SignUpState{}
class ErrorSignUpState extends SignUpState{
  final String error;

  ErrorSignUpState(this.error);
}


class SuccesCreateUserState extends SignUpState{
  final String uid;

  SuccesCreateUserState(this.uid);
}
class LoadingCreateUserState extends SignUpState{}
class ErrorCreateUserState extends SignUpState{
  final String error;

  ErrorCreateUserState(this.error);
}




class DropDownValueState extends SignUpState{}