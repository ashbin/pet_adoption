import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/details/data/mapper/pet_mapper.dart';
import 'package:pet_adoption/src/details/domain/repositories/adopt_repo.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';

class AdoptRepositoryImpl extends AdoptRepository {
  AdoptRepositoryImpl(super.dataSource);

  @override
  Future<AppResult<PetItem>> markAdopted(
      {required int petId, required DateTime dateOfAdoption}) async {
    return PetMapper().toMapEntity(await dataSource.markAdopted(
        petId: petId, dateOfAdoption: dateOfAdoption));
  }
}
