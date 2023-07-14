import 'dart:convert';

import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/history/data/data_source/data_source.dart';
import 'package:pet_adoption/src/history/data/mapper/history_mapper.dart';
import 'package:pet_adoption/src/history/data/models/listing_model.dart';
import 'package:pet_adoption/src/history/data/models/history_request.dart';
import 'package:pet_adoption/src/history/domain/entities/history_entity.dart';
import 'package:pet_adoption/src/history/domain/repositories/history_repo.dart';

class HistoryRepositoryImpl extends HistoryRepository {
  HistoryRepositoryImpl(super.dataSource);

  @override
  Future<AppResult<HistoryData>> getHistory(
  {required HistoryRequest request}) async{

    return HistoryMapper().toMapEntity(HistoryResponseModel(list: await dataSource.getAdoptionHistory(
       page: request.page, pageSize: request.pageSize
    )));
  }

}
