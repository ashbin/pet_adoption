import 'package:pet_adoption/src/database/data_manager.dart';
import 'package:pet_adoption/src/database/models.dart';
import 'package:pet_adoption/src/listing/data/data_source/data_source.dart';

class LocalDataSource implements DataSource {
  @override
  Future<List<Pet>?> getPets({
    String? query,
    String? species,
    String? location,
    int? page,
    int? pageSize,
  }) async {
    print("LocalDataSource :: getPets $query $species $location $page $pageSize");
    try {
      return DataManager.instance().getPetsPaginated(
          query: query,
          location: location,
          species: species,
          page: page,
          pageSize: pageSize);
    }catch(e){
      print(e);
      return null;
    }
  }
}
