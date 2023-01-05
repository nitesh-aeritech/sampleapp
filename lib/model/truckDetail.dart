import 'dart:convert';

class TruckDetail {
  final int id;
  final String name;
  final int storeId;
  final int itemsScanned;
  final int totalItems;
  final int palettesScanned;
  final int totalPalettes;
  TruckDetail({
    required this.id,
    required this.name,
    required this.storeId,
    required this.itemsScanned,
    required this.totalItems,
    required this.palettesScanned,
    required this.totalPalettes,
  });

  TruckDetail copyWith({
    int? id,
    String? name,
    int? storeId,
    int? itemsScanned,
    int? totalItems,
    int? palettesScanned,
    int? totalPalettes,
  }) {
    return TruckDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      storeId: storeId ?? this.storeId,
      itemsScanned: itemsScanned ?? this.itemsScanned,
      totalItems: totalItems ?? this.totalItems,
      palettesScanned: palettesScanned ?? this.palettesScanned,
      totalPalettes: totalPalettes ?? this.totalPalettes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'storeId': storeId,
      'itemsScanned': itemsScanned,
      'totalItems': totalItems,
      'palettesScanned': palettesScanned,
      'totalPalettes': totalPalettes,
    };
  }

  factory TruckDetail.fromMap(Map<String, dynamic> map) {
    return TruckDetail(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      storeId: map['storeId']?.toInt() ?? 0,
      itemsScanned: map['itemsScanned']?.toInt() ?? 0,
      totalItems: map['totalItems']?.toInt() ?? 0,
      palettesScanned: map['palettesScanned']?.toInt() ?? 0,
      totalPalettes: map['totalPalettes']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TruckDetail.fromJson(String source) =>
      TruckDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TruckDetail(id: $id, name: $name, storeId: $storeId, itemsScanned: $itemsScanned, totalItems: $totalItems, palettesScanned: $palettesScanned, totalPalettes: $totalPalettes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TruckDetail &&
        other.id == id &&
        other.name == name &&
        other.storeId == storeId &&
        other.itemsScanned == itemsScanned &&
        other.totalItems == totalItems &&
        other.palettesScanned == palettesScanned &&
        other.totalPalettes == totalPalettes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        storeId.hashCode ^
        itemsScanned.hashCode ^
        totalItems.hashCode ^
        palettesScanned.hashCode ^
        totalPalettes.hashCode;
  }
}
