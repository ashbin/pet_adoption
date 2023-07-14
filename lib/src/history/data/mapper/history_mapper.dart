import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/history/data/models/listing_model.dart';
import 'package:pet_adoption/src/history/domain/entities/history_entity.dart';
import 'package:pet_adoption/src/utils/constants.dart';
import 'package:pet_adoption/src/utils/strings.dart';

class HistoryMapper {
  AppResult<HistoryData> toMapEntity(HistoryResponseModel responseModel) {
    if (responseModel.list == null) {
      return AppResult.error(Strings.errorSomethingWrong);
    } else {
      return AppResult(HistoryData(
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
