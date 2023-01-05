import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thewarehouse/config/helper/uiHelpers.dart';
import 'package:thewarehouse/config/utility/validator.dart';

class ActionRequestActionForm extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isApproved;
  final Function(bool) onStatusChange;
  const ActionRequestActionForm({
    Key? key,
    required this.textEditingController,
    required this.isApproved,
    required this.onStatusChange,
  }) : super(key: key);

  @override
  State<ActionRequestActionForm> createState() => _ActionRequestActionFormState();
}

class _ActionRequestActionFormState extends State<ActionRequestActionForm> {
  bool isApproved = false;
  @override
  void initState() {
    isApproved = widget.isApproved;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.textEditingController,
          maxLines: 4,
          minLines: 3,
          decoration: InputDecoration(labelText: 'Remarks', contentPadding: Theme.of(context).inputDecorationTheme.contentPadding!.add(const EdgeInsets.symmetric(vertical: 8))),
          validator: Validators.emptyFieldValidator,
        ),
        formSeperatorBox(),
        GestureDetector(
          onTap: () {
            setState(() {
              isApproved = !isApproved;
              widget.onStatusChange(isApproved);
            });
          },
          child: Row(
            children: [
              AbsorbPointer(
                absorbing: true,
                child: SizedBox(
                  height: 15,
                  width: 20,
                  child: Checkbox(
                      value: isApproved,
                      onChanged: (value) {
                        // if (value == null) return;
                        // setState(() {
                        //   isApproved = value;
                        // });
                      }),
                ),
              ),
              adaptableWidth(5),
              const Text('Approve')
            ],
          ),
        )
      ],
    );
  }
}
