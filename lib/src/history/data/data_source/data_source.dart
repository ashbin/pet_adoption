import 'package:pet_adoption/src/database/models.dart';

abstract interface class DataSource {
  Future<List<Pet>?> getAdoptionHistory({
    required int page,
    required int pageSize,
  });
}
