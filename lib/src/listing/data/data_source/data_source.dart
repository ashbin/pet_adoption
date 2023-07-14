import 'package:pet_adoption/src/database/models.dart';

abstract interface class DataSource {
  Future<List<Pet>?> getPets({
    String? query,
    String? species,
    String? location,
    int? page,
    int? pageSize,
  });
}
