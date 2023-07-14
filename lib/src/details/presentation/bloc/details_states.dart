part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  final PetItem data;

  DetailsState(this.data);
}

class DetailsInitialState extends DetailsState {
  DetailsInitialState(super.data);

  @override
  List<Object?> get props => [super.data];
}
class DetailsLoadingState extends DetailsState {
  DetailsLoadingState(super.data);

  @override
  List<Object?> get props => [super.data];
}

class DetailsLoadCompleteState extends DetailsState {
  DetailsLoadCompleteState(super.data);

  @override
  List<Object?> get props => [super.data];
}

class DetailsErrorState extends DetailsState {
  final String error;

  DetailsErrorState(this.error, super.data);

  @override
  List<Object?> get props => [error, super.data];
}
