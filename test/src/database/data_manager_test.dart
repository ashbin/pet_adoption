import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption/src/database/data_manager.dart';
import 'package:pet_adoption/src/database/models.dart';

class MockDataManager extends DataManager {
  List<Pet> _pets = [];

  @override
  Future<List<Pet>> getAllPets() async {
    return _pets;
  }

  @override
  Future<List<Pet>> getPetsPaginated(
      {String? query,
      String? species,
      String? location,
      int? page = 1,
      int? pageSize = 10}) async {
    int start = (page! - 1) * pageSize!;
    int end = page * pageSize;

    if (start >= _pets.length) {
      return [];
    }
    if (end > _pets.length) {
      end = _pets.length;
    }
    return _pets.sublist(start, end);
  }

  void addPet(Pet pet) {
    _pets.add(pet);
  }

  void deletePet(int petId) {
    _pets.removeWhere((pet) => pet.id == petId);
  }
}

void main() {
  // Create a mock DataManager instance.

  test(
    'getAllPets() returns an empty list when the database is empty',
    () async {
      final MockDataManager mockDataManager = MockDataManager();
      final List<Pet> expectedPets = [];

      final List<Pet> actualPets = await mockDataManager.getAllPets();

      expect(actualPets, equals(expectedPets));
    },
  );

  test(
    'getAllPets() returns a list with one pet when the database contains one pet',
    () async {
      final MockDataManager mockDataManager = MockDataManager();
      final List<Pet> expectedPets = [
        Pet(id: 1, name: 'Spot', species: 'Dog', breed: 'Golden Retriever')
      ];
      mockDataManager.addPet(
          Pet(id: 1, name: 'Spot', species: 'Dog', breed: 'Golden Retriever'));

      final List<Pet> actualPets = await mockDataManager.getAllPets();

      expect(actualPets, equals(expectedPets));
    },
  );

  test(
      'getAllPets() returns a list with all the pets when the database contains multiple pets',
      () async {
    final MockDataManager mockDataManager = MockDataManager();
    final List<Pet> expectedPets = [
      Pet(id: 1, name: 'Spot', species: 'Dog', breed: 'Golden Retriever'),
      Pet(id: 2, name: 'Bella', species: 'Cat', breed: 'Persian'),
    ];

    mockDataManager.addPet(
        Pet(id: 1, name: 'Spot', species: 'Dog', breed: 'Golden Retriever'));
    mockDataManager
        .addPet(Pet(id: 2, name: 'Bella', species: 'Cat', breed: 'Persian'));

    final List<Pet> actualPets = await mockDataManager.getAllPets();

    expect(actualPets, equals(expectedPets));
  });

  test(
      'getAllPets() returns a list with all the pets when the database contains multiple pets',
      () async {
    final MockDataManager mockDataManager = MockDataManager();

    final List<Pet> expectedPets = [
      Pet(id: 1, name: 'Spot', species: 'Dog', breed: 'Golden Retriever'),
      Pet(id: 2, name: 'Bella', species: 'Cat', breed: 'Persian'),
    ];

    mockDataManager.addPet(
        Pet(id: 1, name: 'Spot', species: 'Dog', breed: 'Golden Retriever'));
    mockDataManager
        .addPet(Pet(id: 2, name: 'Bella', species: 'Cat', breed: 'Persian'));

    final List<Pet> actualPets = await mockDataManager.getAllPets();

    expect(actualPets, equals(expectedPets));
  });

  test(
      'getPaginatedPets() returns a list with all the pets within the given page and page size range',
      () async {
    final MockDataManager mockDataManager = MockDataManager();
    final List<Pet> expectedPets = [
      Pet(id: 1, name: 'Spot', species: 'Dog', breed: 'Golden Retriever'),
      Pet(id: 2, name: 'Bella', species: 'Cat', breed: 'Persian'),
    ];

    mockDataManager.addPet(
        Pet(id: 1, name: 'Spot', species: 'Dog', breed: 'Golden Retriever'));
    mockDataManager
        .addPet(Pet(id: 2, name: 'Bella', species: 'Cat', breed: 'Persian'));
    mockDataManager.addPet(
        Pet(id: 3, name: 'Spot', species: 'Dog', breed: 'Golden Retriever'));
    mockDataManager.addPet(
        Pet(id: 4, name: 'Emma', species: 'Dog', breed: 'Golden Retriever'));

    final List<Pet> actualPets =
        await mockDataManager.getPetsPaginated(pageSize: 2, page: 1);

    expect(actualPets, equals(expectedPets));
  });
}
