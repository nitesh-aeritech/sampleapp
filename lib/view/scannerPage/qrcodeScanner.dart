import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:thewarehouse/config/constant/constant.dart';

import 'package:thewarehouse/view/core/baseView.dart';
import 'package:thewarehouse/view/scannerPage/scannerpage.dart';
import 'package:thewarehouse/viewModel/scannerViewModel.dart';

class QRCodeScannerPage extends StatelessWidget {
  final String demoCode;
  final String title;
  QRCodeScannerPage({
    Key? key,
    required this.demoCode,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<QRScanPageModel>(
      onModelReady: (model) {},
      reAssemble: (model) {
        model.onPageReassemble();
      },
      builder: ((context, qrScanPageModel, child) => RawKeyboardListener(
            autofocus: true,
            focusNode: FocusNode(),
            onKey: (keyEvent) {
              if (qrScanPageModel.isScanning) return;
              if (keyEvent is RawKeyUpEvent) {
                final dynamic keyData = keyEvent.data;
                if (keyData.keyCode == keyCodeToPerformScan) {
                  qrScanPageModel.isScanning = false;
                  qrScanPageModel.setState();
                }
              }
            },
            child: ScannerPage(
              scaffoldKey: qrScanPageModel.scaffoldKey,
              pageTitle: 'Scan Code',
              title: 'Scan $title',
              subtitle: 'Line up the code inside and keep your phone steady',
              bottomSubtitle: 'OR Enter Code Manually',
              centerWidget: SizeChangedLayoutNotifier(
                  key: const Key('qr-size-notifier'),
                  child: MobileScanner(
                    allowDuplicates: true,
                    onDetect: (v, a) {
                      if (qrScanPageModel.isScanning) return;
                      qrScanPageModel.idController.text = v.rawValue ?? '';
                      if (qrScanPageModel.idController.text.trim().isEmpty) {
                        qrScanPageModel.isScanning = false;
                        return;
                      } else {
                        qrScanPageModel.isScanning = true;
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.of(context).pop(qrScanPageModel.idController.text);
                      }
                    },
                    controller: qrScanPageModel.controller,
                  )),
              bottomWidget: Row(children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffb7b5b5),
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        topLeft: Radius.circular(4),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 14),
                      controller: qrScanPageModel.idController,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        filled: false,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.resolveWith<Size>(
                      (states) => const Size(50, 48),
                    ),
                    shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                      (states) => const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Future.delayed(const Duration(microseconds: 200)).then((value) {
                      if (qrScanPageModel.idController.text.trim().isNotEmpty) {
                        Navigator.of(context).pop(qrScanPageModel.idController.text);
                      }
                    });
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ]),
            ),
          )),
    );
  }
}
