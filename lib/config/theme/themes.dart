import 'package:thewarehouse/config/constant/constant.dart';
import 'package:thewarehouse/config/theme/colors.dart';
import 'package:thewarehouse/config/helper/screenSizeConfig.dart';
import 'package:flutter/material.dart';

class Themes {
  //Default Icon Size
  static const double buttonHeight = 45;
  ThemeData theme(
    BuildContext context,
  ) {
    final TextTheme textThemeData = textTheme(context);
    return ThemeData(
        hintColor: AppColors.greyColor,
        useMaterial3: true,
        listTileTheme: ListTileThemeData(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenSizeConfig.getAdaptableFontSize(mobileSize: 8))),
            selectedColor: Colors.white,
            textColor: Colors.black),
        fontFamily: fontFamily,
        appBarTheme: appBarTheme,
        textTheme: textThemeData,
        chipTheme: ChipThemeData(
          deleteIconColor: Colors.black,
          labelStyle: TextStyle(fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: 14), color: Colors.black, fontWeight: FontWeight.w400),
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        primarySwatch: AppColors.mainMaterialColor,
        primaryColor: AppColors.mainColor,
        dividerColor: AppColors.dividerColor,
        textButtonTheme: textButtonTheme(),
        elevatedButtonTheme: elevatedButtonTheme(),
        iconTheme: IconThemeData(size: iconSize(), color: Colors.white),
        inputDecorationTheme: inputDecorationTheme);
  }

  static double iconSize() => ScreenSizeConfig.getAdaptableFontSize(mobileSize: 24);
  static boderStyle({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: color ?? AppColors.mainColor,
        ),
      );

  TextButtonThemeData textButtonTheme() => TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.white),
          textStyle: MaterialStateProperty.resolveWith(
              (states) => TextStyle(fontFamily: fontFamily, fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: 15), fontWeight: FontWeight.w500, color: Colors.white)),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => AppColors.mainColor),
          minimumSize: MaterialStateProperty.resolveWith<Size>(
            (states) => Size(
              double.maxFinite,
              ScreenSizeConfig.getAdaptableFontSize(mobileSize: buttonHeight, tabSize: 43),
            ),
          ),
        ),
      );
  ElevatedButtonThemeData elevatedButtonTheme() => ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.white),
          textStyle: MaterialStateProperty.resolveWith(
              (states) => TextStyle(fontFamily: fontFamily, fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: 15), fontWeight: FontWeight.w500, color: Colors.white)),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => AppColors.mainColor),
          minimumSize: MaterialStateProperty.resolveWith<Size>(
            (states) => Size(
              double.maxFinite,
              ScreenSizeConfig.getAdaptableFontSize(mobileSize: buttonHeight, tabSize: 43),
            ),
          ),
        ),
      );
  final AppBarTheme appBarTheme = AppBarTheme(
    // backgroundColor: Colors.transparent,
    elevation: 0,
    backgroundColor: AppColors.mainColor, centerTitle: true,
    actionsIconTheme: IconThemeData(size: iconSize(), color: Colors.white),
    iconTheme: IconThemeData(size: iconSize(), color: Colors.white),
    titleTextStyle: TextStyle(
      fontFamily: fontFamily,
      height: lineHeight,
      fontWeight: FontWeight.w600,
      fontSize: ScreenSizeConfig.getAdaptableFontSize(
        mobileSize: 17,
      ),
      color: Colors.white,
    ),
  );

  final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    fillColor: const Color(0xffEBEBEB),
    filled: true,
    errorMaxLines: 3,
    labelStyle: TextStyle(
      fontFamily: fontFamily,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w500,
      height: lineHeight,
      fontSize: ScreenSizeConfig.getAdaptableFontSize(
        mobileSize: hintTextSize,
      ),
    ),
    hintStyle: TextStyle(
      fontFamily: fontFamily,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w500,
      height: lineHeight,
      fontSize: ScreenSizeConfig.getAdaptableFontSize(
        mobileSize: hintTextSize,
      ),
    ),
    contentPadding: ScreenSizeConfig.isDeviceTab
        ? EdgeInsets.symmetric(
            vertical: ScreenSizeConfig.getAdaptableHeight(mobileSize: 12),
            horizontal: ScreenSizeConfig.getAdaptableWidth(mobileSize: 10),
          )
        : const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
    border: boderStyle(
      color: AppColors.textFieldFillColor,
    ),
    focusedBorder: boderStyle(
      color: AppColors.mainColor,
    ),
    errorBorder: boderStyle(
      color: Colors.red,
    ),
    focusedErrorBorder: boderStyle(
      color: AppColors.mainColor,
    ),
    disabledBorder: boderStyle(
      color: AppColors.textFieldFillColor,
    ),
    enabledBorder: boderStyle(
      color: AppColors.textFieldFillColor,
    ),
  );
  //Text Theme
  textTheme(BuildContext context) {
    final currentTextTheme = Theme.of(context).textTheme;
    return TextTheme(
      bodyText1: currentTextTheme.bodyText1!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: currentTextTheme.bodyText1!.fontSize, tabSize: currentTextTheme.bodyText1!.fontSize),
      ),
      bodyText2: currentTextTheme.bodyText2!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(
          mobileSize: currentTextTheme.bodyText2!.fontSize,
          tabSize: currentTextTheme.bodyText2!.fontSize,
        ),
      ),
      button: currentTextTheme.button!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: currentTextTheme.button!.fontSize, tabSize: currentTextTheme.button!.fontSize),
      ),
      caption: currentTextTheme.caption!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: currentTextTheme.caption!.fontSize, tabSize: currentTextTheme.caption!.fontSize),
      ),
      headline1: currentTextTheme.headline1!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: currentTextTheme.headline1!.fontSize, tabSize: currentTextTheme.headline1!.fontSize),
      ),
      headline2: currentTextTheme.headline2!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: currentTextTheme.headline2!.fontSize, tabSize: currentTextTheme.headline2!.fontSize),
      ),
      headline3: currentTextTheme.headline3!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: currentTextTheme.headline3!.fontSize, tabSize: currentTextTheme.headline3!.fontSize),
      ),
      headline4: currentTextTheme.headline4!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: currentTextTheme.headline4!.fontSize, tabSize: currentTextTheme.headline4!.fontSize),
      ),
      headline5: currentTextTheme.headline5!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: currentTextTheme.headline5!.fontSize, tabSize: currentTextTheme.headline5!.fontSize),
      ),
      headline6: currentTextTheme.headline6!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: currentTextTheme.headline6!.fontSize, tabSize: currentTextTheme.headline6!.fontSize),
      ),
      overline: currentTextTheme.overline!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: currentTextTheme.overline!.fontSize, tabSize: currentTextTheme.overline!.fontSize),
      ),
      subtitle1: currentTextTheme.subtitle1!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: currentTextTheme.subtitle1!.fontSize, tabSize: currentTextTheme.subtitle1!.fontSize),
      ),
      subtitle2: currentTextTheme.subtitle2!.copyWith(
        fontFamily: fontFamily,
        height: lineHeight,
        fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: currentTextTheme.subtitle2!.fontSize, tabSize: currentTextTheme.subtitle2!.fontSize),
      ),
    );
  }
}
