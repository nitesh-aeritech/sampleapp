import 'package:thewarehouse/config/constant/apiUrl.dart';
import 'package:thewarehouse/services/core/httpService.dart';

abstract class ItemRepository {
  Future<List<dynamic>> getItemCondition();
  Future<dynamic> getManifestOfItem(int manifestId, String itemCode);
  Future<dynamic> addItem(int manifestId, String code, String sku, int itemConditionType, String paletteNumber, String warehousepaletteNumber, String? additionalData);
}

class ItemRepositoryImp implements ItemRepository {
  final HttpService httpService;
  ItemRepositoryImp(this.httpService);

  @override
  Future<List<dynamic>> getItemCondition() async {
    try {
      final data = await httpService.getData(ApiUrl.itemCoditionList);
      return data as List<dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getManifestOfItem(int manifestId, String itemCode) async {
    try {
      final dynamic data = await httpService.getData(ApiUrl.itemManifest(manifestId, itemCode));
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> addItem(int manifestId, String code, String sku, int itemConditionType, String paletteNumber, String warehousepaletteNumber, String? additionalData) async {
    try {
      final dynamic data = await httpService.postDataJson(
        ApiUrl.addItem,
        data: {
          "manifestId": manifestId,
          "code": code,
          "sku": sku,
          "itemConditionId": itemConditionType,
          "warehousePaletteNumber": warehousepaletteNumber,
          "paletteNumber": paletteNumber,
          "additionalData": additionalData,
        },
      );
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
