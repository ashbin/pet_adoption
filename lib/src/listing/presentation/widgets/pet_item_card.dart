import 'package:flutter/material.dart';
import 'package:pet_adoption/src/details/presentation/pages/details_page.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';
import 'package:pet_adoption/src/utils/constants.dart';
import 'package:pet_adoption/src/utils/dimens.dart';
import 'package:pet_adoption/src/utils/strings.dart';

class PetItemCard extends StatelessWidget {
  final PetItem data;
  final VoidCallback? onAdopted;

  const PetItemCard({Key? key, required this.data, this.onAdopted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var result = await Navigator.of(context)
            .pushNamed(PetDetailsPage.routeName, arguments: data);
        if (result == true) {
          onAdopted?.call();
        }
      },
      child: Card(
        color: data.isAvailable
            ? Theme.of(context).cardColor
            : Theme.of(context).disabledColor,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.dimen8),
          child: ListTile(
            leading: Hero(
              tag: data.id,
              child: CircleAvatar(
                radius: Dimens.dimen40,
                backgroundColor: Colors.black26,
                onBackgroundImageError: (e, trace) {
                  //ignored
                },
                backgroundImage: NetworkImage(data.photoUrl),
              ),
            ),
            title: Hero(
              tag: "${data.id}_name",
              child: Text(
                data.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(context, '${Strings.species}: ${data.species}'),
                buildText(context, '${Strings.breed}: ${data.breed}'),
                buildText(context, '${Strings.age}: ${data.age}'),
              ],
            ),
            trailing: Text(
              data.isAvailable
                  ? Constants.statusAvailable
                  : Strings.alreadyAdopted,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: data.isAvailable ? Colors.green : Colors.red,
                overflow: TextOverflow.clip,
              ),
              maxLines: 2,
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
