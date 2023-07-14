import 'package:pet_adoption/src/database/models.dart';

abstract interface class DataSource {
  Future<Pet?> markAdopted({
    required int petId,
    required DateTime dateOfAdoption,
  });
}
