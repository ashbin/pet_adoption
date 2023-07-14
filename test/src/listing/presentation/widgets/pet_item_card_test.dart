import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';
import 'package:pet_adoption/src/listing/presentation/widgets/pet_item_card.dart';
import 'package:pet_adoption/src/splash/presentation/splash_page.dart';

void main() {
  testWidgets('PetItemCard shows the name of Pet', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PetItemCard(data: PetItem(
            name: 'Milo',
            species: 'Dog',
            breed: 'Golden Retriever',
            location: 'San Francisco, CA',
            isAvailable: false,
            age: 3,
            coatColor: 'Golden',
            gender: 'Male',
            id: 1,
            photoUrl: 'https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_960_720.jpg',
            size: 'Medium',
            temperament: 'Friendly')),
      ),
    ));

    var findText = find.text('Milo');
    expect(findText, findsOneWidget);
  });
}
