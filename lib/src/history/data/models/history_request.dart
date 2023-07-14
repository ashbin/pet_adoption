import 'package:equatable/equatable.dart';

class HistoryRequest extends Equatable {
  int page;
  int pageSize;

  HistoryRequest(
      {required this.page, required this.pageSize});

  @override
  List<Object?> get props => [ pageSize, page];
}
