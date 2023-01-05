import 'dart:convert';

class Manifest {
  final int id;
  final String storeName;
  final int truckId;
  final String truckName;
  final String creationDate;
  final String remarks;
  final int numberOfItems;
  final int itemsFoundInManifest;
  final int itemsNotFoundInManifest;
  Manifest({
    required this.id,
    required this.storeName,
    required this.truckId,
    required this.truckName,
    required this.creationDate,
    required this.remarks,
    required this.numberOfItems,
    required this.itemsFoundInManifest,
    required this.itemsNotFoundInManifest,
  });

  Manifest copyWith({
    int? id,
    String? storeName,
    int? truckId,
    String? truckName,
    String? creationDate,
    String? remarks,
    int? numberOfItems,
    int? itemsFoundInManifest,
    int? itemsNotFoundInManifest,
  }) {
    return Manifest(
      id: id ?? this.id,
      storeName: storeName ?? this.storeName,
      truckId: truckId ?? this.truckId,
      truckName: truckName ?? this.truckName,
      creationDate: creationDate ?? this.creationDate,
      remarks: remarks ?? this.remarks,
      numberOfItems: numberOfItems ?? this.numberOfItems,
      itemsFoundInManifest: itemsFoundInManifest ?? this.itemsFoundInManifest,
      itemsNotFoundInManifest:
          itemsNotFoundInManifest ?? this.itemsNotFoundInManifest,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storeName': storeName,
      'truckId': truckId,
      'truckName': truckName,
      'creationDate': creationDate,
      'remarks': remarks,
      'numberOfItems': numberOfItems,
      'itemsFoundInManifest': itemsFoundInManifest,
      'itemsNotFoundInManifest': itemsNotFoundInManifest,
    };
  }

  factory Manifest.fromMap(Map<String, dynamic> map) {
    return Manifest(
      id: map['id']?.toInt() ?? 0,
      storeName: map['storeName'] ?? '',
      truckId: map['truckId']?.toInt() ?? 0,
      truckName: map['truckName'] ?? '',
      creationDate: map['creationDate'] ?? '',
      remarks: map['remarks'] ?? '',
      numberOfItems: map['numberOfItems']?.toInt() ?? 0,
      itemsFoundInManifest: map['itemsFoundInManifest']?.toInt() ?? 0,
      itemsNotFoundInManifest: map['itemsNotFoundInManifest']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Manifest.fromJson(String source) =>
      Manifest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Manifest(id: $id, storeName: $storeName, truckId: $truckId, truckName: $truckName, creationDate: $creationDate, remarks: $remarks, numberOfItems: $numberOfItems, itemsFoundInManifest: $itemsFoundInManifest, itemsNotFoundInManifest: $itemsNotFoundInManifest)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Manifest &&
        other.id == id &&
        other.storeName == storeName &&
        other.truckId == truckId &&
        other.truckName == truckName &&
        other.creationDate == creationDate &&
        other.remarks == remarks &&
        other.numberOfItems == numberOfItems &&
        other.itemsFoundInManifest == itemsFoundInManifest &&
        other.itemsNotFoundInManifest == itemsNotFoundInManifest;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        storeName.hashCode ^
        truckId.hashCode ^
        truckName.hashCode ^
        creationDate.hashCode ^
        remarks.hashCode ^
        numberOfItems.hashCode ^
        itemsFoundInManifest.hashCode ^
        itemsNotFoundInManifest.hashCode;
  }
}
