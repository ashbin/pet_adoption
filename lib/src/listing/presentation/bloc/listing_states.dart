
part of 'listing_bloc.dart';

abstract class ListingState extends Equatable {

}

class ListingLoadingState extends ListingState {
  @override
  List<Object?> get props => [];
}

class ListingLoadCompleteState extends ListingState {
   List<PetItem> list;
   ListingRequest request;
  bool canLoadMore = true;


  ListingLoadCompleteState({
    required this.list,
    required this.request,
    this.canLoadMore = true
  });

  // ListingLoadCompleteState copyWith(
  //     {
  //   ListingData? data,
  // }) {
  //   return ListingLoadCompleteState(
  //     data: data ?? this.data, page: page,
  //   );
  // }

  @override
  List<Object?> get props => [list, request, canLoadMore];
}

class ListingErrorState extends ListingState {
  final String error;

  ListingErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
