import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/src/details/data/data_source/local_data_source.dart';
import 'package:pet_adoption/src/details/data/repositories/adopt_repo_impl.dart';
import 'package:pet_adoption/src/details/domain/usecases/adopt_usecase.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';
import 'package:pet_adoption/src/utils/strings.dart';

part 'details_events.dart';

part 'details_states.dart';

class DetailsBloc extends Bloc<AdoptEvent, DetailsState> {
  DetailsBloc(DetailsState initialState) : super(initialState) {
    on<MarkAdoptedEvent>((event, emit) async {
      emit(DetailsLoadingState(state.data));
      var result =
          await MarkAdoptedUseCase(AdoptRepositoryImpl(LocalDataSource()))
              .call(petId: event.petId, dateOfAdoption: event.dateOfAdoption);
      if (!result.success) {
        emit(DetailsErrorState(
            result.error ?? Strings.errorSomethingWrong, state.data));
      } else {
        emit(DetailsLoadCompleteState(result.data!));
      }
    });
  }
}
