import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  Future SavingUserData(String username, String email) async {
    return await userCollection.doc(uid).set({
      "username": username,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  Future GettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  getUserChannels() async {
    return userCollection.doc(uid).snapshots();
  }

  Future createChannel(String username, String id, String channelname) async {
    DocumentReference channelDocumentReference = await groupCollection.add({
      "channelname": channelname,
      "channelicon": "",
      "admin": "${id}_$username",
      "members": [],
      "channelid": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    await channelDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$username"]),
      "channelid": channelDocumentReference.id,
    });
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "channels":
          FieldValue.arrayUnion(["${channelDocumentReference.id}_$channelname"])
    });
  }

  getChats(String channelid) async {
    return groupCollection
        .doc(channelid)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String channelid) async {
    DocumentReference d = groupCollection.doc(channelid);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  // get group members
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  // send message
  sendMessage(String channelid, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(channelid).collection("messages").add(chatMessageData);
    groupCollection.doc(channelid).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }
}
