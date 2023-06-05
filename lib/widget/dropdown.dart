import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:chattychipsapp/providers/models-provider.dart';
import 'package:chattychipsapp/widget/textwidget.dart';
import 'package:chattychipsapp/models/models_model.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({Key? key});

  @override
  _ModelsDropDownWidgetState createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String? currentModel;

  bool isFirstLoading = true;

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModel = modelsProvider.getCurrentModel;

    return FutureBuilder<List<ModelsModel>>(
      future: modelsProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            isFirstLoading == true) {
          isFirstLoading = false;
          return const FittedBox(
            child: SpinKitFadingCircle(
              color: const Color(0xFFF589B3),
              size: 30,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: TextWidget(label: snapshot.error.toString()),
          );
        }

        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox(
                child: DropdownButton(
                  dropdownColor: const Color(0xFF71C563),
                  iconEnabledColor: Colors.white,
                  items: List<DropdownMenuItem<String>>.generate(
                    snapshot.data!.length,
                    (index) => DropdownMenuItem(
                      value: snapshot.data![index].id,
                      child: TextWidget(
                        label: snapshot.data![index].id,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  value: currentModel,
                  onChanged: (value) {
                    setState(() {
                      currentModel = value.toString();
                    });
                    modelsProvider.setCurrentModel(value.toString());
                  },
                ),
              );
      },
    );
  }
}
