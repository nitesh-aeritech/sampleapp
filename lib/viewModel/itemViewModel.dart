import 'package:flutter/cupertino.dart';
import 'package:thewarehouse/config/enum/enum.dart';
import 'package:thewarehouse/config/helper/uiHelpers.dart';
import 'package:thewarehouse/model/itemManifest.dart';
import 'package:thewarehouse/model/manifest.dart';
import 'package:thewarehouse/model/valueModel.dart';
import 'package:thewarehouse/services/itemService.dart';
import 'package:thewarehouse/services/truckService.dart';
import 'package:thewarehouse/services/userService.dart';
import 'package:thewarehouse/viewModel/core/baseViewModel.dart';

class ItemViewModel extends BaseViewModel {
  final ItemService itemService;
  final TruckService truckService;
  late final int truckId, typeOfCodeId;
  ItemViewModel(this.itemService, this.truckService);
  // String? codeInBox, internalSkuNumber;
  TextEditingController codeInBoxController = TextEditingController();
  TextEditingController additionalDataController = TextEditingController();
  TextEditingController internalSkuNumberController = TextEditingController();
  int? itemConditionId;
  List<ValueModel>? itemConditionList;
  bool isItemManifestFetching = false;
  ItemManifest? manifest;
  Manifest? truckManifest;
  String? _palletteNumber, _warehousePalletteNumber;
  bool? doesTruckPallateNumberExists;

  initializeValue(String paletteNumber, int truckId, int typeOfCodeId) async {
    this.truckId = truckId;
    this.typeOfCodeId = typeOfCodeId;

    await Future.wait([getItemConditionList(), getTruckManifest()]);
    try {
      await updatePalletteNumber(paletteNumber);
    } catch (e) {
      showErrorToast(e.toString());
    }
    updateState(ViewState.idle);
  }

  String? get palletteNumber => _palletteNumber;

  String? get warehousePalletteNumber => _warehousePalletteNumber;

  updateItemCondition(int? itemConditionId) {
    this.itemConditionId = itemConditionId;
    setState();
  }

  _updateCodeInBox(String? codeInBox) {
    codeInBoxController.text = codeInBox ?? '';
    setState();
  }

  updateInternalSkuNumber(String? internalSkuNumber) {
    internalSkuNumberController.text = internalSkuNumber ?? '';
    setState();
  }

  Future<void> getItemConditionList() async {
    try {
      itemConditionList = await itemService.getItemConditionList();
    } catch (e) {
      itemConditionList = [];
    }
  }

  Future<void> getTruckManifest() async {
    try {
      truckManifest = await truckService.getTruckManifest(truckId);
      updateState(state);
    } catch (e) {
      //
    }
  }

  Future<void> getItemCodeManifest() async {
    if (codeInBoxController.text.isEmpty || truckManifest == null) return;
    try {
      isItemManifestFetching = true;
      manifest = null;
      updateInternalSkuNumber(null);
      manifest = await itemService.getManifestOfItem(truckManifest!.id, codeInBoxController.text);
      _updateCodeInBox(manifest!.code);
      updateInternalSkuNumber(manifest!.sku);
    } catch (e) {
      //
    }
    isItemManifestFetching = false;
    updateState(ViewState.idle);
  }

  Future<void> updatePalletteNumber(String palletteNumber) async {
    try {
      if (truckManifest?.id == null) throw ("Truck Manifest not found, Please try again");
      if (_palletteNumber != palletteNumber) {
        try {
          await truckService.updatepaletteNumber(truckManifest!.id, palletteNumber);
        } catch (e) {
          showErrorToast(e.toString());
        }
      }
      _palletteNumber = palletteNumber;
      isTruckExists();
    } catch (e) {
      rethrow;
    }
  }

  void updateWarehousePalletteNumber(String warehousePalletteNumber) {
    _warehousePalletteNumber = warehousePalletteNumber;
  }

  Future<void> addItem() async {
    try {
      await itemService.addItem(
        truckManifest!.id,
        codeInBoxController.text,
        internalSkuNumberController.text,
        itemConditionId!,
        palletteNumber!,
        warehousePalletteNumber!,
        additionalDataController.text,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> submitTruck() async {
    try {
      return await truckService.submitTruck(truckManifest!.id, truckId);
    } catch (e) {
      rethrow;
    }
  }

  void isTruckExists() async {
    try {
      doesTruckPallateNumberExists = null;
      doesTruckPallateNumberExists = await truckService.isTruckExists(palletteNumber ?? '');
    } catch (e) {
      doesTruckPallateNumberExists = false;
    }
  }

  clearData() async {
    codeInBoxController.clear();
    internalSkuNumberController.clear();
    manifest = null;
    itemConditionId = null;
    truckManifest = null;
    isItemManifestFetching = false;
    additionalDataController.clear();
    updateState(ViewState.busy);
    await getItemConditionList();
    await getTruckManifest();
    updateState(ViewState.idle);
  }
}
