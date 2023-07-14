import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/history/data/data_source/data_source.dart';
import 'package:pet_adoption/src/history/data/models/history_request.dart';
import 'package:pet_adoption/src/history/domain/entities/history_entity.dart';

abstract class HistoryRepository {
  final DataSource dataSource;

  Future<AppResult<HistoryData>> getHistory(
  {required HistoryRequest request});

  HistoryRepository(this.dataSource);
}
