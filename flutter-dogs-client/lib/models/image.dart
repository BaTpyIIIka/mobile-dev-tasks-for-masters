import 'package:dogs_client_application/models/breed.dart';

class Image {
  final String id;
  final String url;
  final List<Breed> breeds;

  Image._({this.id, this.url, this.breeds});

  factory Image.fromJson(Map<String, dynamic> json) {
    var breedList = (json['breeds'] as List)
        .map((i) => Breed.fromJson(i)).toList();
    return new Image._(
        id: json['id'],
        url: json['url'],
        breeds: breedList
    );
  }
}