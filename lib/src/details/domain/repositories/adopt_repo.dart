import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/details/data/data_source/data_source.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';

abstract class AdoptRepository {
  final DataSource dataSource;

  Future<AppResult<PetItem>> markAdopted(
      {required int petId, required DateTime dateOfAdoption});

  AdoptRepository(this.dataSource);
}
