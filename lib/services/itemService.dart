import 'package:thewarehouse/model/itemManifest.dart';
import 'package:thewarehouse/model/manifest.dart';
import 'package:thewarehouse/model/valueModel.dart';
import 'package:thewarehouse/repository/itemRepository.dart';
import 'package:thewarehouse/repository/truckRepository.dart';
import 'package:thewarehouse/repository/userRepository.dart';
import 'package:thewarehouse/services/core/preferenceService.dart';

class ItemService {
  final ItemRepository itemRepository;

  final PreferenceService preferenceService = PreferenceService();
  ItemService(
    this.itemRepository,
  );
  Future<List<ValueModel>> getItemConditionList() async {
    try {
      final List<dynamic> data = await itemRepository.getItemCondition();
      return data.map((e) => ValueModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<ItemManifest> getManifestOfItem(
      int manifestId, String itemCode) async {
    try {
      final dynamic data =
          await itemRepository.getManifestOfItem(manifestId, itemCode);
      return ItemManifest.fromMap(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addItem(
      int manifestId,
      String code,
      String sku,
      int itemConditionType,
      String paletteNumber,
      String warehousepaletteNumber,
      String? additionalData) async {
    try {
      final value = await itemRepository.addItem(
        manifestId,
        code,
        sku,
        itemConditionType,
        paletteNumber,
        warehousepaletteNumber,
        additionalData,
      );
    } catch (e) {
      rethrow;
    }
  }
}
