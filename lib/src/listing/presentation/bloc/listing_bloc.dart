import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/src/listing/data/data_source/local_data_source.dart';
import 'package:pet_adoption/src/listing/data/models/listing_request.dart';
import 'package:pet_adoption/src/listing/data/repositories/listing_repo_impl.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';
import 'package:pet_adoption/src/listing/domain/usecases/listing_usecase.dart';
import 'package:pet_adoption/src/utils/strings.dart';
import 'package:rxdart/rxdart.dart';

part 'listing_events.dart';

part 'listing_states.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  ListingRequest? _request;
  final pageSize = 10;

  ListingBloc(ListingState initialState) : super(initialState) {

    on<LoadListingEvent>((event, emit) async {
      _request = event.request;
      await loadRequest(emit, event.request, []);
    });

    on<LoadListingMoreEvent>((event, emit) async {
      print("On load more event");
      if (state is! ListingLoadCompleteState) {
        // emit(ListingLoadingState());
        print("On load more event : not complete stae");
        return;
      }
      ListingLoadCompleteState currentState = state as ListingLoadCompleteState;
      if (!currentState.canLoadMore) {
        print("On load more event : cant load more");
        return;
      }
      var request = currentState.request;
      request.page = request.page + 1;
      _request = request;
      await loadRequest(emit, request, currentState.list);
    }, transformer: (events, mapper) {
      return events
          .debounceTime(const Duration(milliseconds: 1000))
          .asyncExpand(mapper);
    });

    on<SearchListingEvent>((event, emit) async {
      var request = _request ?? ListingRequest(page: 1, pageSize: pageSize);
      request.page = 1;
      request.query = event.query;

      _request = request;
      await loadRequest(emit, request, []);
    }, transformer: (events, mapper) {
      return events
          .debounceTime(const Duration(milliseconds: 300))
          .asyncExpand(mapper);
    });

    on<RefreshListingEvent>((event, emit) async {
      if(_request != null) {
        _request!.page = 1;
        await loadRequest(emit, _request!, []);
      }
    });

  }

  Future<void> loadRequest(Emitter<ListingState> emit, ListingRequest request,
      List<PetItem>? currentResult) async {
    emit(ListingLoadingState());
    try {
      var result = await FetchListingDataUseCase(
              ListingRepositoryImpl(LocalDataSource()))
          .call(request: request);

      if (result.success) {
        var data = currentResult ?? [];
        bool canLoadMore = (result.data?.list != null &&     result.data!.list.length == request.pageSize);
        if (result.data?.list != null ){
          data.addAll(result.data!.list);
        }
        emit(ListingLoadCompleteState(
            list: data, request: request, canLoadMore: canLoadMore));
      } else {
        emit(ListingErrorState(result.error ?? Strings.errorSomethingWrong));
      }
    } catch (e) {
      emit(ListingErrorState(Strings.errorSomethingWrong));
    }
  }
}
