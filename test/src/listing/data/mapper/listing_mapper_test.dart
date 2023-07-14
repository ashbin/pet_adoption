import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption/src/core/common_response.dart';
import 'package:pet_adoption/src/database/models.dart';
import 'package:pet_adoption/src/listing/data/mapper/listing_mapper.dart';
import 'package:pet_adoption/src/listing/data/models/listing_model.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';

void main() {
  // Create a mock DataManager instance.

  test('toMapEntity() should return a ListingData object with the correct properties', () {
    ListingResponseModel responseModel = ListingResponseModel(
      list: [
        Pet(
          id: 1,
          name: 'Puppy',
          species: 'Dog',
          breed: 'Golden Retriever',
          age: 1,
          gender: 'Male',
          size: 'Medium',
          coatColor: 'Golden',
          temperament: 'Friendly',
          photoUrl: 'https://example.com/photo.jpg',
          location: 'San Francisco, CA',
          adoptionStatus: 'Available',
        ),
      ],
    );

    AppResult<ListingData> result = ListingMapper().toMapEntity(responseModel);
    expect(result.success, true);
    var listingData = result.data!;

    expect(listingData.list.length, 1);
    expect(listingData.list[0].id, 1);
    expect(listingData.list[0].name, 'Puppy');
    expect(listingData.list[0].species, 'Dog');
    expect(listingData.list[0].breed, 'Golden Retriever');
    expect(listingData.list[0].age, 1);
    expect(listingData.list[0].gender, 'Male');
    expect(listingData.list[0].size, 'Medium');
    expect(listingData.list[0].coatColor, 'Golden');
    expect(listingData.list[0].temperament, 'Friendly');
    expect(listingData.list[0].photoUrl, 'https://example.com/photo.jpg');
    expect(listingData.list[0].location, 'San Francisco, CA');
    expect(listingData.list[0].isAvailable, true);
  });}