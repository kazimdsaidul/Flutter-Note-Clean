import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_note_clean/feature/domain/entities/color_entity.dart';

class NoteEntity {
  final String? noteId;
  final String? note;
  final Timestamp? time;
  final String? uid;
  final ColorEntity? colorEntity;

  NoteEntity({this.colorEntity, this.noteId, this.note, this.time, this.uid});
}
