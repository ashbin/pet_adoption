
part of 'listing_bloc.dart';

abstract class ListingState extends Equatable {

}

class ListingLoadingState extends ListingState {
  @override
  List<Object?> get props => [];
}

class ListingLoadCompleteState extends ListingState {
   final List<PetItem> list;
   final ListingRequest request;
  final bool canLoadMore;


  ListingLoadCompleteState({
    required this.list,
    required this.request,
    this.canLoadMore = true
  });


  @override
  List<Object?> get props => [list, request, canLoadMore];
}

class ListingErrorState extends ListingState {
  final String error;

  ListingErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
