part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {}

class HistoryLoadingState extends HistoryState {
  @override
  List<Object?> get props => [];
}

class HistoryLoadCompleteState extends HistoryState {
  final List<PetItem> list;
  final HistoryRequest request;
  final bool canLoadMore;

  HistoryLoadCompleteState(
      {required this.list, required this.request, this.canLoadMore = true});

  @override
  List<Object?> get props => [list, request, canLoadMore];
}

class HistoryEmptyState extends HistoryState {
  final HistoryRequest request;
  final bool canLoadMore;

  HistoryEmptyState({required this.request, this.canLoadMore = true});

  @override
  List<Object?> get props => [request, canLoadMore];
}

class HistoryErrorState extends HistoryState {
  final String error;

  HistoryErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
