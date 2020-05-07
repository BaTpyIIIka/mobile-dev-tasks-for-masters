import 'dart:convert';
import 'dart:io';

import 'package:dogs_client_application/models/image.dart' as image;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

class BreedDetailsScreen extends StatefulWidget {
  final int breedId;

  const BreedDetailsScreen({Key key, this.breedId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BreedDetailsState(breedId);
  }
}

class BreedDetailsState extends State<BreedDetailsScreen> {
  final int breedId;
  Future<image.Image> futureImage;

  BreedDetailsState(this.breedId);

  @override
  void initState() {
    super.initState();
    futureImage = fetchImage(breedId: breedId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<image.Image>(
        future: futureImage,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final image = snapshot.data;
            final breed = image.breeds[0];
            return ListView(children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/dog_placeholder.png',
                image: image.url,
                fit: BoxFit.cover,
                height: 240,
                fadeInDuration: const Duration(milliseconds: 250),
              ),
              _breedInformation(),
              _titleSection('Origin', breed.origin),
              _titleSection('Life Span', breed.lifeSpan),
              _titleSection('Weight', breed.weight['metric'] + ' kg'),
              _titleSection('Height', breed.height['metric'] + ' cm'),
              _titleSection('Temperament', breed.temperament),
              _titleSection('Bred For', breed.bredFor)
            ]);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return _buildProgressIndicator();
        });
  }

  Widget _breedInformation() => Container(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Breed Information:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _titleSection(String name, String value) => Container(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      name,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ),
                  Text(
                    value != null && value != '' ? value : 'Unknown',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildProgressIndicator() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new Opacity(
            opacity: 1.0,
            child: new CircularProgressIndicator(),
          ),
        ),
      );
}

Future<image.Image> fetchImage({int breedId}) async {
  var queryParams = new Map<String, String>();
  if (breedId != 0) {
    queryParams["breed_id"] = breedId.toString();
  }

  final url = Uri.https('api.thedogapi.com', '/v1/images/search', queryParams);
  print('Sending request to $url');

  final response = await http.get(url);
  print('Response status code: ' + response.statusCode.toString());

  if (response.statusCode != HttpStatus.ok) {
    throw new Exception('error getting image');
  }

  final json = jsonDecode(response.body);
  return image.Image.fromJson(json[0]);
}
