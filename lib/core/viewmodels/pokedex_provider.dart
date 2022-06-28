import 'package:flutter/material.dart';

import '../models/pokedex_model.dart';
import '../services/pokedex_services.dart';

class PokedexProvider extends ChangeNotifier {
  List<PokedexModel> pokedexList = [];
  List<PokedexModel> get getPokedex => pokedexList;

  int page = 0;
  bool isFetching = false;
  bool get getFetching => isFetching;

  Future<void> getPokemon() async {
    if (pokedexList.isEmpty) {
      pokedexList = <PokedexModel>[];
    }

    for (int i = 1; i < 150; i++) {
      page++;

      var data = await PokedexServices.fetchPokemon(page.toString());
      if (data != null) {
        pokedexList.add(PokedexModel.fromJson(data));
      }
    }

    setFetching(false);
  }

  Future<void> setFetching(bool value) async {
    isFetching = value;
    notifyListeners();
  }

  delete(int value) {
    pokedexList.remove(value);
    notifyListeners();
  }
}
