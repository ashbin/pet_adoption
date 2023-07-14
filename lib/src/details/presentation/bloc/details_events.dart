part of 'details_bloc.dart';

abstract class AdoptEvent extends Equatable {
}

class MarkAdoptedEvent extends AdoptEvent{
  final int petId;
  final DateTime dateOfAdoption;


  MarkAdoptedEvent(this.petId, this.dateOfAdoption);

  @override
  List<Object?> get props => [petId, dateOfAdoption];
}