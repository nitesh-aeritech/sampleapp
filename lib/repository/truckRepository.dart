import 'package:thewarehouse/config/constant/apiUrl.dart';
import 'package:thewarehouse/model/demo.dart';
import 'package:thewarehouse/services/core/httpService.dart';

abstract class TruckRepository {
  Future<List<dynamic>> getTruckDetailList();
  Future<dynamic> getTruckManifest(int storeId);
  Future<List<dynamic>> getStoreCodeType(int storeId);
  Future<dynamic> isTruckExists(String truckPallateNumber);
  Future<void> updatepaletteNumber(int manifestId, String truckpaletteNumber);
  Future<dynamic> submitTruckId(int manifestId, int truckId);
}

class TruckRepositoryImp implements TruckRepository {
  final HttpService httpService;
  TruckRepositoryImp(this.httpService);

  @override
  Future<List<dynamic>> getTruckDetailList() async {
    try {
      final List<dynamic> data = await httpService.getData(ApiUrl.truckList);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getTruckManifest(int storeId) async {
    try {
      final dynamic data = await httpService.getData(ApiUrl.truckManifest(storeId));
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> getStoreCodeType(int storeId) async {
    try {
      final List<dynamic> data = await httpService.getData(ApiUrl.typeOfCodeList(storeId));
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> isTruckExists(String truckPallateNumber) async {
    try {
      final dynamic data = await httpService.getData(ApiUrl.isTruckExists(truckPallateNumber));
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatepaletteNumber(int manifestId, String truckpaletteNumber) async {
    try {
      await httpService.postDataJson(ApiUrl.updateTruckpalette, data: {
        'manifestId': manifestId,
        'truckPaletteNumber': truckpaletteNumber,
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> submitTruckId(int manifestId, int truckId) async {
    try {
      return await httpService.postDataJson(
        ApiUrl.submitTruck,
        data: {
          'manifestId': manifestId,
          'truckId': truckId,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
