import 'package:flutter/material.dart';
import 'package:thewarehouse/model/valueModel.dart';

class CustomDropDownField extends StatefulWidget {
  final List<ValueModel> dataList;
  final int? dataValue;
  final String hint;
  final Function(int?) onChanged;
  final String? Function(int?)? validator;
  final bool enabled;
  const CustomDropDownField(this.onChanged, this.dataList, this.dataValue, {super.key, this.hint = '', this.validator, this.enabled = true});
  @override
  _CustomDropDownFieldState createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.enabled,
      child: DropdownButtonFormField<int>(
        value: widget.dataValue,
        isExpanded: true,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        isDense: true,
        validator: (value) {
          if (widget.validator == null) {
            return null;
          } else {
            return widget.validator!(value);
          }
        },
        decoration: InputDecoration(labelText: widget.hint),
        items: (widget.dataList).isNotEmpty
            ? widget.dataList
                .map(
                  (e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                  ),
                )
                .toList()
            : [],
        onChanged: (value) {
          FocusScope.of(context).requestFocus(FocusNode());
          if (value == -1) {
            widget.onChanged(null);
          } else {
            if (value != widget.dataValue) widget.onChanged(value);
          }
        },
      ),
    );
  }
}
