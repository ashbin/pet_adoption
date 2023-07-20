import 'package:flutter/material.dart';
import 'package:pet_adoption/src/details/presentation/pages/details_page.dart';
import 'package:pet_adoption/src/history/domain/entities/history_entity.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart'
    as listing;
import 'package:pet_adoption/src/utils/dimens.dart';
import 'package:pet_adoption/src/utils/strings.dart';

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
          padding: const EdgeInsets.all(Dimens.dimen8),
          child: ListTile(
            leading: CircleAvatar(
              radius: Dimens.dimen30,
              backgroundImage: NetworkImage(data.photoUrl),
            ),
            title: Text(
              data.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(context, '${Strings.species}: ${data.species}'),
                buildText(context, '${Strings.breed}: ${data.breed}'),
                buildText(context, '${Strings.age}: ${data.age}'),
                buildText(context, '${Strings.gender}: ${data.gender}'),
                buildText(context, '${Strings.coatColor}: ${data.coatColor}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text buildText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
