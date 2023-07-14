part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
}

class LoadHistoryEvent extends HistoryEvent{
  final HistoryRequest request;

  LoadHistoryEvent({
    required this.request,
  });

  @override
  List<Object?> get props => [request];
}
class LoadHistoryMoreEvent extends HistoryEvent{

  LoadHistoryMoreEvent();

  @override
  List<Object?> get props => [];
}