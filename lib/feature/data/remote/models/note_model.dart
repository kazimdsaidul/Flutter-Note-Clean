import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_note_clean/feature/domain/entities/color_entity.dart';
import 'package:flutter_note_clean/feature/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  NoteModel(
      {final String? noteID,
      final String? note,
      final Timestamp? time,
      final String? uid,
      final ColorEntity? colorEntity})
      : super(
            noteId: noteID,
            note: note,
            time: time,
            uid: uid,
            colorEntity: colorEntity);

  factory NoteModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return NoteModel(
        noteID: documentSnapshot.get('noteID'),
        note: documentSnapshot.get('note'),
        time: documentSnapshot.get('time'),
        uid: documentSnapshot.get('uid'),
        colorEntity:
            ColorEntity.fromJson(jsonDecode(documentSnapshot.get('color'))));
  }

  Map<String, dynamic> toDocument() {
    return {
      "noteID": noteId,
      "note": note,
      "time": time,
      "uid": uid,
      "color": jsonEncode(colorEntity)
    };
  }
}
