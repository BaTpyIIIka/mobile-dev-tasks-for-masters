import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BreedDetailsScreen.dart';

class SecondScreen extends StatelessWidget {
  final int breedId;
  final String breedName;

  const SecondScreen({Key key, this.breedId, this.breedName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(breedName)),
        body: Center(child: BreedDetailsScreen(breedId: breedId)));
  }
}
