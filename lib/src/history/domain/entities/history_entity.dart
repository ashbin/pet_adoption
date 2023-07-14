import 'package:equatable/equatable.dart';

class HistoryData extends Equatable {
  final List<PetItem> list;

  HistoryData({required this.list});

  @override
  List<Object?> get props => [list];
}

class PetItem extends Equatable {
  int id;
  String name;
  String species;
  String breed;
  int? age;
  String? gender;
  String? size;
  String? coatColor;
  String? temperament;
  String photoUrl;
  String? location;
  bool isAvailable;

  PetItem(
      {required this.id,
      required this.name,
      required this.species,
      required this.breed,
      this.age,
      this.gender,
      this.size,
      this.coatColor,
      this.temperament,
      required this.photoUrl,
      this.location,
      required this.isAvailable});

  @override
  List<Object?> get props => [
        id,
        name,
        isAvailable,
        species,
        breed,
        age,
        gender,
        size,
        coatColor,
        temperament,
        photoUrl,
        location,
      ];
}
