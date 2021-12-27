import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_note_clean/feature/domain/entities/color_entity.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/get_color_usecase.dart';

part 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  final GetColorUseCase getColorUseCase;

  List<ColorEntity> _tempColorData = [];

  ColorCubit({required this.getColorUseCase}) : super(ColorInitial());

  Future<void> getColors() async {
    try {
      getColorUseCase.call().listen((notes) {
        _tempColorData = notes;
        emit(ColorLoaded(notes: notes));
      });
    } on SocketException catch (_) {
      emit(ColorFailure());
    } catch (_) {
      emit(ColorFailure());
    }
  }

  void seltedColors(int index) {
    var _selectedItem = _tempColorData[index];

    _tempColorData.forEach((element) {
      element.isSeleted = false;
    });

    if (_selectedItem.isSeleted) {
      _selectedItem.isSeleted = false;
    } else {
      _selectedItem.isSeleted = true;
    }

    _tempColorData[index] = _selectedItem;
    emit(ColorLoaded(notes: _tempColorData));

    // emit(ColorSeleted(_selectedItem));
  }
}
