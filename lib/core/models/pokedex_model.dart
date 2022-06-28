
class PokedexModel {
  String name;
  double height;
  double weight;
  String image;

  PokedexModel({
    required this.name, required this.height, 
    required this.weight, required this.image
  });

  factory PokedexModel.fromJson(Map<String, dynamic> json) {
    return PokedexModel(
      name: "${json["name"].toString()[0].toUpperCase()}${json["name"].toString().substring(1)}",
      height: double.parse(json["height"].toString()),
      weight: double.parse(json["weight"].toString()),
      image: json["sprites"]["front_default"]
    );
  }

}