import 'package:cloud_firestore/cloud_firestore.dart';

class NoteEntity {
  final String? noteId;
  final String? note;
  final Timestamp? time;
  final String? uid;

  NoteEntity({this.noteId, this.note, this.time, this.uid});
}
