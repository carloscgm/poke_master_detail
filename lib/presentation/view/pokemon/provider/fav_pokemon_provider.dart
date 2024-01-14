import 'package:flutter/material.dart';

class FavPokemonProvider extends ChangeNotifier {
  void onFavoriteListUpdated() {
    notifyListeners();
  }
}
