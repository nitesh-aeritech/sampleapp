import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:thewarehouse/config/constant/constant.dart';
import 'package:thewarehouse/config/helper/screenSizeConfig.dart';
import 'package:thewarehouse/config/routes/routes.dart';
import 'package:thewarehouse/services/core/dependencies.dart';
import 'package:thewarehouse/services/core/httpService.dart';
import 'package:thewarehouse/services/core/preferenceService.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getIt<HttpService>().init(context);
    return Scaffold(
      body: Padding(
        padding: pageSidePadding,
        child: Center(
          child: AnimatedTextKit(
            repeatForever: false,
            totalRepeatCount: 1,
            isRepeatingAnimation: true,
            onFinished: () {
              if (PreferenceService.isReady.value) {
                configure(context);
              } else {
                PreferenceService.isReady.addListener(() {
                  if (PreferenceService.isReady.value) configure(context);
                });
              }
            },
            animatedTexts: [
              TyperAnimatedText('', textStyle: const TextStyle(color: Colors.black)),
              TyperAnimatedText(appName,
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: 35),
                  ),
                  speed: const Duration(milliseconds: 100)),
            ],
            onTap: () {},
          ),
        ),
      ),
    );
  }

  configure(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (PreferenceService().accessToken.isEmpty) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.authenticationPage, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, Routes.truckPage, (route) => false);
    }
  }
}
