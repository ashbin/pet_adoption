import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class AppPhotoView extends StatelessWidget {
  static const routeName = '/photo_view';

  final String imageUrl;

  const AppPhotoView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          PhotoView(imageProvider: NetworkImage(imageUrl)),
          Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                iconSize: kToolbarHeight - 4,
                onPressed: () => Navigator.of(context).maybePop(),
                icon: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: kToolbarHeight/2 -2 ,
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
              ))
        ],
      )),
    );
  }
}
