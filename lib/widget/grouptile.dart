import 'package:chattychipsapp/pages/chat.dart';
import 'package:flutter/material.dart';

class GroupTile extends StatefulWidget {
  final String username;
  final String channelid;
  final String channelname;
  const GroupTile(
      {Key? key,
      required this.channelid,
      required this.channelname,
      required this.username})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              channelid: widget.channelid,
              channelname: widget.channelname,
              username: widget.username,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFFDBD5C),
            child: Text(
              widget.channelname.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            widget.channelname,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Join the conversation as ${widget.username}",
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
