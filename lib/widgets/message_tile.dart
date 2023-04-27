import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final String sender;
  final bool sentByMe;

  const MessageTile({
    Key? key,
    required this.message,
    required this.sender,
    required this.sentByMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: sentByMe ? 0 : 24,
      ),
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sentByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: sentByMe ? Radius.circular(20) : Radius.zero,
            bottomRight: sentByMe ? Radius.zero : Radius.circular(20),
          ),
          color: sentByMe ? Theme.of(context).primaryColor : Colors.grey[700],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sender.toUpperCase(),
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              message,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}