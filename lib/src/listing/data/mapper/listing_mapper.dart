import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/listing/data/models/listing_model.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';
import 'package:pet_adoption/src/utils/constants.dart';
import 'package:pet_adoption/src/utils/strings.dart';

class ListingMapper {
  AppResult<ListingData> toMapEntity(ListingResponseModel responseModel) {
    if (responseModel.list == null) {
      return AppResult.error(Strings.errorSomethingWrong);
    } else {
      return AppResult(ListingData(
          list: responseModel.list!
              .map((e) => PetItem(
                  name: e.name,
                  species: e.species,
                  breed: e.breed,
                  location: e.location,
                  isAvailable: e.adoptionStatus == Constants.statusAvailable,
                  age: e.age,
                  coatColor: e.coatColor,
                  gender: e.gender,
                  id: e.id,
                  photoUrl: e.photoUrl ?? Constants.defaultPetImage,
                  size: e.size,
                  temperament: e.temperament))
              .toList()));
    }
  }
}
