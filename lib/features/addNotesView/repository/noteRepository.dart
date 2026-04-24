// lib/features/notes/data/repositories/note_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/noteModel.dart';

class NoteRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference get _notesRef =>
      _firestore.collection('users').doc(_uid).collection('notes');

  Future<void> addNote({
    required String title,
    required String description,
  }) async {
    final docRef = _notesRef.doc();
    final note = NoteModel(
      id: docRef.id,
      title: title.trim(),
      description: description.trim(),
      createdAt: DateTime.now(),
    );
    await docRef.set(note.toMap());
  }
}