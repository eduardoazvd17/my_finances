import 'package:equatable/equatable.dart';

import '../enums/document_type.dart';

class DocumentModel extends Equatable {
  final String id;
  final String name;
  final String ownerId;
  final DateTime creationDate;
  final DateTime lastEditDate;
  final DocumentType type;
  final bool isFavorite;

  const DocumentModel({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.creationDate,
    required this.lastEditDate,
    required this.type,
    required this.isFavorite,
  });

  DocumentModel copyWith({
    String? id,
    String? name,
    DateTime? lastEditDate,
    bool? isFavorite,
  }) {
    return DocumentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId,
      creationDate: creationDate,
      lastEditDate: lastEditDate ?? this.lastEditDate,
      type: type,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ownerId': ownerId,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'lastEditDate': lastEditDate.millisecondsSinceEpoch,
      'type': type.index,
      'isFavorite': isFavorite,
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      id: map['id'],
      name: map['name'],
      ownerId: map['ownerId'],
      creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
      lastEditDate: DateTime.fromMillisecondsSinceEpoch(map['lastEditDate']),
      type: DocumentType.values[map['type']],
      isFavorite: map['isFavorite'],
    );
  }

  @override
  List<Object?> get props => [id];
}
