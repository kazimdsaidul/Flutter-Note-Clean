import 'dart:async';

import 'package:flutter_note_clean/feature/domain/entities/note_entity.dart';
import 'package:flutter_note_clean/feature/domain/entities/user_entity.dart';

abstract class FirebaseRepository {
  // user
  Future<bool> isSignIn();

  Future<void> singIn(UserEntity user);

  Future<void> signUp(UserEntity user);

  Future<void> singOut();

  Future<String> getCurrentUId();

  Future<void> getCreateCurrentUser(UserEntity user);

  // note
  Future<void> addNewNote(NoteEntity note);

  Future<void> updateNote(NoteEntity note);

  Future<void> deleteNote(NoteEntity note);

  Stream<List<NoteEntity>> getNotes(String uid);
}
