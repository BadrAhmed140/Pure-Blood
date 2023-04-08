part of 'pure_blood_cubit.dart';

@immutable
abstract class PureBloodState {}

class PureBloodInitial extends PureBloodState {}
//getUsers
class SuccesGetUserState extends PureBloodState{}
class LoadingGetUserState extends PureBloodState{}
class ErrorGetUserState extends PureBloodState{
  final String error;

  ErrorGetUserState(this.error);
}
//updateUsers
class LoadingUpdateUserState extends PureBloodState{}
class SuccessUpdateUserState extends PureBloodState{}
class ErrorUpdateUserState extends PureBloodState{
  final String error;

  ErrorUpdateUserState(this.error);


}
//getImage
class SuccessGetImageState extends PureBloodState{}
class ErrorGetImageState extends PureBloodState{}
//uploadImage
class SuccessUploadImageState extends PureBloodState{}
class ErrorUploadImageState extends PureBloodState{}


//sendMessage
class LoadingSendMessageState extends PureBloodState{}
class SuccessSendMessageState extends PureBloodState{}
class ErrorSendMessageState extends PureBloodState{}

//getMessages
class LoadingGetMessageState extends PureBloodState{}
class SuccessGetMessageState extends PureBloodState{}
class ErrorGetMessageState extends PureBloodState{}
