import 'package:flutter_note_clean/feature/data/remote/data_sources/firebase_remote_data_source.dart';
import 'package:flutter_note_clean/feature/domain/entities/color_entity.dart';
import 'package:flutter_note_clean/feature/domain/entities/note_entity.dart';
import 'package:flutter_note_clean/feature/domain/entities/user_entity.dart';
import 'package:flutter_note_clean/feature/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;

  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<void> addNewNote(NoteEntity note) {
    return firebaseRemoteDataSource.addNewNote(note);
  }

  @override
  Future<void> deleteNote(NoteEntity note) {
    return firebaseRemoteDataSource.deleteNote(note);
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) {
    return firebaseRemoteDataSource.getCreateCurrentUser(user);
  }

  @override
  Future<String> getCurrentUId() {
    return firebaseRemoteDataSource.getCurrentUId();
  }

  @override
  Stream<List<NoteEntity>> getNotes(String uid) {
    return firebaseRemoteDataSource.getNotes(uid);
  }

  @override
  Future<bool> isSignIn() {
    return firebaseRemoteDataSource.isSignIn();
  }

  @override
  Future<void> signUp(UserEntity user) {
    return firebaseRemoteDataSource.signUp(user);
  }

  @override
  Future<void> singIn(UserEntity user) {
    return firebaseRemoteDataSource.singIn(user);
  }

  @override
  Future<void> singOut() {
    return firebaseRemoteDataSource.singOut();
  }

  @override
  Future<void> updateNote(NoteEntity note) {
    return firebaseRemoteDataSource.updateNote(note);
  }

  @override
  Stream<List<ColorEntity>> getColors() {
    return firebaseRemoteDataSource.getColors();
  }
}
