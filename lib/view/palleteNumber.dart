import 'package:flutter/material.dart';

import 'package:thewarehouse/config/constant/constant.dart';
import 'package:thewarehouse/config/helper/uiHelpers.dart';
import 'package:thewarehouse/config/theme/colors.dart';
import 'package:thewarehouse/config/utility/validator.dart';
import 'package:thewarehouse/services/core/dependencies.dart';
import 'package:thewarehouse/services/truckService.dart';
import 'package:thewarehouse/widgets/formQuestionWidget.dart';

class PalatteNumberPage extends StatefulWidget {
  final String? existingNumber;
  final String title;
  const PalatteNumberPage({
    Key? key,
    this.existingNumber,
    required this.title,
  }) : super(key: key);

  @override
  State<PalatteNumberPage> createState() => _PalatteNumberPageState();
}

class _PalatteNumberPageState extends State<PalatteNumberPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.existingNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: pageSidePadding,
          child: Column(
            children: [
              formSeperatorBox(),
              FormQuestionWidget(
                title: widget.title,
                child: TextFormField(
                  autofocus: true,
                  controller: textEditingController,
                  validator: Validators.emptyFieldValidator,
                  onFieldSubmitted: (value) {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).pop(value);
                    }
                  },
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.focusedTextFieldColor),
                    ),
                  ),
                ),
              ),
              formSeperatorBox(),
              formSeperatorBox(),
              TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).pop(textEditingController.text);
                  }
                },
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
