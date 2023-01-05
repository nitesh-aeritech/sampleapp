import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thewarehouse/config/helper/uiHelpers.dart';
import 'package:thewarehouse/config/theme/colors.dart';

class FormQuestionWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final String? subtitle;
  const FormQuestionWidget({
    Key? key,
    required this.title,
    required this.child,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: TextStyle(color: AppColors.rejectedColor, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        adaptableHeight(5),
        child
      ],
    );
  }
}
