import 'package:flutter/material.dart';
import '../widget/dropdown.dart';
import '../widget/textwidget.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 20, 158, 153),
      context: context,
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextWidget(
                  label: "Chosen Model:",
                  fontSize: 16,
                ),
              ),
              Flexible(flex: 2, child: ModelsDropDownWidget()),
            ],
          ),
        );
      },
    );
  }
}
