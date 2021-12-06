import 'package:cloud_firestore/cloud_firestore.dart';

class NoteEntity {
  final String? noteID;
  final String? note;
  final Timestamp? time;
  final String? uid;

  NoteEntity({this.noteID, this.note, this.time, this.uid});
}
