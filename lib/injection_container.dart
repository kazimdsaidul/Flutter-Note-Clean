import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_note_clean/feature/data/remote/data_sources/firebase_remote_data_source_impl.dart';
import 'package:flutter_note_clean/feature/domain/repositories/firebase_repository.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/add_new_note_usecase.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/delete_note_usecase.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/get_current_uid_usecase.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/get_notes_usecase.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/is_sing_in_usecase.dart';
import 'package:flutter_note_clean/feature/domain/use_cases/sign_up_usecase.dart';
import 'package:flutter_note_clean/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_note_clean/feature/presentation/cubit/note/note_cubit.dart';
import 'package:flutter_note_clean/feature/presentation/cubit/user/user_cubit.dart';
import 'package:get_it/get_it.dart';

import 'feature/data/remote/data_sources/firebase_remote_data_source.dart';
import 'feature/data/repositories/firbase_repogitory_impl.dart';
import 'feature/domain/use_cases/get_create_current_user_usecase.dart';
import 'feature/domain/use_cases/sing_in_usecase.dart';
import 'feature/domain/use_cases/update_note_usecase.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // Cubit//Bloc
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      getCurrentUidUseCase: sl.call()));
  sl.registerLazySingleton<NoteCubit>(() => NoteCubit(
      updateNoteUseCase: sl.call(),
      addNewNoteUseCase: sl.call(),
      deleteNoteUseCase: sl.call(),
      getNotesUseCase: sl.call()));
  sl.registerLazySingleton<UserCubit>(() => UserCubit(
      signUPUseCase: sl.call(),
      getCreateCurrentUserUsecase: sl.call(),
      signInUseCase: sl.call()));

  // useCase
  sl.registerLazySingleton<AddNewNoteUseCase>(
      () => AddNewNoteUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteNoteUseCase>(
      () => DeleteNoteUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateNoteUseCase>(
      () => UpdateNoteUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetNotesUseCase>(
      () => GetNotesUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUPUseCase>(
      () => SignUPUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUsecase>(
      () => GetCreateCurrentUserUsecase(repository: sl.call()));

  // repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl.call()));

  //data source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(
          firebaseAuth: sl.call(), firebaseFirestore: sl.call()));

  // External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
