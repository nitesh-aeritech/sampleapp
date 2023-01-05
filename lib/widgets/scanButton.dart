import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thewarehouse/config/helper/screenSizeConfig.dart';

class ScanButton extends StatelessWidget {
  final Function() onTap;
  const ScanButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.resolveWith(
            (states) => Size(
              80,
              ScreenSizeConfig.getAdaptableHeight(mobileSize: 54),
            ),
          ),
        ),
        onPressed: onTap,
        child: const Text('Scan'));
  }
}
