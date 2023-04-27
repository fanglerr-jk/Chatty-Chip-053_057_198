import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:wireless/service/assets_manager.dart';
import 'package:wireless/widgets/text_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.message,
    required this.chatIndex,
    this.shouldAnimate = false,
  }) : super(key: key);

  final String message;
  final int chatIndex;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    final color = const Color.fromARGB(255, 20, 158, 153);
    final alignment = chatIndex == 0 ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final borderRadius = BorderRadius.only(
      topLeft: chatIndex == 0 ? const Radius.circular(0) : const Radius.circular(8),
      topRight: chatIndex == 0 ? const Radius.circular(8) : const Radius.circular(0),
      bottomLeft: const Radius.circular(8),
      bottomRight: const Radius.circular(8),
    );
    return Row(
      crossAxisAlignment: alignment,
      children: [
        if (chatIndex == 1) ...[
          const SizedBox(width: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.thumb_up_alt_outlined, color: Colors.white),
              SizedBox(width: 5),
              Icon(Icons.thumb_down_alt_outlined, color: Colors.white),
            ],
          ),
        ],
        Expanded(
          child: Material(
            borderRadius: borderRadius,
            color: color,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    chatIndex == 0 ? AssetsManager.userImage : AssetsManager.botImage,
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: shouldAnimate
                        ? DefaultTextStyle(
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                            child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              repeatForever: false,
                              displayFullTextOnTap: true,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(
                                  message.trim(),
                                ),
                              ],
                            ),
                          )
                        : TextWidget(
                            label: message.trim(),
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (chatIndex == 0) ...[
          const SizedBox(width: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.thumb_up_alt_outlined, color: Colors.white),
              SizedBox(width: 5),
              Icon(Icons.thumb_down_alt_outlined, color: Colors.white),
            ],
          ),
        ],
      ],
    );
  }
}