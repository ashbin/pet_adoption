import 'package:equatable/equatable.dart';

class AppResult<T> extends Equatable{
  late bool success;
  String? error;
  T? data;

  AppResult(this.data){
   this.success = true;
  }

  AppResult.error(this.error){
    success = false;
  }

  @override
  List<Object?> get props => [success, data, error];
}