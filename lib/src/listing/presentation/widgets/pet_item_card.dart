import 'package:flutter/material.dart';
import 'package:pet_adoption/src/details/presentation/pages/details_page.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';
import 'package:pet_adoption/src/utils/constants.dart';
import 'package:pet_adoption/src/utils/strings.dart';

class PetItemCard extends StatelessWidget {
  final PetItem data;
  final VoidCallback? onAdopted;

  const PetItemCard({Key? key, required this.data, this.onAdopted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        var result = await Navigator.of(context)
            .pushNamed(PetDetailsPage.routeName, arguments: data);
        if(result == true){
          onAdopted?.call();
        }
      },
      child: Card(
        color: data.isAvailable
            ? Theme.of(context).cardColor
            : Theme.of(context).disabledColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Hero(
              tag: data.id,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.black26,
                onBackgroundImageError: (e, trace){
                  //ignored
                },
                backgroundImage: NetworkImage(data.photoUrl),
              ),
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
}
