import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/models_model.dart';
import '../providers/models_provider.dart';
import '../widgets/text_widget.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({Key? key}) : super(key: key);

  @override
  _ModelsDropDownWidgetState createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String? _currentModel;

  bool _isFirstLoading = true;

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    _currentModel = modelsProvider.getCurrentModel;

    return FutureBuilder<List<ModelsModel>>(
      future: modelsProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            _isFirstLoading == true) {
          _isFirstLoading = false;
          return const FittedBox(
            child: SpinKitFadingCircle(
              color: Colors.lightBlue,
              size: 30,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: TextWidget(
              label: snapshot.error.toString(),
            ),
          );
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox(
                child: DropdownButton<String>(
                  dropdownColor: const Color.fromARGB(255, 20, 158, 153),
                  iconEnabledColor: Colors.white,
                  items: snapshot.data!
                      .map(
                        (model) => DropdownMenuItem(
                          value: model.id,
                          child: TextWidget(
                            label: model.id,
                            fontSize: 15,
                          ),
                        ),
                      )
                      .toList(),
                  value: _currentModel,
                  onChanged: (value) {
                    setState(() {
                      _currentModel = value;
                    });
                    modelsProvider.setCurrentModel(
                      value!,
                    );
                  },
                ),
              );
      },
    );
  }
}