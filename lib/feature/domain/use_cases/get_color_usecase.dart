import 'package:flutter_note_clean/feature/domain/entities/color_entity.dart';
import 'package:flutter_note_clean/feature/domain/repositories/firebase_repository.dart';

class GetColorUseCase {
  final FirebaseRepository repository;

  GetColorUseCase({required this.repository});

  Stream<List<ColorEntity>> call() {
    return repository.getColors();
  }
}
