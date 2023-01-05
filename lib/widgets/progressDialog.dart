import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thewarehouse/config/helper/screenSizeConfig.dart';

enum ProgressDialogType { Normal }

double _progress = 0.0, _maxProgress = 100.0;

Widget? _customBody;

TextAlign _textAlign = TextAlign.left;
Alignment _progressWidgetAlignment = Alignment.centerLeft;

TextDirection _direction = TextDirection.ltr;

bool _isShowing = false;
BuildContext? _context, _dismissingContext;
ProgressDialogType? _progressDialogType;
bool _barrierDismissible = false, _showLogs = false;

TextStyle _progressTextStyle = TextStyle(color: Colors.black, fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: 12), fontWeight: FontWeight.w400);
TextStyle _messageStyle = TextStyle(color: Colors.black, fontSize: ScreenSizeConfig.getAdaptableFontSize(mobileSize: 18), fontWeight: FontWeight.w600);

double _dialogElevation = 8.0, _borderRadius = ScreenSizeConfig.getAdaptableFontSize(mobileSize: 8.0);
Color _backgroundColor = Colors.white;
Curve _insetAnimCurve = Curves.easeInOut;
EdgeInsets _dialogPadding = EdgeInsets.all(ScreenSizeConfig.getAdaptableFontSize(mobileSize: 8.0));

Widget _progressWidget = const Center(
  child: CircularProgressIndicator(),
);

class ProgressDialog {
  _Body? _dialog;
  String _dialogMessage = "Loading...";
  ProgressDialog(BuildContext? context, String message, {ProgressDialogType? type, bool? showLogs, TextDirection? textDirection, Widget? customBody}) {
    _context = context;
    _progressDialogType = type ?? ProgressDialogType.Normal;
    _barrierDismissible = false;
    _dialogMessage = '$message...';
    _showLogs = showLogs ?? false;
    _customBody = customBody;
    _direction = textDirection ?? TextDirection.ltr;
  }

  void style(
      {Widget? child,
      double? progress,
      double? maxProgress,
      String? message,
      Widget? progressWidget,
      Color? backgroundColor,
      TextStyle? progressTextStyle,
      TextStyle? messageTextStyle,
      double? elevation,
      TextAlign? textAlign,
      double? borderRadius,
      Curve? insetAnimCurve,
      EdgeInsets? padding,
      Alignment? progressWidgetAlignment}) {
    if (_isShowing) return;

    _dialogMessage = message ?? _dialogMessage;
    _maxProgress = maxProgress ?? _maxProgress;
    _progressWidget = progressWidget ?? _progressWidget;
    _backgroundColor = backgroundColor ?? _backgroundColor;
    _messageStyle = messageTextStyle ?? _messageStyle;
    _progressTextStyle = progressTextStyle ?? _progressTextStyle;
    _dialogElevation = elevation ?? _dialogElevation;
    _borderRadius = borderRadius ?? _borderRadius;
    _insetAnimCurve = insetAnimCurve ?? _insetAnimCurve;
    _textAlign = textAlign ?? _textAlign;
    _progressWidget = child ?? _progressWidget;
    _dialogPadding = padding ?? _dialogPadding;
    _progressWidgetAlignment = progressWidgetAlignment ?? _progressWidgetAlignment;
  }

  void update({double? progress, double? maxProgress, String? message, Widget? progressWidget, TextStyle? progressTextStyle, TextStyle? messageTextStyle}) {
    _dialogMessage = message ?? _dialogMessage;
    _maxProgress = maxProgress ?? _maxProgress;
    _progressWidget = progressWidget ?? _progressWidget;
    _messageStyle = messageTextStyle ?? _messageStyle;
    _progressTextStyle = progressTextStyle ?? _progressTextStyle;

    if (_isShowing) _dialog!.update();
  }

  bool isShowing() {
    return _isShowing;
  }

  Future<bool> hide() async {
    try {
      if (_isShowing) {
        _isShowing = false;
        Navigator.of(_dismissingContext!).pop();
        if (_showLogs) debugPrint('ProgressDialog dismissed');
        return Future.value(true);
      } else {
        if (_showLogs) debugPrint('ProgressDialog already dismissed');
        return Future.value(false);
      }
    } catch (err) {
      debugPrint('Seems there is an issue hiding dialog');
      debugPrint(err.toString());
      return Future.value(false);
    }
  }

  Future<bool> show() async {
    try {
      if (!_isShowing) {
        _dialog = _Body(
          dialogMessage: _dialogMessage,
        );
        showDialog<dynamic>(
          context: _context!,
          barrierDismissible: _barrierDismissible,
          builder: (BuildContext context) {
            _dismissingContext = context;
            return WillPopScope(
              onWillPop: () async => _barrierDismissible,
              child: Dialog(
                  backgroundColor: _backgroundColor,
                  insetAnimationCurve: _insetAnimCurve,
                  insetAnimationDuration: const Duration(milliseconds: 100),
                  elevation: _dialogElevation,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
                  child: _dialog),
            );
          },
        );
        // Delaying the function for 200 milliseconds
        // [Default transitionDuration of DialogRoute]
        await Future.delayed(const Duration(milliseconds: 200));
        if (_showLogs) debugPrint('ProgressDialog shown');
        _isShowing = true;
        return true;
      } else {
        if (_showLogs) debugPrint("ProgressDialog already shown/showing");
        return false;
      }
    } catch (err) {
      _isShowing = false;
      debugPrint('Exception while showing the dialog');
      debugPrint(err.toString());
      return false;
    }
  }
}

// ignore: must_be_immutable
class _Body extends StatefulWidget {
  final String dialogMessage;
  final _BodyState _dialog = _BodyState();

  _Body({Key? key, required this.dialogMessage}) : super(key: key);

  update() {
    _dialog.update();
  }

  @override
  State<StatefulWidget> createState() => _dialog;
}

class _BodyState extends State<_Body> {
  update() {
    setState(() {});
  }

  @override
  void dispose() {
    _isShowing = false;
    if (_showLogs) debugPrint('ProgressDialog dismissed by back button');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loader = Align(
      alignment: _progressWidgetAlignment,
      child: SizedBox(
        width: 60.0,
        height: 60.0,
        child: _progressWidget,
      ),
    );

    final text = Expanded(
      child: _progressDialogType == ProgressDialogType.Normal
          ? Text(
              widget.dialogMessage,
              textAlign: _textAlign,
              style: _messageStyle,
              textDirection: _direction,
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        widget.dialogMessage,
                        style: _messageStyle,
                        textDirection: _direction,
                      )),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "$_progress/$_maxProgress",
                      style: _progressTextStyle,
                      textDirection: _direction,
                    ),
                  ),
                ],
              ),
            ),
    );

    return _customBody ??
        Container(
          padding: _dialogPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // row body
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(width: 8.0),
                  _direction == TextDirection.ltr ? loader : text,
                  const SizedBox(width: 8.0),
                  _direction == TextDirection.rtl ? loader : text,
                  const SizedBox(width: 8.0)
                ],
              ),
            ],
          ),
        );
  }
}
