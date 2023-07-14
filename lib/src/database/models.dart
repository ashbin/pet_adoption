import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  int id;
  String name;
  String species;
  String breed;
  int? age;
  String? gender;
  String? size;
  String? coatColor;
  String? temperament;
  String? photoUrl;
  String? location;
  String? adoptionStatus;

  Pet(
      {required this.id,
      required this.name,
      required this.species,
      required this.breed,
      this.age,
      this.gender,
      this.size,
      this.coatColor,
      this.temperament,
      this.photoUrl,
      this.location,
      this.adoptionStatus});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'breed': breed,
      'age': age,
      'gender': gender,
      'size': size,
      'coatColor': coatColor,
      'temperament': temperament,
      'photoUrl': photoUrl,
      'location': location,
      'adoptionStatus': adoptionStatus,
    };
  }

  static Pet fromMap(Map<String, dynamic> map) {
    return Pet(
        id: map['id'],
        name: map['name'],
        species: map['species'],
        breed: map['breed'],
        age: map['age'],
        gender: map['gender'],
        size: map['size'],
        coatColor: map['coatColor'],
        temperament: map['temperament'],
        photoUrl: map['photoUrl'],
        location: map['location'],
        adoptionStatus: map['adoptionStatus']);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        species,
        breed,
        age,
        gender,
        size,
        coatColor,
        temperament,
        photoUrl,
        location,
        adoptionStatus
      ];
}

class Adoption extends Equatable{
  int id;
  int petId;
  DateTime dateOfAdoption;

  Adoption(
      {required this.id, required this.petId, required this.dateOfAdoption});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petId': petId,
      'dateOfAdoption': dateOfAdoption.toIso8601String(),
    };
  }

  static Adoption fromMap(Map<String, dynamic> map) {
    return Adoption(
        id: map['id'],
        petId: map['petId'],
        dateOfAdoption: DateTime.parse(map['dateOfAdoption']));
  }

  @override
  List<Object?> get props => [id, petId, dateOfAdoption];
}
