import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/src/history/data/data_source/local_data_source.dart';
import 'package:pet_adoption/src/history/data/models/history_request.dart';
import 'package:pet_adoption/src/history/data/repositories/history_repo_impl.dart';
import 'package:pet_adoption/src/history/domain/entities/history_entity.dart';
import 'package:pet_adoption/src/history/domain/usecases/history_usecase.dart';
import 'package:pet_adoption/src/utils/strings.dart';
import 'package:rxdart/rxdart.dart';

part 'history_events.dart';

part 'history_states.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc(HistoryState initialState) : super(initialState) {
    on<LoadHistoryEvent>((event, emit) async {
      await loadRequest(emit, event.request, []);
    });

    on<LoadHistoryMoreEvent>((event, emit) async {
      //todo implement logger
      print("On load more event");
      if (state is! HistoryLoadCompleteState) {
        print("On load more event : not complete stae");
        return;
      }
      HistoryLoadCompleteState currentState = state as HistoryLoadCompleteState;
      if (!currentState.canLoadMore) {
        print("On load more event : cant load more");
        return;
      }
      var request = currentState.request;
      request.page = request.page + 1;
      await loadRequest(emit, request, currentState.list);
    }, transformer: (events, mapper) {
      return events
          .debounceTime(const Duration(milliseconds: 1000))
          .asyncExpand(mapper);
    });
  }

  Future<void> loadRequest(Emitter<HistoryState> emit, HistoryRequest request,
      List<PetItem>? currentResult) async {
    emit(HistoryLoadingState());
    try {
      var result =
          await FetchHistoryUseCase(HistoryRepositoryImpl(LocalDataSource()))
              .call(request: request);

      if (result.success) {
        var data = currentResult ?? [];
        bool canLoadMore = (result.data?.list != null &&
            result.data!.list.length == request.pageSize);
        if (result.data?.list != null) {
          data.addAll(result.data!.list);
        }
        if (data.isEmpty) {
          emit(HistoryEmptyState(request: request, canLoadMore: false));
        } else {
          emit(HistoryLoadCompleteState(
              list: data, request: request, canLoadMore: canLoadMore));
        }
      } else {
        emit(HistoryErrorState(result.error ?? Strings.errorSomethingWrong));
      }
    } catch (e) {
      emit(HistoryErrorState(Strings.errorSomethingWrong));
    }
  }
}
