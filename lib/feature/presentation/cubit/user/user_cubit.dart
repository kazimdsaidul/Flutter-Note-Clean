import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_note_clean/feature/domain/entities/user_entity.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/sign_up_usecase.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/sing_in_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignUPUseCase signUPUseCase;
  final GetCreateCurrentUserUsecase getCreateCurrentUserUsecase;
  final SignInUseCase signInUseCase;

  UserCubit(
      {required this.signUPUseCase,
      required this.getCreateCurrentUserUsecase,
      required this.signInUseCase})
      : super(UserInitial());

  Future<void> signIn({required UserEntity userEntity}) async {
    emit(UserLoading());
    try {
      if (userEntity.name?.isEmpty ?? false) {
        emit(UserValidationError(message: "Invalid user name"));
        return;
      }

      if (userEntity.password?.isEmpty ?? false) {
        emit(UserValidationError(message: "password user name"));
        return;
      }

      await signInUseCase.call(user: userEntity);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserNoInternetConnectionFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signUPUseCase.call(user);
      await getCreateCurrentUserUsecase.call(user);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserNoInternetConnectionFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
