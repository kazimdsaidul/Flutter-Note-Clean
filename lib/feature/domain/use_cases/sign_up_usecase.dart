import 'package:flutter_note_clean/feature/domain/entities/user_entity.dart';
import 'package:flutter_note_clean/feature/domain/repositories/firebase_repository.dart';

class SignUPUseCase {
  final FirebaseRepository repository;

  SignUPUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.signUp(user);
  }
}
