import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'package:thewarehouse/config/constant/constant.dart';
import 'package:thewarehouse/config/enum/enum.dart';
import 'package:thewarehouse/config/helper/uiHelpers.dart';
import 'package:thewarehouse/config/routes/routes.dart';
import 'package:thewarehouse/config/theme/colors.dart';
import 'package:thewarehouse/services/core/dependencies.dart';

import 'package:thewarehouse/services/core/preferenceService.dart';
import 'package:thewarehouse/services/itemService.dart';
import 'package:thewarehouse/services/truckService.dart';
import 'package:thewarehouse/view/core/baseView.dart';
import 'package:thewarehouse/view/palleteNumber.dart';
import 'package:thewarehouse/viewModel/truckViewModel.dart';
import 'package:thewarehouse/widgets/formQuestionWidget.dart';

class TruckPage extends StatelessWidget {
  TruckPage({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey();
  late final TruckViewModel truckViewModel;
  final RefreshController refreshController = RefreshController();
  Color linearProgressColor(int linearProgressValue) {
    if (linearProgressValue == 100) {
      return Colors.red.shade900;
    } else if (linearProgressValue > 85) {
      return Colors.red;
    } else if (linearProgressValue <= 50) {
      return Colors.green;
    } else {
      return Colors.yellow.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Truck Details'),
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () async {
                final value = await showAlertDialog(
                  context,
                  'Are you sure, you want to log out?',
                  title: 'Confirm Logout?',
                  buttonText2: 'Yes',
                  buttonText: 'No',
                  onButtonPressed2: () {
                    Navigator.of(context).pop(true);
                  },
                );
                if (value ?? false) {
                  await PreferenceService().clearSession();
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.splashPage, (route) => false);
                }
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async {
          await truckViewModel.onLoad();
          refreshController.refreshCompleted();
        },
        child: Form(
          key: formKey,
          child: BaseView<TruckViewModel>(onModelReady: (model) {
            truckViewModel = model;
          }, builder: ((context, model, child) {
            if (model.state == ViewState.error) {
              return centerHintText(text: model.errorMessage);
            }
            if (model.state == ViewState.busy && model.truckDetailList == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if ((model.truckDetailList ?? []).isEmpty) {
              return centerHintText(text: 'No Trucks Found');
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.state == ViewState.busy && (model.typeOfCodeList == null))
                    const LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation(Colors.yellow),
                    ),
                  Padding(
                    padding: pageSidePadding,
                    child: Column(
                      children: [
                        formSeperatorBox(),
                        FormQuestionWidget(
                          title: 'Select a Truck',
                          subtitle: model.truckId == null ? 'Please select a truck' : null,
                          child: Column(
                              children: model.truckDetailList!
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Column(children: [
                                        RadioListTile<int>(
                                          contentPadding: const EdgeInsets.all(0),
                                          activeColor: Colors.black,
                                          selected: model.truckId == e.id,
                                          title: Text(e.name),
                                          value: e.id,
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${e.itemsScanned}/${e.totalItems} Items Scanned,",
                                                style: const TextStyle(fontSize: 13),
                                              ),
                                              Text(
                                                "${e.palettesScanned}/${e.totalPalettes} palettes Scanned",
                                                style: const TextStyle(fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          groupValue: model.truckId,
                                          onChanged: (v) {
                                            FocusScope.of(context).requestFocus(FocusNode());

                                            model.updatetruckId(v);
                                          },
                                        ),
                                        LinearProgressIndicator(
                                          backgroundColor: Colors.grey.shade200,
                                          value: e.totalItems != 0 ? (e.itemsScanned / e.totalItems) : 0,
                                          valueColor: AlwaysStoppedAnimation(linearProgressColor(e.totalItems != 0 ? ((e.itemsScanned ~/ e.totalItems) * 100) : 0)),
                                        )
                                      ]),
                                    ),
                                  )
                                  .toList()),
                        ),
                        formSeperatorBox(),
                        if (model.typeOfCodeList != null)
                          FormQuestionWidget(
                            title: 'Type of code',
                            subtitle: model.typeOfCodeId == null ? 'Please select a type of code' : null,
                            child: model.typeOfCodeList!.isEmpty
                                ? centerHintText(text: 'No Type of Code found for truck')
                                : Column(
                                    children: model.typeOfCodeList!
                                        .map(
                                          (e) => RadioListTile<int>(
                                            contentPadding: const EdgeInsets.all(0),
                                            activeColor: AppColors.mainColor,
                                            selected: model.typeOfCodeId == e.id,
                                            title: Text(e.name),
                                            value: e.id,
                                            groupValue: model.typeOfCodeId,
                                            onChanged: (v) {
                                              FocusScope.of(context).requestFocus(FocusNode());
                                              model.updateTypeOfCode(v);
                                            },
                                          ),
                                        )
                                        .toList()),
                          ),
                        formSeperatorBox(),
                        formSeperatorBox(),
                        TextButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            try {
                              if (model.truckId == null || model.typeOfCodeId == null) {
                                return;
                              }
                              if (formKey.currentState!.validate() && model.truckId != null && model.typeOfCodeId != null) {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) => const PalatteNumberPage(title: 'Truck palette Number'),
                                    fullscreenDialog: true,
                                  ),
                                )
                                    .then((value) {
                                  if (value != null) {
                                    Navigator.of(context).pushNamed(
                                      Routes.itemPage,
                                      arguments: {
                                        'paletteNumber': value,
                                        'truckId': model.truckId,
                                        'manifestId': 0,
                                        'typeOfCodeId': model.typeOfCodeId,
                                      },
                                    ).then((value) {
                                      refreshController.requestRefresh();
                                    });
                                  }
                                });
                              }
                            } catch (e) {
                              showErrorToast(e.toString());
                            }
                          },
                          child: const Text('Confirm And Scan Box'),
                        ),
                        formSeperatorBox(),
                        formSeperatorBox(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          })),
        ),
      ),
    );
  }
}
