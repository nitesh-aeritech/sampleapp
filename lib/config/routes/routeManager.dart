import 'package:thewarehouse/config/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:thewarehouse/config/routes/routes.dart';
import 'package:thewarehouse/view/authPage.dart';
import 'package:thewarehouse/view/homePage.dart';
import 'package:thewarehouse/view/itemBox/itemBoxPage.dart';
import 'package:thewarehouse/view/scannerPage/qrcodeScanner.dart';
import 'package:thewarehouse/view/splashScreen.dart';
import 'package:thewarehouse/view/truckPage.dart';

Route generateRoutes(RouteSettings settings) {
  debugPrint("----------");
  debugPrint('Route:${settings.name}');
  debugPrint('Arguments:${settings.arguments}');
  debugPrint("----------");
  final args = (settings.arguments as dynamic) ?? {};
  switch (settings.name) {
    case Routes.splashPage:
      return buildRoute(settings, const SplashScreen());
    case Routes.authenticationPage:
      {
        return buildRoute(settings, AuthPage());
      }

    case Routes.homePage:
      {
        return buildRoute(settings, const HomePage());
      }

    case Routes.scannerPage:
      {
        return buildRoute(
            settings,
            QRCodeScannerPage(
              demoCode: args['code'] as String,
              title: args['title'] as String,
            ));
      }

    case Routes.truckPage:
      {
        return buildRoute(settings, TruckPage());
      }
    case Routes.itemPage:
      {
        return buildRoute(
            settings,
            ItemBoxPage(
              paletteNumber: args['paletteNumber'] ?? '',
              typeOfCodeId: args['typeOfCodeId'],
              truckId: args['truckId'],
              manifestId: args['manifestId'],
            ));
      }

    default:
      return buildRoute(settings, const SplashScreen());
  }
}

CupertinoPageRoute buildRoute(RouteSettings settings, Widget builder, {bool fullscreenDialog = false}) {
  return CupertinoPageRoute(settings: settings, builder: (BuildContext context) => builder, fullscreenDialog: fullscreenDialog);
}
