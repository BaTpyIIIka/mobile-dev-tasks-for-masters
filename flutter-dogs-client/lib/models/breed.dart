class Breed {
  final int id;
  final String name;
  final String bredFor;
  final String breedGroup;
  final String lifeSpan;
  final String temperament;
  final String origin;
  final Map<String, String> weight;
  final Map<String, String> height;

  Breed._(
      {this.id,
      this.name,
      this.bredFor,
      this.breedGroup,
      this.lifeSpan,
      this.temperament,
      this.origin,
      this.weight,
      this.height});

  factory Breed.fromJson(Map<String, dynamic> json) {
    return new Breed._(
      id: json['id'],
      name: json['name'],
      bredFor: json['bred_for'],
      breedGroup: json['breed_group'],
      lifeSpan: json['life_span'],
      temperament: json['temperament'],
      origin: json['origin'],
      weight: Map<String, String>.from(json['weight']),
      height: Map<String, String>.from(json['height'])
    );
  }
}
