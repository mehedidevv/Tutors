// lib/features/notes/data/models/note_model.dart
class NoteModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
  };
}