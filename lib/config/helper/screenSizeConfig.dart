import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenSizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late bool isDeviceTab = false;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    isDeviceTab = screenWidth > 700;
    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  static double getAdaptableFontSize({double? mobileSize = 14.0, double? tabSize}) {
    return isDeviceTab ? ScreenUtil().setSp((tabSize ?? mobileSize)! * 1.0) : ScreenUtil().setSp((mobileSize)! * 1.0);
  }

  static double getAdaptableHeight({double mobileSize = 14.0, double? tabSize}) {
    return isDeviceTab ? ScreenUtil().setHeight((tabSize ?? mobileSize) * 1.0) : ScreenUtil().setSp((mobileSize) * 1.0);
  }

  static double getAdaptableWidth({double mobileSize = 14.0, double? tabSize}) {
    return isDeviceTab ? ScreenUtil().setWidth((tabSize ?? mobileSize) * 1.0) : ScreenUtil().setSp((mobileSize) * 1.0);
  }
}
