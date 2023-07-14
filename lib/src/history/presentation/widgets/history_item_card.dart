import 'package:flutter/material.dart';
import 'package:pet_adoption/src/details/presentation/pages/details_page.dart';
import 'package:pet_adoption/src/history/domain/entities/history_entity.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart'
    as listing;

class HistoryItemCard extends StatelessWidget {
  final PetItem data;

  const HistoryItemCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(PetDetailsPage.routeName,
            arguments: listing.PetItem(
              id: data.id,
              name: data.name,
              breed: data.breed,
              species: data.species,
              photoUrl: data.photoUrl,
              isAvailable: data.isAvailable,
              temperament: data.temperament,
              gender: data.gender,
              size: data.size,
              coatColor: data.coatColor,
              age: data.age,
              location: data.location,
            ));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(data.photoUrl),
            ),
            title: Text(
              // tag: "${data.id}_name",
              data.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Species: ${data.species}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Breed: ${data.breed}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Age: ${data.age}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Gender: ${data.gender}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Coat Color: ${data.coatColor}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
