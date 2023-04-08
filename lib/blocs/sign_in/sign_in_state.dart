part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}


class SuccesSignInState extends SignInState{
  final String uid;

  SuccesSignInState(this.uid);
}
class LoadingSignInState extends SignInState{}
class ErrorSignInState extends SignInState{
  final String error;

  ErrorSignInState(this.error);
}
