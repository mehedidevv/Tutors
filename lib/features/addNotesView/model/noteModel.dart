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
    'id': id,
    'title': title,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
  };

  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
    id: map['id'] ?? '',
    title: map['title'] ?? '',
    description: map['description'] ?? '',
    createdAt: DateTime.parse(map['createdAt']),
  );
}