part of 'listing_bloc.dart';

abstract class ListingEvent extends Equatable {
}

class LoadListingEvent extends ListingEvent{
  final ListingRequest request;

  LoadListingEvent({
    required this.request,
  });

  @override
  List<Object?> get props => [request];
}
class LoadListingMoreEvent extends ListingEvent{

  LoadListingMoreEvent();

  @override
  List<Object?> get props => [];
}
class RefreshListingEvent extends ListingEvent{

  RefreshListingEvent();

  @override
  List<Object?> get props => [];
}

class SearchListingEvent extends ListingEvent{
  final String query;
  SearchListingEvent(this.query);

  @override
  List<Object?> get props => [query];
}