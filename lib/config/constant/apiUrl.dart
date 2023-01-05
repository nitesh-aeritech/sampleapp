// ignore_for_file: file_names

class ApiUrl {
  static bool isDevEnv = false;
  static String baseUrl =
      // 'http://warehouse.qubex.info.np/api/';
      'https://api.thewarehousekc.com/api/';

  ///[Auth]
  static const String loginUser = 'auth/login';

  ///[Truck]
  static const String truckList = 'trucks/available';
  static const String itemCoditionList = 'general/item-conditions';
  static String typeOfCodeList(int truckId) => 'codes/store/$truckId';
  static String truckManifest(int truckId) => 'manifest/truck/$truckId';
  static String itemManifest(int manifestId, String itemCode) => 'manifest/$manifestId/item/$itemCode';
  static const String addItem = 'manifest/add-item';
  static String isTruckExists(String truckPalletteNumber) => 'truck/palette/$truckPalletteNumber';
  static const String updateTruckpalette = 'manifest/update-palette';
  static const String submitTruck = 'truck/complete';
}
