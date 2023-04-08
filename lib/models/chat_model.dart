class ChatModel{
  String? text;
  String? senderId;
  String? receiverId;
  String? dateTime;
  ChatModel({required this.text,required this.senderId,required this.receiverId,required this.dateTime});

  ChatModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
  }
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'receiverId':receiverId,
      'dateTime': dateTime,
    };
  }


}
