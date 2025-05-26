import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simplenotepad/app/data/models/note_tag_model.dart'; // Pastikan path ini benar

class NoteModel {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<NoteTag> tags; 
  
  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.tags = const [],
  });

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception("Data catatan kosong untuk ID: ${doc.id}");
    }

    return NoteModel(
      id: doc.id,
      title: data['title'] as String,
      content: data['content'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      tags: (data['tags'] as List<dynamic>?)
              ?.map((tagString) => NoteTag.fromString(tagString as String))
              .toList() ??
          const [], // Jika 'tags' null atau tidak ada, kembalikan list kosong
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'tags': tags.map((tag) => tag.name).toList(),
    };
  }

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<NoteTag>? tags, // Tipe data List<NoteTag>?
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
    );
  }
}
