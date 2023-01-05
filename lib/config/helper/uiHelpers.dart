import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thewarehouse/config/constant/constant.dart';

import 'package:thewarehouse/config/helper/screenSizeConfig.dart';
import 'package:thewarehouse/config/theme/colors.dart';
import 'package:thewarehouse/widgets/customDialog.dart';

Widget formSeperatorBox() {
  return adaptableHeight(10.0);
}

Widget listSeperatorBox() {
  return adaptableHeight(15.0);
}

Widget adaptableHeight(double height) {
  return SizedBox(
    height: ScreenSizeConfig.getAdaptableHeight(mobileSize: height),
  );
}

Widget adaptableWidth(double width) {
  return SizedBox(
    width: ScreenSizeConfig.getAdaptableWidth(mobileSize: width),
  );
}

showPermissionRequiredMessage(BuildContext context, String? message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text((message ?? 'Permission Required')),
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
        label: 'Open App Settigs',
        onPressed: () {
          openAppSettings();
        }),
  ));
}

centerHintText({String? text}) {
  return Center(
    child: Text(
      (text ?? 'No Data Found'),
      textAlign: TextAlign.center,
      maxLines: 3,
      style: TextStyle(
        color: Colors.grey.withOpacity(0.8),
        fontSize: 17,
      ),
    ),
  );
}

void snackBarContext(BuildContext context, dynamic error, {bool? showSnackBar}) {
  if (showSnackBar ?? false) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        error.toString(),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    ));
  } else {
    showAlertDialog(context, error.toString());
  }
}

TextStyle centerHintStyle = const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold);

Future<dynamic> showAlertDialog(
  BuildContext context,
  String msg, {
  String? buttonText,
  bool isDissmissable = false,
  Function? onButtonPressed,
  IconData? icon,
  String? buttonText2,
  String? title,
  Function? onButtonPressed2,
}) async {
  return await showDialog(
      context: context,
      barrierDismissible: isDissmissable,
      builder: (context) => CustomDialog(
            title: (title ?? 'Error!'),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        msg,
                        maxLines: 5,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => AppColors.dialogNegativeColor,
                          ),
                        ),
                        child: Text(
                          (buttonText ?? 'Dismiss'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        onPressed: () {
                          if (onButtonPressed == null) {
                            Navigator.of(context).pop();
                          } else {
                            onButtonPressed();
                          }
                        },
                      ),
                    ),
                    if (onButtonPressed2 != null)
                      const SizedBox(
                        width: 10,
                      ),
                    if (onButtonPressed2 != null)
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => AppColors.dialogPositiveColor,
                            ),
                          ),
                          child: Text(
                            (buttonText2 ?? 'Cancel'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          onPressed: () {
                            onButtonPressed2();
                          },
                        ),
                      ),
                  ],
                )
              ],
            ),
          )).then((value) => value);
}

showCustomBottomSheet(BuildContext context, String title, String subtitle, String buttonText, Widget child, Function onTap) {
  final GlobalKey<FormState> formKey = GlobalKey();
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      isDismissible: false,
      builder: (context) {
        return SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                  pageSidePadding.left,
                  ScreenSizeConfig.getAdaptableWidth(mobileSize: 0),
                  0,
                  MediaQuery.of(context).viewInsets.bottom + ScreenSizeConfig.getAdaptableWidth(mobileSize: 20),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: ScreenSizeConfig.getAdaptableWidth(mobileSize: 10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  Text(
                                    subtitle,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: pageSidePadding.left),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            child,
                            formSeperatorBox(),
                            formSeperatorBox(),
                            TextButton(
                              onPressed: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                if (formKey.currentState!.validate()) {
                                  onTap();
                                }
                              },
                              child: Text(buttonText),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        );
      });
}

showSuccesToast(
  String msg,
) {
  if (Platform.isLinux) {
    //
  } else {
    Fluttertoast.showToast(msg: msg, backgroundColor: Colors.green, textColor: Colors.white, toastLength: Toast.LENGTH_LONG);
  }
}

showErrorToast(String msg) {
  if (Platform.isLinux) {
    //
  } else {
    Fluttertoast.showToast(msg: msg, backgroundColor: Colors.red, textColor: Colors.white, toastLength: Toast.LENGTH_LONG);
  }
}
