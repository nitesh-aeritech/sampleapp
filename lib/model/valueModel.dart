import 'dart:convert';

class ValueModel {
  final int id;
  final int? dependentId;
  final String name;
  ValueModel({
    required this.id,
    this.dependentId,
    required this.name,
  });

  ValueModel copyWith({
    int? id,
    int? dependentId,
    String? name,
  }) {
    return ValueModel(
      id: id ?? this.id,
      dependentId: dependentId ?? this.dependentId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dependentId': dependentId,
      'name': name,
    };
  }

  factory ValueModel.fromMap(Map<String, dynamic> map) {
    return ValueModel(
      id: map['id']?.toInt() ?? 0,
      dependentId: map['dependentId']?.toInt(),
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ValueModel.fromJson(String source) => ValueModel.fromMap(json.decode(source));

  @override
  String toString() => 'ValueModel(id: $id, dependentId: $dependentId, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueModel && other.id == id && other.dependentId == dependentId && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ dependentId.hashCode ^ name.hashCode;
}
