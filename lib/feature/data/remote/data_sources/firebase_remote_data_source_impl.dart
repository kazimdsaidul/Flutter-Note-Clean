import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_note_clean/feature/data/remote/models/note_model.dart';
import 'package:flutter_note_clean/feature/data/remote/models/user_model.dart';
import 'package:flutter_note_clean/feature/domain/entities/color_entity.dart';
import 'package:flutter_note_clean/feature/domain/entities/note_entity.dart';
import 'package:flutter_note_clean/feature/domain/entities/user_entity.dart';

import 'firebase_remote_data_source.dart';

const KEY_USERS = "users";
const KEY_NOTES = "notes";

class FirebaseRemoteDataSourceImpl extends FirebaseRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.firebaseFirestore});

  @override
  Future<void> addNewNote(NoteEntity noteEntity) async {
    final noteCollectionRef = firebaseFirestore
        .collection(KEY_USERS)
        .doc(noteEntity.uid)
        .collection(KEY_NOTES);
    var noteId = noteCollectionRef.doc().id;

    noteCollectionRef.doc(noteId).get().then((note) {
      if (!note.exists) {
        final newNote = NoteModel(
                uid: noteEntity.uid,
                noteID: noteId,
                note: noteEntity.note,
                time: noteEntity.time,
                colorEntity: noteEntity.colorEntity)
            .toDocument();
        noteCollectionRef.doc(noteId).set(newNote);
      }
      return;
    });
  }

  @override
  Future<void> deleteNote(NoteEntity noteEntity) async {
    final noteCollectionRef = firebaseFirestore
        .collection(KEY_USERS)
        .doc(noteEntity.uid)
        .collection(KEY_NOTES);

    noteCollectionRef.doc(noteEntity.noteId).get().then((note) {
      if (note.exists) {
        noteCollectionRef.doc(noteEntity.noteId).delete();
      }
      return;
    });
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity userEntity) async {
    var userCollection = firebaseFirestore.collection(KEY_USERS);
    userCollection.doc(userEntity.uid).get().then((user) async {
      if (user.exists) {
        var uId = await getCurrentUId();
        final newUser = UserModel(
                name: userEntity.name,
                email: userEntity.email,
                uid: uId,
                status: userEntity.status)
            .toDocument();
        userCollection.doc(uId).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUId() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<NoteEntity>> getNotes(String uid) {
    final noteCollectionRef =
        firebaseFirestore.collection(KEY_USERS).doc(uid).collection(KEY_NOTES);
    return noteCollectionRef.snapshots().map((docSnap) {
      return docSnap.docs
          .map((docSnap) => NoteModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Stream<List<ColorEntity>> getColors() {
    final controller = StreamController<List<ColorEntity>>();
    List<ColorEntity> data = [];

    ColorEntity White = ColorEntity("White", "#FFFFFF", true);
    data.add(White);

    ColorEntity redColor = ColorEntity("Red", "#FF0000", false);
    data.add(redColor);

    ColorEntity greenColor = ColorEntity("Green", "#008000", false);
    data.add(greenColor);

    ColorEntity purple = ColorEntity("Purple", "#800080", false);
    data.add(purple);

    controller.add(data);
    return controller.stream;
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signUp(UserEntity user) {
    return firebaseAuth.createUserWithEmailAndPassword(
        email: user.email!, password: user.password!);
  }

  @override
  Future<void> singIn(UserEntity user) {
    return firebaseAuth.signInWithEmailAndPassword(
        email: user.email!, password: user.password!);
  }

  @override
  Future<void> singOut() {
    return firebaseAuth.signOut();
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    Map<String, dynamic> noteMap = Map();
    final noteCollectionRef = firebaseFirestore
        .collection(KEY_USERS)
        .doc(note.uid)
        .collection(KEY_NOTES);

    if (note.note != null) noteMap['note'] = note.note;
    if (note.time != null) noteMap['time'] = note.time;

    noteCollectionRef.doc(note.noteId).update(noteMap);
  }
}
