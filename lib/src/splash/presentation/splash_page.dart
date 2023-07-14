import 'package:flutter/material.dart';
import 'package:pet_adoption/src/database/data_manager.dart';
import 'package:pet_adoption/src/listing/presentation/pages/listing.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initialiseDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void initialiseDataBase() async {
    await DataManager.instance().init();
    Navigator.pushNamed(context, ListingPage.routeName);
  }
}
