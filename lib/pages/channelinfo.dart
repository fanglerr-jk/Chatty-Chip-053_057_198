import 'package:flutter/material.dart';

class ChannelInfo extends StatefulWidget {
  final String channelid;
  final String channelname;
  final String adminname;
  const ChannelInfo(
      {Key? key,
      required this.channelid,
      required this.channelname,
      required this.adminname})
      : super(key: key);
  @override
  State<ChannelInfo> createState() => _ChannelInfoState();
}

class _ChannelInfoState extends State<ChannelInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}