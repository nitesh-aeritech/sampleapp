import 'package:flutter/material.dart';
import 'package:thewarehouse/config/constant/constant.dart';
import 'package:thewarehouse/config/enum/enum.dart';
import 'package:thewarehouse/config/helper/uiHelpers.dart';
import 'package:thewarehouse/config/routes/routes.dart';
import 'package:thewarehouse/config/theme/colors.dart';
import 'package:thewarehouse/config/utility/validator.dart';
import 'package:thewarehouse/services/core/dependencies.dart';
import 'package:thewarehouse/view/core/baseView.dart';
import 'package:thewarehouse/view/palleteNumber.dart';
import 'package:thewarehouse/viewModel/itemViewModel.dart';
import 'package:thewarehouse/widgets/formQuestionWidget.dart';
import 'package:thewarehouse/widgets/progressDialog.dart';

class ItemBoxPage extends StatelessWidget {
  final String paletteNumber;
  final int truckId;
  final int typeOfCodeId;
  final int manifestId;
  ItemBoxPage({
    Key? key,
    required this.paletteNumber,
    required this.truckId,
    required this.typeOfCodeId,
    required this.manifestId,
  }) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();
  final int stepLength = 2;
  int currentStep = 0;
  final double indicatorSize = 28.0;
  final FocusNode keyBoardListenerFocus = FocusNode();
  ScanFocus currentScanFocus = ScanFocus.codeInBox;
  late final ItemViewModel pageModel;

  InputBorder? focusedBorderForScan(BuildContext context, ScanFocus scanFocus) {
    // switch (scanFocus) {
    //   case ScanFocus.codeInBox:
    //     return codeInBoxFocusNode.hasFocus ? Theme.of(context).inputDecorationTheme.border!.copyWith(borderSide: const BorderSide(color: AppColors.focusedTextFieldColor)) : null;
    //   case ScanFocus.skuNumber:
    //     return internalBoxFocusNode.hasFocus ? Theme.of(context).inputDecorationTheme.border!.copyWith(borderSide: const BorderSide(color: AppColors.focusedTextFieldColor)) : null;
    //   default:
    //     return null;
    // }
    return scanFocus == currentScanFocus ? Theme.of(context).inputDecorationTheme.border!.copyWith(borderSide: const BorderSide(color: AppColors.focusedTextFieldColor)) : null;
  }

  addKeyEventListener() {
    // if (!keyBoardListenerFocus.hasFocus) {
    //   keyBoardListenerFocus.requestFocus();
    // }

    // keyBoardListenerFocus.addListener(() {
    //   if (!keyBoardListenerFocus.hasFocus) {
    //     keyBoardListenerFocus.requestFocus();
    //   }
    // });
  }

  removeKeyEventListener() {
    // keyBoardListenerFocus.removeListener(() {});
    // if (keyBoardListenerFocus.hasFocus && pageModel.isMounted) FocusScope.of(pageModel.context).requestFocus(FocusNode());
  }

  scanCodeInBox(BuildContext context) {
    removeKeyEventListener();
    // Navigator.of(context).pushNamed(Routes.scannerPage, arguments: {'code': '14789', 'title': 'Code in Box'}).then((value) {
    //   if (((value ?? '').toString()).isNotEmpty) {
    //     currentScanFocus = ScanFocus.skuNumber;
    //     pageModel.updateCodeInBox(value as String);
    //     pageModel.getItemCodeManifest();
    //     Future.delayed(const Duration(milliseconds: 500)).then((value) {
    //       scanSkuNumber(context);
    //     });
    //   } else {
    //     addKeyEventListener();
    //   }
    // });
  }

  scanSkuNumber(BuildContext context) {
    removeKeyEventListener();
    // Navigator.of(context).pushNamed(Routes.scannerPage, arguments: {'code': '98741', 'title': 'SKU Number'}).then((value) {
    //   addKeyEventListener();
    //   if (((value ?? '').toString()).isNotEmpty) {
    //     currentScanFocus = ScanFocus.none;
    //     pageModel.updateInternalSkuNumber(value as String);
    //   }
    // });
  }

  getManifestValidationWidget() {
    if (pageModel.state == ViewState.idle && pageModel.codeInBoxController.text.isNotEmpty) {
      if (pageModel.manifest != null) {
        return const CircleAvatar(
          maxRadius: 12,
          backgroundColor: AppColors.greenColor,
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        );
      } else {
        if (pageModel.isItemManifestFetching) {
          return const SizedBox(height: 25, width: 25, child: CircularProgressIndicator());
        } else {
          return const CircleAvatar(
            maxRadius: 12,
            backgroundColor: AppColors.redColor,
            child: Icon(
              Icons.close_rounded,
              color: Colors.white,
            ),
          );
        }
      }
    }
  }

  final FocusNode codeInBoxFocusNode = FocusNode();
  final FocusNode additionalDataFocusNode = FocusNode();
  final FocusNode internalBoxFocusNode = FocusNode();
  bool isCodeInBoxFocused = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Item Details')),
      body: BaseView<ItemViewModel>(
          onModelReady: (model) {
            pageModel = model;
            codeInBoxFocusNode.requestFocus();
            codeInBoxFocusNode.addListener(() {
              if (codeInBoxFocusNode.hasFocus) {
                isCodeInBoxFocused = true;
                currentScanFocus = ScanFocus.codeInBox;
              } else {
                if (isCodeInBoxFocused) {
                  model.getItemCodeManifest();
                }
                isCodeInBoxFocused = false;
              }
              model.setState();
            });
            internalBoxFocusNode.addListener(() {
              if (internalBoxFocusNode.hasFocus) {
                currentScanFocus = ScanFocus.skuNumber;
              } else {
                currentScanFocus = ScanFocus.none;
              }
              model.setState();
            });
            model.initializeValue(
              paletteNumber,
              truckId,
              typeOfCodeId,
            );
            addKeyEventListener();
          },
          onDispose: (vmode) {},
          builder: ((context, model, child) {
            if (model.state == ViewState.busy && model.itemConditionList == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
                padding: pageSidePadding,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (model.state == ViewState.busy && (model.manifest == null || model.truckManifest == null))
                          const LinearProgressIndicator(
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation(Colors.yellow),
                          ),
                        if (model.truckManifest != null)
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Item Found in manifest: ${model.truckManifest!.itemsFoundInManifest}",
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Item not found in manifest: ${model.truckManifest!.itemsNotFoundInManifest}",
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Total Items Scanned So far: ${model.truckManifest!.numberOfItems} ",
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                                formSeperatorBox(),
                              ],
                            ),
                          ),
                        formSeperatorBox(),
                        FormQuestionWidget(
                          title: 'Code in Box',
                          child: TextFormField(
                            focusNode: codeInBoxFocusNode,
                            autofocus: false,
                            onFieldSubmitted: (value) {
                              internalBoxFocusNode.requestFocus();
                            },
                            // readOnly: false,
                            decoration: InputDecoration(
                              focusedBorder: focusedBorderForScan(context, ScanFocus.codeInBox),
                              border: focusedBorderForScan(context, ScanFocus.codeInBox),
                              errorBorder: focusedBorderForScan(context, ScanFocus.codeInBox),
                              disabledBorder: focusedBorderForScan(context, ScanFocus.codeInBox),
                              focusedErrorBorder: focusedBorderForScan(context, ScanFocus.codeInBox),
                              enabledBorder: focusedBorderForScan(context, ScanFocus.codeInBox),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: getManifestValidationWidget(),
                                  ),
                                ],
                              ),
                            ),
                            validator: Validators.emptyFieldValidator,

                            controller: model.codeInBoxController,
                          ),
                        ),
                        formSeperatorBox(),
                        FormQuestionWidget(
                          title: 'Internal SKU Number',
                          child: TextFormField(
                            focusNode: internalBoxFocusNode,
                            onFieldSubmitted: (value) {
                              additionalDataFocusNode.requestFocus();
                            },
                            decoration: InputDecoration(
                              focusedBorder: focusedBorderForScan(context, ScanFocus.skuNumber),
                              border: focusedBorderForScan(context, ScanFocus.skuNumber),
                              errorBorder: focusedBorderForScan(context, ScanFocus.skuNumber),
                              disabledBorder: focusedBorderForScan(context, ScanFocus.skuNumber),
                              focusedErrorBorder: focusedBorderForScan(context, ScanFocus.skuNumber),
                              enabledBorder: focusedBorderForScan(context, ScanFocus.skuNumber),
                            ),
                            validator: Validators.emptyFieldValidator,
                            controller: model.internalSkuNumberController,
                          ),
                        ),
                        formSeperatorBox(),
                        FormQuestionWidget(
                          title: 'Additional Number/Data',
                          child: TextFormField(
                            focusNode: additionalDataFocusNode,
                            autofocus: false,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            // readOnly: false,
                            decoration: InputDecoration(
                              focusedBorder: focusedBorderForScan(context, ScanFocus.additionalData),
                              border: focusedBorderForScan(context, ScanFocus.additionalData),
                              errorBorder: focusedBorderForScan(context, ScanFocus.additionalData),
                              disabledBorder: focusedBorderForScan(context, ScanFocus.additionalData),
                              focusedErrorBorder: focusedBorderForScan(context, ScanFocus.additionalData),
                              enabledBorder: focusedBorderForScan(context, ScanFocus.additionalData),
                            ),
                            controller: model.additionalDataController,
                          ),
                        ),
                        formSeperatorBox(),
                        FormQuestionWidget(
                          title: 'Select condition of this item',
                          child: Column(
                              children: model.itemConditionList!
                                  .map(
                                    (e) => RadioListTile<int>(
                                      contentPadding: const EdgeInsets.all(0),
                                      activeColor: AppColors.mainColor,
                                      selected: model.itemConditionId == e.id,
                                      title: Text(e.name),
                                      value: e.id,
                                      groupValue: model.itemConditionId,
                                      onChanged: (value) {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        model.updateItemCondition(value);
                                      },
                                    ),
                                  )
                                  .toList()),
                        ),
                        formSeperatorBox(),
                        FormQuestionWidget(
                          title: 'Truck Palette Number',
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                                suffix: model.palletteNumber == null
                                    ? null
                                    : model.doesTruckPallateNumberExists == null
                                        ? const SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(),
                                          )
                                        : model.doesTruckPallateNumberExists!
                                            ? const CircleAvatar(
                                                maxRadius: 12,
                                                backgroundColor: AppColors.greenColor,
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const CircleAvatar(
                                                maxRadius: 12,
                                                backgroundColor: AppColors.redColor,
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color: Colors.white,
                                                ),
                                              )),
                            controller: TextEditingController(text: model.palletteNumber),
                          ),
                        ),
                        formSeperatorBox(),
                        FormQuestionWidget(
                          title: 'Warehouse Palette Number',
                          child: TextFormField(
                            readOnly: true,
                            controller: TextEditingController(
                              text: model.warehousePalletteNumber,
                            ),
                          ),
                        ),
                        formSeperatorBox(),
                        formSeperatorBox(),
                        formSeperatorBox(),
                        TextButton(
                          onPressed: () {
                            onSubmit(context, true);
                          },
                          child: const Text('Submit and Scan Another box'),
                        ),
                        formSeperatorBox(),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) => PalatteNumberPage(
                                  existingNumber: model.palletteNumber,
                                  title: 'Truck palette Number',
                                ),
                                fullscreenDialog: true,
                              ),
                            )
                                .then((value) {
                              if (value != null) {
                                try {
                                  model.updatePalletteNumber(value);
                                } catch (e) {
                                  showErrorToast(e.toString());
                                }
                              }
                            });
                          },
                          child: const Text('Scan New Truck Pallette Number'),
                        ),
                        formSeperatorBox(),
                        TextButton(
                          onPressed: () {
                            scanWareHouse(context);
                          },
                          child: const Text('Scan New Warehouse Location'),
                        ),
                        formSeperatorBox(),
                        TextButton(
                          onPressed: () {
                            onSubmit(context, false);
                          },
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.greenColor)),
                          child: const Text('Submit This Truck'),
                        ),
                        formSeperatorBox(),
                      ],
                    ),
                  ),
                ));
          })),
    );
  }

  void scanWareHouse(
    BuildContext context,
  ) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => PalatteNumberPage(existingNumber: pageModel.warehousePalletteNumber, title: 'Warehouse palette Number'),
        fullscreenDialog: true,
      ),
    )
        .then((value) {
      if (value != null) {
        pageModel.updateWarehousePalletteNumber(value);
      }
    });
  }

  void onSubmit(BuildContext context, bool scanAnother) async {
    FocusScope.of(context).requestFocus(FocusNode());
    ProgressDialog pr = ProgressDialog(context, 'Please Wait');
    try {
      if ((pageModel.truckManifest?.id ?? -1) < 0) {
        throw ('Please wait while manifest is loading');
      }
      if (pageModel.itemConditionId == null) {
        throw ("Please Select Item Condition");
      }
      if (formKey.currentState!.validate() && pageModel.itemConditionId != null) {
        if (pageModel.palletteNumber == null) throw ("Select palette Number");
        if (pageModel.warehousePalletteNumber == null) {
          scanWareHouse(context);
          return;
        }
        if (scanAnother) {
          await pr.show();
          await pageModel.addItem();
          removeKeyEventListener();
          await pr.hide();
          pageModel.clearData();
          addKeyEventListener();
          // ).then((value) {
          // Navigator.of(context).pushNamedAndRemoveUntil(Routes.truckPage, (route) => false).then((value) {}).then((value) {
          //   Navigator.of(context).pushNamed(
          //     Routes.itemPage,
          //     arguments: {
          //       'manifestId': pageModel.truckManifest!.id,
          //       'paletteNumber': pageModel.paletteNumber,
          //       'truckId': pageModel.truckId,
          //       'typeOfCodeId': pageModel.typeOfCodeId,
          //     },
          //   );
          // });

        } else {
          final value = await showAlertDialog(context, 'Are you sure? This action marks the Truck as complete.',
              title: 'Confirm',
              onButtonPressed: () {
                Navigator.pop(context, false);
              },
              buttonText: "Dismiss",
              buttonText2: "Confirm",
              onButtonPressed2: () {
                Navigator.pop(context, true);
              });
          if (value ?? false) {
            await pr.show();
            final message = await pageModel.submitTruck();
            await pr.hide();
            showSuccesToast(message.toString());
            Navigator.of(context).pushNamedAndRemoveUntil(Routes.truckPage, (route) => false).then((value) {});
          }
        }
      }
    } catch (e) {
      await pr.hide();
      showErrorToast(e.toString());
    }
  }
  // Widget getRespectiveWidget(ItemViewModel model) {
  //   switch (currentStep) {
  //     // case 0:
  //     //   return PaletteNumberPage(
  //     //     model: model,
  //     //     onNextTap: () {
  //     //       currentStep++;
  //     //       model.setState();
  //     //     },
  //     //   );
  //     case 0:
  //       return BoxInformationPage(
  //         model: model,
  //         onBackTap: () {
  //           currentStep--;
  //           model.setState();
  //         },
  //         onNextTap: () {
  //           currentStep++;
  //           model.setState();
  //         },
  //       );

  //     case 1:
  //       return ItemConditionPage(
  //         model: model,
  //         onBackTap: () {
  //           currentStep--;
  //           model.setState();
  //         },
  //         onSubmitTap: (bool scanAnother) {
  //           if (scanAnother) {
  //             Navigator.of(model.context).pushReplacementNamed(
  //               Routes.itemPage,
  //               arguments: {
  //                 'paletteNumber': model.paletteNumber,
  //                 'truckId': model.truckId,
  //                 'typeOfCode': model.typeOfCodeId,
  //               },
  //             );
  //           } else {
  //             Navigator.of(model.context).pop();
  //             Navigator.of(model.context).pop();
  //           }
  //         },
  //       );

  //     default:
  //       return const SizedBox.shrink();
  //   }
  // }

  Color getColor(int index) {
    if (index == currentStep) {
      return Colors.black;
    } else if (index < currentStep) {
      return AppColors.greenColor;
    } else {
      return AppColors.dividerColor;
    }
  }
}
