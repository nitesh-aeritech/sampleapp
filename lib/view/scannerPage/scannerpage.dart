import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thewarehouse/config/helper/screenSizeConfig.dart';
import 'package:thewarehouse/config/theme/colors.dart';

class ScannerPage extends StatelessWidget {
  final String pageTitle;
  final String title;
  final String subtitle;
  final Widget centerWidget;
  final Widget bottomWidget;
  final String bottomSubtitle;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const ScannerPage(
      {Key? key, required this.title, required this.pageTitle, required this.subtitle, required this.centerWidget, required this.bottomSubtitle, required this.scaffoldKey, required this.bottomWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = ScreenSizeConfig.safeBlockVertical * 78;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      key: scaffoldKey,
      appBar: AppBar(
        titleSpacing: -5,
        title: Text(pageTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                        height: height,
                        child: Column(
                          children: <Widget>[
                            Text(
                              title,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              subtitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Color(0xff808080)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: Center(child: centerWidget),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              bottomSubtitle,
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            bottomWidget
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
