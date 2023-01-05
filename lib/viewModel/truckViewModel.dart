import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:thewarehouse/config/enum/enum.dart';
import 'package:thewarehouse/model/manifest.dart';
import 'package:thewarehouse/model/truckDetail.dart';
import 'package:thewarehouse/model/typeOfCode.dart';
import 'package:thewarehouse/model/valueModel.dart';
import 'package:thewarehouse/services/itemService.dart';
import 'package:thewarehouse/services/truckService.dart';
import 'package:thewarehouse/services/userService.dart';
import 'package:thewarehouse/viewModel/core/baseViewModel.dart';

class TruckViewModel extends BaseViewModel {
  final TruckService truckService;
  final ItemService itemService;
  int? truckId;
  int? typeOfCodeId;
  // String? paletteNumber;
  List<TruckDetail>? truckDetailList;
  List<TypeOfCode>? typeOfCodeList;
  // Manifest? manifest;
  TruckViewModel(this.truckService, this.itemService) {
    onLoad();
  }

  onLoad() async {
    try {
      await getTruckDetails();
      updateState(ViewState.idle);
    } catch (e) {
      errorMessage = e.toString();
      updateState(ViewState.error);
    }
  }

  updateTypeOfCode(int? value) {
    typeOfCodeId = value;
    setState();
  }

  updatetruckId(int? id) {
    truckId = id;
    updateState(ViewState.busy);
    final value = truckDetailList!.firstWhere((element) => element.id == id);
    Future.wait([getTypeOfCodeList(value.storeId)], eagerError: false)
        .then((value) {
      updateState(ViewState.idle);
    });
  }

  // updatePaletteNumber(String? paletteNumber) {
  //   this.paletteNumber = paletteNumber;
  //   setState();
  // }

  // updatetruckId(int? id) async {
  //   truckId = id;
  //   setState();
  //   if (id == null) {
  //     updateTypeOfCode(null);
  //   } else {
  //     final value = truckDetailList!.firstWhere((element) => element.id == id);
  //     typeOfCodeList = null;
  //     manifest = null;
  //     updateState(ViewState.busy);
  //     Future.wait([getTypeOfCodeList(value.storeId), getTruckManifestData()], eagerError: false).then((value) {
  //       updateState(ViewState.idle);
  //     });

  //     // .then((value1) => updateTypeOfCode(value.storeId));
  //     // updateTypeOfCode(value.typeOfCodeId);
  //   }
  //   // updateTruckId(null);
  //   // setState();
  // }

  Future<void> getTruckDetails() async {
    try {
      truckDetailList = await truckService.getTruckDetailList();
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> getTruckManifestData() async {
  //   if (truckId == null) return;
  //   try {
  //     manifest = await truckService.getTruckManifest(truckId!);
  //   } catch (e) {
  //     print('d');
  //   }
  // }

  Future<void> getTypeOfCodeList(int storeId) async {
    try {
      typeOfCodeList = await truckService.getTypeOfCodeList(storeId);
      try {
        final value =
            typeOfCodeList!.firstWhere((element) => element.isSelected);
        updateTypeOfCode(value.id);
      } catch (e) {
        updateTypeOfCode(null);
      }
    } catch (e) {
      typeOfCodeList = [];
    }
  }
}
