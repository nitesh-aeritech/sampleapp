import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:thewarehouse/viewModel/core/baseViewModel.dart';
import 'package:thewarehouse/widgets/progressDialog.dart';

class QRScanPageModel extends BaseViewModel {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  MobileScannerController controller = MobileScannerController();
  TextEditingController idController = TextEditingController();
  bool isScanning = true;

  onPageReassemble() async {
    if (Platform.isAndroid) {
      await controller.stop();
    }
    controller.start();
  }
}
