import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/src/details/presentation/bloc/details_bloc.dart';
import 'package:pet_adoption/src/details/presentation/pages/photo_view.dart';
import 'package:pet_adoption/src/listing/domain/entities/listing_entity.dart';
import 'package:pet_adoption/src/utils/strings.dart';

class PetDetailsPage extends StatefulWidget {
  static const routeName = '/details';

  final PetItem data;

  const PetDetailsPage({
    required this.data,
  });

  @override
  State<PetDetailsPage> createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  late DetailsBloc _detailsBloc;

  final confettiController =
      ConfettiController(duration: const Duration(seconds: 1));

  @override
  void initState() {
    _detailsBloc = DetailsBloc(DetailsInitialState(widget.data));
    super.initState();
  }

  void _adoptPet(BuildContext context, PetItem data) {
    if (data.isAvailable) {
      _detailsBloc.add(MarkAdoptedEvent(data.id, DateTime.now()));
    }
  }

  void _showCelebrationToast() {
    confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsBloc, DetailsState>(
        bloc: _detailsBloc,
        listener: (context, state) {
          if (state is DetailsLoadCompleteState) {
            _showCelebrationToast();
          }
        },
        builder: (context, state) {
          var data = state.data;
          return WillPopScope(
            onWillPop: () async{
              Navigator.of(context).pop(state is DetailsLoadCompleteState);
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text(Strings.petDetails),
                leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: (){
                    Navigator.of(context).pop(state is DetailsLoadCompleteState);
                },),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      color:
                          Theme.of(context).canvasColor
                          ,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pushNamed(
                            AppPhotoView.routeName,
                            arguments: data.photoUrl),
                        child: Center(
                          child: Hero(
                            tag: data.id,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                data.isAvailable?Colors.transparent : Colors.grey, // or any other color
                                BlendMode.saturation,
                              ),
                              child: Image.network(
                                data.photoUrl,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons
                                      .image); // Placeholder icon if image fails to load
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 8),
                        Text('Species: ${data.species}'),
                        Text('Breed: ${data.breed}'),
                        Text('Age: ${data.age}'),
                        Text('Gender: ${data.gender}'),
                        Text('Size: ${data.size}'),
                        Text('Coat Color: ${data.coatColor}'),
                        Text('Temperament: ${data.temperament}'),
                        Text('Location: ${data.location}'),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed:
                                data.isAvailable && state is! DetailsLoadingState
                                    ? () => _adoptPet(context, data)
                                    : null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                data.isAvailable ? Colors.green : Colors.grey,
                              ),
                            ),
                            child: const Text(Strings.adopt),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConfettiWidget(
                        blastDirectionality: BlastDirectionality.explosive,
                        // colors: [Theme.of(context).primaryColor],
                        blastDirection: 3 * pi / 2,
                        numberOfParticles: 10,
                        emissionFrequency: 0.4,
                        gravity: 0.2,
                        confettiController: confettiController,
                        shouldLoop: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
