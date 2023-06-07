import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final int id;
  final String name;

  Item({required this.id, required this.name});
  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Item copyWith({
    int? id,
    String? name,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  factory Item.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Item(
      id: data['id'],
      name: data['name'],
    );
  }
  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
