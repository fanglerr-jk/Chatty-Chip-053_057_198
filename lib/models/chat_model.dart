class ChatModel {
  final String msg;
  final int chatIndex;

  ChatModel({required this.msg, required this.chatIndex});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json["msg"],
        chatIndex: json["chatIndex"],
      );
}
/* Inside the fromJson factory constructor, the values of msg and chatIndex properties 
are extracted from the input json object using the corresponding keys - "msg" and "chatIndex".
 These values are then used to create a new instance of ChatModel using the named constructor 
 ChatModel(msg: msgValue, chatIndex: chatIndexValue) and returned by the factory constructor.*/