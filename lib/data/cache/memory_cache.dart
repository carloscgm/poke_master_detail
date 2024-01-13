import 'package:poke_master_detail/model/pokemon.dart';

class MemoryCache {
  // Singleton class
  static final MemoryCache _memoryCache = MemoryCache._internal();

  factory MemoryCache() {
    return _memoryCache;
  }

  MemoryCache._internal() {
    // Empty constructor
  }

  //CacheData
  Map<int, Pokemon> pokemonList = {};

  clearAll() {
    pokemonList = {};
  }
}
