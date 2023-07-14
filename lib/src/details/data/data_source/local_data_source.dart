import 'package:pet_adoption/src/database/data_manager.dart';
import 'package:pet_adoption/src/database/models.dart';

import 'data_source.dart';

class LocalDataSource implements DataSource {
  @override
  Future<Pet?> markAdopted(
      {required int petId, required DateTime dateOfAdoption}) async {
    try {
      return await DataManager.instance().markAdopted(petId, dateOfAdoption);
    } catch (e) {}
    return null;
  }
}
