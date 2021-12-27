part of 'color_cubit.dart';

abstract class ColorState extends Equatable {
  const ColorState();
}

class ColorInitial extends ColorState {
  @override
  List<Object> get props => [];
}

class ColorLoading extends ColorState {
  @override
  List<Object> get props => [];
}

class ColorFailure extends ColorState {
  @override
  List<Object> get props => [];
}

class ColorLoaded extends ColorState {
  final List<ColorEntity> notes;

  ColorLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}

class ColorSeleted extends ColorState {
  final ColorEntity notes;

  ColorSeleted(this.notes);

  @override
  List<Object> get props => [notes];
}
