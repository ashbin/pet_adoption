import 'package:flutter/cupertino.dart';
import 'package:pet_adoption/src/database/sample_data.dart';
import 'package:pet_adoption/src/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

import 'models.dart';

class DataManager {
  static final DataManager _instance = DataManager._internal();

  final String tablePet = 'pets';
  final String tableAdoptions = 'adoptions';

  final String columnId = 'id';
  final String columnName = 'name';
  final String columnSpecies = 'species';
  final String columnBreed = 'breed';
  final String columnAge = 'age';
  final String columnGender = 'gender';
  final String columnSize = 'size';
  final String columnCoatColor = 'coatColor';
  final String columnTemperament = 'temperament';
  final String columnPhotoUrl = 'photoUrl';
  final String columnLocation = 'location';
  final String columnAdoptionStatus = 'adoptionStatus';
  final String columnPetId = 'petId';
  final String columnDateOfAdoption = 'dateOfAdoption';

  factory DataManager.instance() => _instance;

  @visibleForTesting
  DataManager();

  DataManager._internal();

  late Database _db;

  Future<void> init() async {
    _db = await openDatabase('pet_adoption.db', version: 1,
        onCreate: (db, version) {
      // Create the pets table.
      db.execute(
          'CREATE TABLE $tablePet ($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnSpecies TEXT, $columnBreed TEXT, $columnAge INTEGER, $columnGender TEXT, $columnSize TEXT, $columnCoatColor TEXT, $columnTemperament TEXT, $columnPhotoUrl TEXT, $columnLocation TEXT, $columnAdoptionStatus TEXT)');

      // Create the adoptions table.
      db.execute(
          'CREATE TABLE $tableAdoptions ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnPetId INTEGER, $columnDateOfAdoption TEXT)');
    });
    var list = await _db.query(tablePet, limit: 1);
    if (list.isEmpty) {
      await _insertSampleData();
    }
  }

  Future<List<Pet>> getAllPets() async {
    final List<Map<String, dynamic>> maps = await _db.query(tablePet);
    return List.generate(maps.length, (index) => Pet.fromMap(maps[index]));
  }

  Future<List<Pet>> getPetsPaginated(
      {String? query,
      String? species,
      String? location,
      int? page = 1,
      int? pageSize = 10}) async {
    List<Pet> pets = [];

    String sql = 'SELECT * FROM $tablePet ';
    String sqlCondition = "";
    List<dynamic> params = [];
    if (query != null && query.isNotEmpty) {
      var likeQuery = "%$query%";
      sqlCondition =
          'WHERE ($columnName LIKE ? OR $columnSpecies LIKE ? OR $columnBreed LIKE ?) ';
      params.addAll([likeQuery, likeQuery, likeQuery]);
    }
    if (species != null && species.isNotEmpty) {
      if (sqlCondition.isNotEmpty) {
        sqlCondition += ' AND ';
      } else {
        sqlCondition += ' WHERE ';
      }
      sqlCondition += ' $columnSpecies = ? ';
      params.add(species);
    }
    if (location != null && location.isNotEmpty) {
      if (sqlCondition.isNotEmpty) {
        sqlCondition += ' AND ';
      } else {
        sqlCondition += ' WHERE ';
      }
      sqlCondition += ' $columnLocation = ? ';
      params.add(location);
    }
    sql += sqlCondition;
    sql += ' ORDER BY $columnId DESC LIMIT ? OFFSET ? ';
    params.addAll([pageSize, (page! - 1) * pageSize!]);

    print("SQL :: $sql || values :: $params ");

    var results = await _db.rawQuery(sql, params);
    for (var result in results) {
      pets.add(Pet.fromMap(result));
    }
    print("SQL :: result ${pets} ");
    return pets;
  }

  Future<List<Pet>> getPetsByCriteria(Map<String, dynamic> criteria) async {
    final List<String> whereArgs = [];
    final List<dynamic> values = [];
    criteria.forEach((key, value) {
      whereArgs.add('$key = ?');
      values.add(value);
    });

    final List<Map<String, dynamic>> maps = await _db.query(tablePet,
        where: whereArgs.join(' AND '), whereArgs: values);
    return List.generate(maps.length, (index) => Pet.fromMap(maps[index]));
  }

  Future<List<Adoption>> getAllAdoptions() async {
    final List<Map<String, dynamic>> maps = await _db.query(tableAdoptions);
    return List.generate(maps.length, (index) => Adoption.fromMap(maps[index]));
  }

  Future<Pet?> markAdopted(int petId, DateTime dateOfAdoption) async {
    var petsList = await getPetsByCriteria({columnId: petId});
    if (petsList.isEmpty) {
      return null;
    }
    var pet = petsList.first;
    pet.adoptionStatus = Constants.statusAdopted;
    var batch = _db.batch();
    batch.insert(tableAdoptions, {
      columnPetId: pet.id,
      columnDateOfAdoption: dateOfAdoption.toIso8601String()
    });
    batch.update(
      tablePet,
      pet.toMap(),
      where: '$columnId =?',
      whereArgs: [pet.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    try {
      await batch.commit();
      return pet;
    } catch (e) {
      return null;
    }
  }

  Future<List<Pet>> getHistoryPaginated(
      {int? page = 1, int? pageSize = 10}) async {
    List<Pet> pets = [];

    String sql =
        'SELECT * FROM $tableAdoptions left join $tablePet ON $tableAdoptions.$columnPetId = $tablePet.$columnId ';
    List<dynamic> params = [];
    sql += ' ORDER BY $columnId DESC LIMIT ? OFFSET ? ';
    params.addAll([pageSize, (page! - 1) * pageSize!]);

    print("SQL :: $sql || values :: $params ");

    var results = await _db.rawQuery(sql, params);
    for (var result in results) {
      pets.add(Pet.fromMap(result));
    }
    print("SQL :: result ${pets} ");
    return pets;
  }

  Future<void> _insertSampleData() async {
    // Insert the sample data.
    var batch = _db.batch();

    for (var element in SampleData().petData) {
      batch.insert(tablePet, element);
    }

    await batch.commit(noResult: true);
  }

  Future<void> dropAll() async {
    _db.delete(tableAdoptions);
    _db.delete(tablePet);
    await _insertSampleData();
  }
}
