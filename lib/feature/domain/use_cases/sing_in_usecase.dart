import 'package:flutter_note_clean/feature/domain/entities/user_entity.dart';
import 'package:flutter_note_clean/feature/domain/repositories/firebase_repository.dart';

class SignInUseCase {
  final FirebaseRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) async {
    return repository.singIn(userEntity);
  }
}
