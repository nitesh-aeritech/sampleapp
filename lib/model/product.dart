import 'dart:convert';

class Product {
  final int id;
  final int truckId;
  final String typeOfCode;
  final String? otherNumber;
  final String codeInBox;
  final String internalSkuNumber;
  final String paletteNumber;
  final int itemConditionId;
  Product({
    required this.id,
    required this.truckId,
    required this.typeOfCode,
    this.otherNumber,
    required this.codeInBox,
    required this.internalSkuNumber,
    required this.paletteNumber,
    required this.itemConditionId,
  });

  Product copyWith({
    int? id,
    int? truckId,
    String? typeOfCode,
    String? otherNumber,
    String? codeInBox,
    String? internalSkuNumber,
    String? paletteNumber,
    int? itemConditionId,
  }) {
    return Product(
      id: id ?? this.id,
      truckId: truckId ?? this.truckId,
      typeOfCode: typeOfCode ?? this.typeOfCode,
      otherNumber: otherNumber ?? this.otherNumber,
      codeInBox: codeInBox ?? this.codeInBox,
      internalSkuNumber: internalSkuNumber ?? this.internalSkuNumber,
      paletteNumber: paletteNumber ?? this.paletteNumber,
      itemConditionId: itemConditionId ?? this.itemConditionId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'truckId': truckId,
      'typeOfCode': typeOfCode,
      'otherNumber': otherNumber,
      'codeInBox': codeInBox,
      'internalSkuNumber': internalSkuNumber,
      'paletteNumber': paletteNumber,
      'itemConditionId': itemConditionId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      truckId: map['truckId']?.toInt() ?? 0,
      typeOfCode: map['typeOfCode'] ?? '',
      codeInBox: map['codeInBox'] ?? '',
      internalSkuNumber: map['internalSkuNumber'] ?? '',
      paletteNumber: map['paletteNumber'] ?? '',
      itemConditionId: map['itemConditionId']?.toInt() ?? 0,
      otherNumber: map['otherNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, truckId: $truckId, typeOfCode: $typeOfCode, otherNumber: $otherNumber, codeInBox: $codeInBox, internalSkuNumber: $internalSkuNumber, paletteNumber: $paletteNumber, itemConditionId: $itemConditionId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.truckId == truckId &&
        other.typeOfCode == typeOfCode &&
        other.otherNumber == otherNumber &&
        other.codeInBox == codeInBox &&
        other.internalSkuNumber == internalSkuNumber &&
        other.paletteNumber == paletteNumber &&
        other.itemConditionId == itemConditionId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ truckId.hashCode ^ typeOfCode.hashCode ^ otherNumber.hashCode ^ codeInBox.hashCode ^ internalSkuNumber.hashCode ^ paletteNumber.hashCode ^ itemConditionId.hashCode;
  }
}
