import 'dart:convert';
import 'dart:io';

import 'package:dogs_client_application/models/breed.dart';
import 'package:dogs_client_application/ui/main/SecondScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BreedList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BreedListState();
  }
}

class BreedListState extends State<BreedList> {
  ScrollController _scrollController = new ScrollController();

  List<Breed> breeds = new List();
  int _page = 0;
  final _limit = 15;
  bool isLoading = false;

  @override
  void initState() {
    _loadData(this._limit, this._page++);

    super.initState();
    _scrollController.addListener(() {
      if (!isLoading &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        _loadData(this._limit, this._page);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: breeds.length + 1,
      itemBuilder: (context, index) {
        if (index == breeds.length) {
          return _buildProgressIndicator();
        }
        return Card(
            child: ListTile(
                title: Text(breeds[index].name),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondScreen(
                              breedId: breeds[index].id,
                              breedName: breeds[index].name)),
                    )));
      },
      controller: _scrollController,
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _loadData(int limit, int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }

    final breeds = await fetchBreeds(limit, page);
    setState(() {
      isLoading = false;
      this.breeds.addAll(breeds);
      this._page++;
    });
  }
}

Future<List<Breed>> fetchBreeds(int limit, int page) async {
  var queryParams = {'limit': limit.toString(), 'page': page.toString()};
  final url = Uri.https('api.thedogapi.com', '/v1/breeds', queryParams);
  print('Sending request to $url');

  final response = await http.get(url);
  print('Response status code: ' + response.statusCode.toString());

  if (response.statusCode != HttpStatus.ok) {
    throw new Exception('error getting image');
  }
  return compute(parseBreeds, response.body);
}

List<Breed> parseBreeds(String body) {
  final json = jsonDecode(body).cast<Map<String, dynamic>>();
  return json.map<Breed>((i) => Breed.fromJson(i)).toList();
}
