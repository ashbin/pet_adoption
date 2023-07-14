import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/listing/data/models/listing_request.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';
import 'package:pet_adoption/src/listing/domain/repositories/listing_repo.dart';

class FetchListingDataUseCase {
  final ListingRepository repository;

  FetchListingDataUseCase(this.repository);

  Future<AppResult<ListingData>> call({required ListingRequest request}) async{
    return repository.getListing(request: request);
  }
}
