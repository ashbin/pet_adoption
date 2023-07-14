import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/database/models.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';
import 'package:pet_adoption/src/utils/constants.dart';
import 'package:pet_adoption/src/utils/strings.dart';

class PetMapper {
  AppResult<PetItem> toMapEntity(Pet? resultModel) {
    if (resultModel == null) {
      return AppResult.error(Strings.errorSomethingWrong);
    } else {
      return AppResult(PetItem(
          name: resultModel.name,
          species: resultModel.species,
          breed: resultModel.breed,
          location: resultModel.location,
          isAvailable: resultModel.adoptionStatus == Constants.statusAvailable,
          age: resultModel.age,
          coatColor: resultModel.coatColor,
          gender: resultModel.gender,
          id: resultModel.id,
          photoUrl: resultModel.photoUrl ?? Constants.defaultPetImage,
          size: resultModel.size,
          temperament: resultModel.temperament));
    }
  }
}
