import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:thewarehouse/config/constant/apiUrl.dart';
import 'package:thewarehouse/config/constant/constant.dart';
import 'package:thewarehouse/config/helper/screenSizeConfig.dart';
import 'package:thewarehouse/config/routes/routeManager.dart';
import 'package:thewarehouse/config/routes/routes.dart';
import 'package:thewarehouse/config/theme/themes.dart';
import 'package:thewarehouse/services/core/dependencies.dart';
import 'package:thewarehouse/services/core/httpService.dart';
import 'package:thewarehouse/services/core/preferenceService.dart';

//Entry Point for Prod Env Variable
void main() async {
  //Configure needed services for Prod Env
  ApiUrl.isDevEnv = false;

  mainApp();
}

mainApp() {
  HttpOverrides.global = MyHttpOverrides();
  //Ensure that binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  //Initialize Shared Preferences
  PreferenceService();
  //Initialize Dependencies
  setupDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (newContext, child) {
        ScreenUtil.init(newContext);
        return ScreenUtilInit(
          minTextAdapt: false,
          splitScreenMode: true,
          designSize: Size(MediaQuery.of(newContext).size.width, MediaQuery.of(newContext).size.height),
          builder: (context, c) => MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              ScreenSizeConfig().init(context);
              return ResponsiveWrapper.builder(child,
                  defaultScale: true,
                  breakpoints: const [
                    ResponsiveBreakpoint.resize(100, name: MOBILE),
                    ResponsiveBreakpoint.resize(480, name: MOBILE),
                    ResponsiveBreakpoint.autoScale(800, name: TABLET),
                    ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
                    ResponsiveBreakpoint.autoScale(2460, name: '4K'),
                  ],
                  background: Container(color: const Color(0xFFF5F5F5)));
            },
            themeMode: ThemeMode.light,
            theme: Themes().theme(newContext),
            initialRoute: Routes.splashPage,
            onGenerateRoute: generateRoutes,
            title: appName,
          ),
        );
      },
    );
  }
}
