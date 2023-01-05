import 'package:flutter/material.dart';
import 'package:thewarehouse/config/helper/screenSizeConfig.dart';
import 'package:thewarehouse/config/helper/uiHelpers.dart';

class CustomDialog extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? subtitle;

  const CustomDialog({Key? key, this.child, this.subtitle, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: ScreenSizeConfig.blockSizeHorizontal * 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          ScreenSizeConfig.getAdaptableWidth(mobileSize: 20),
          ScreenSizeConfig.getAdaptableHeight(mobileSize: 8),
          ScreenSizeConfig.getAdaptableWidth(mobileSize: 10),
          ScreenSizeConfig.getAdaptableHeight(mobileSize: 20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      (title ?? ''),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
            if (subtitle != null) Text(subtitle!),
            if (title != null) adaptableHeight(10),
            child!
          ],
        ),
      ),
    );
  }
}
