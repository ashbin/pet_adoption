import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/history/data/models/history_request.dart';
import 'package:pet_adoption/src/history/domain/entities/history_entity.dart';
import 'package:pet_adoption/src/history/domain/repositories/history_repo.dart';

class FetchHistoryUseCase {
  final HistoryRepository repository;

  FetchHistoryUseCase(this.repository);

  Future<AppResult<HistoryData>> call({required HistoryRequest request}) async{
    return repository.getHistory(request: request);
  }
}
