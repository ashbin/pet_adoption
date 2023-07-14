
part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {

}

class HistoryLoadingState extends HistoryState {
  @override
  List<Object?> get props => [];
}

class HistoryLoadCompleteState extends HistoryState {
   List<PetItem> list;
   HistoryRequest request;
  bool canLoadMore = true;


  HistoryLoadCompleteState({
    required this.list,
    required this.request,
    this.canLoadMore = true
  });

  @override
  List<Object?> get props => [list, request, canLoadMore];
}
class HistoryEmptyState extends HistoryState {
  HistoryRequest request;
  bool canLoadMore = true;


  HistoryEmptyState({
    required this.request,
    this.canLoadMore = true
  });

  @override
  List<Object?> get props => [request, canLoadMore];
}

class HistoryErrorState extends HistoryState {
  final String error;

  HistoryErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
