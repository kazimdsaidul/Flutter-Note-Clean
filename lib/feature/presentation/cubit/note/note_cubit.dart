import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_note_clean/feature/domain/entities/note_entity.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/add_new_note_usecase.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/delete_note_usecase.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/get_notes_usecase.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/update_note_usecase.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final UpdateNoteUseCase updateNoteUseCase;
  final AddNewNoteUseCase addNewNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetNotesUseCase getNotesUseCase;

  NoteCubit(
      {required this.updateNoteUseCase,
      required this.addNewNoteUseCase,
      required this.deleteNoteUseCase,
      required this.getNotesUseCase})
      : super(NoteInitial());

  Future<void> addNote({required NoteEntity noteEntity}) async {
    try {
      await addNewNoteUseCase.call(noteEntity);
    } on SocketException catch (_) {
      emit(NoteNoInternetFailure());
    } catch (_) {
      emit(NoteFailure());
    }
  }

  Future<void> deleteNote({required NoteEntity noteEntity}) async {
    try {
      await deleteNoteUseCase.call(noteEntity);
    } on SocketException catch (_) {
      emit(NoteNoInternetFailure());
    } catch (_) {
      emit(NoteFailure());
    }
  }

  Future<void> updateNoteNote({required NoteEntity noteEntity}) async {
    try {
      await updateNoteUseCase.call(noteEntity);
    } on SocketException catch (_) {
      emit(NoteNoInternetFailure());
    } catch (_) {
      emit(NoteFailure());
    }
  }

  Future<void> getNoteNotes({required String uid}) async {
    emit(NoteLoading());
    try {
      getNotesUseCase.call(uid).listen((event) {
        emit(NoteLoaded(notes: event));
      });
    } on SocketException catch (_) {
      emit(NoteNoInternetFailure());
    } catch (_) {
      emit(NoteFailure());
    }
  }
}
