import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/listing/data/data_source/data_source.dart';
import 'package:pet_adoption/src/listing/data/models/listing_request.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';

abstract class ListingRepository {
  final DataSource dataSource;

  Future<AppResult<ListingData>> getListing(
  {ListingRequest? request});

  ListingRepository(this.dataSource);
}
