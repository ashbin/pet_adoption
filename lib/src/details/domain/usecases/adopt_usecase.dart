import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/details/domain/repositories/adopt_repo.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';

class MarkAdoptedUseCase {
  final AdoptRepository repository;

  MarkAdoptedUseCase(this.repository);

  Future<AppResult<PetItem>> call(
      {required int petId, required DateTime dateOfAdoption}) async {
    return repository.markAdopted(petId: petId, dateOfAdoption: dateOfAdoption);
  }
}
