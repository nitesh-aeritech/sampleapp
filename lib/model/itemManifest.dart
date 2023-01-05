import 'dart:convert';

class ItemManifest {
  final int id;
  final String name;
  final String description;
  final int unit;
  final double storePrice;
  final String code;
  final String sku;
  ItemManifest({
    required this.id,
    required this.name,
    required this.description,
    required this.unit,
    required this.storePrice,
    required this.code,
    required this.sku,
  });

  ItemManifest copyWith({
    int? id,
    String? name,
    String? description,
    int? unit,
    double? storePrice,
    String? code,
    String? sku,
  }) {
    return ItemManifest(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      storePrice: storePrice ?? this.storePrice,
      code: code ?? this.code,
      sku: sku ?? this.sku,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'unit': unit,
      'storePrice': storePrice,
      'code': code,
      'sku': sku,
    };
  }

  factory ItemManifest.fromMap(Map<String, dynamic> map) {
    return ItemManifest(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      unit: map['unit']?.toInt() ?? 0,
      storePrice: map['storePrice']?.toDouble() ?? 0.0,
      code: map['code'] ?? '',
      sku: map['sku'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemManifest.fromJson(String source) => ItemManifest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemManifest(id: $id, name: $name, description: $description, unit: $unit, storePrice: $storePrice, code: $code, sku: $sku)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemManifest &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.unit == unit &&
        other.storePrice == storePrice &&
        other.code == code &&
        other.sku == sku;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ unit.hashCode ^ storePrice.hashCode ^ code.hashCode ^ sku.hashCode;
  }
}
