import 'dart:convert';

class TypeOfCode {
  final int id;
  final String name;
  final bool isSelected;

  TypeOfCode({
    required this.id,
    required this.name,
    required this.isSelected,
  });

  TypeOfCode copyWith({
    int? id,
    String? name,
    bool? isSelected,
  }) {
    return TypeOfCode(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isSelected': isSelected,
    };
  }

  factory TypeOfCode.fromMap(Map<String, dynamic> map) {
    return TypeOfCode(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      isSelected: map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeOfCode.fromJson(String source) => TypeOfCode.fromMap(json.decode(source));

  @override
  String toString() => 'TypeOfCode(id: $id, name: $name, isSelected: $isSelected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TypeOfCode &&
      other.id == id &&
      other.name == name &&
      other.isSelected == isSelected;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isSelected.hashCode;
}
