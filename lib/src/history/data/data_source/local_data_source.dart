import 'package:pet_adoption/src/database/data_manager.dart';
import 'package:pet_adoption/src/database/models.dart';
import 'package:pet_adoption/src/history/data/data_source/data_source.dart';

class LocalDataSource implements DataSource {
  @override
  Future<List<Pet>?> getAdoptionHistory({
    required int page,
    required int pageSize,
  }) async {
    print("LocalDataSource :: getAdoptionHistory $page $pageSize");
    try {
      return DataManager.instance().getHistoryPaginated(
          page: page,
          pageSize: pageSize);
    }catch(e){
      print(e);
      return null;
    }
  }
}
