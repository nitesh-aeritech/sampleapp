import 'package:thewarehouse/model/manifest.dart';
import 'package:thewarehouse/model/truckDetail.dart';
import 'package:thewarehouse/model/typeOfCode.dart';
import 'package:thewarehouse/model/valueModel.dart';

import 'package:thewarehouse/repository/truckRepository.dart';
import 'package:thewarehouse/repository/userRepository.dart';
import 'package:thewarehouse/services/core/preferenceService.dart';

class TruckService {
  final TruckRepository truckRepository;

  final PreferenceService preferenceService = PreferenceService();
  TruckService(
    this.truckRepository,
  );
  Future<List<TruckDetail>> getTruckDetailList() async {
    try {
      final List<dynamic> data = await truckRepository.getTruckDetailList();
      return data.map((e) => TruckDetail.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TypeOfCode>> getTypeOfCodeList(int storeId) async {
    try {
      final List<dynamic> data = await truckRepository.getStoreCodeType(storeId);
      return data.map((e) => TypeOfCode.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Manifest> getTruckManifest(int truckId) async {
    try {
      final dynamic data = await truckRepository.getTruckManifest(truckId);
      return Manifest.fromMap(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isTruckExists(String truckpaletteNumber) async {
    try {
      final dynamic data = await truckRepository.isTruckExists(truckpaletteNumber);
      return data as bool;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatepaletteNumber(int manifestId, String truckpaletteNumber) async {
    try {
      await truckRepository.updatepaletteNumber(manifestId, truckpaletteNumber);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> submitTruck(int manifestId, int truckId) async {
    try {
      return (await truckRepository.submitTruckId(manifestId, truckId)).toString();
    } catch (e) {
      rethrow;
    }
  }
}
