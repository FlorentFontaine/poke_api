import 'dart:convert';
import 'package:dio/dio.dart';

class PokedexServices {
  static Future fetchPokemon(String page) async {
    Dio dio = Dio();
    var response = await dio.get("https://pokeapi.co/api/v2/pokemon/${page}");
    Map json = jsonDecode(response.toString());

    return json;
  }
}
