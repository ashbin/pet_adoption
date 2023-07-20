import 'package:equatable/equatable.dart';

class ListingRequest extends Equatable {
  String? query;
  String? species;
  String? location;
  int page;
  int pageSize;

  ListingRequest(
      {this.query,
      this.species,
      this.location,
      this.page = 1,
      required this.pageSize});

  @override
  List<Object?> get props => [query, species, location, pageSize, page];
}
