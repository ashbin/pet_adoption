import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/listing/data/mapper/listing_mapper.dart';
import 'package:pet_adoption/src/listing/data/models/listing_model.dart';
import 'package:pet_adoption/src/listing/data/models/listing_request.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';
import 'package:pet_adoption/src/listing/domain/repositories/listing_repo.dart';

class ListingRepositoryImpl extends ListingRepository {
  ListingRepositoryImpl(super.dataSource);

  @override
  Future<AppResult<ListingData>> getListing({ListingRequest? request}) async {
    return ListingMapper().toMapEntity(ListingResponseModel(
        list: await dataSource.getPets(
            query: request?.query,
            species: request?.species,
            location: request?.location,
            page: request?.page,
            pageSize: request?.pageSize)));
  }
}
