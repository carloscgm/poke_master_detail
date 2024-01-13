import 'package:poke_master_detail/data/cache/database_tables.dart';
import 'package:poke_master_detail/data/cache/error/cache_error_mapper.dart';
import 'package:poke_master_detail/data/cache/pokemon_database_helper.dart';
import 'package:poke_master_detail/model/pokemon.dart';
import 'dart:convert';

class PokemonCacheImpl {
  final PokemonDatabaseHelper _pokemonDatabaseHelper;

  PokemonCacheImpl(this._pokemonDatabaseHelper);

  Future<List<Pokemon>> getFavoritePokemons() async {
    try {
      return (await _pokemonDatabaseHelper.getAll(DatabaseTables.pokemon)).map(
        (e) {
          Map<String, dynamic> map = e;
          Map<String, dynamic> pokemonData = json.decode(map['json']);
          Pokemon p = Pokemon.fromJson(pokemonData);
          return p;
        },
      ).toList();
    } catch (e) {
      throw CacheErrorMapper.getException(e);
    }
  }

  Future<void> addFavoritePokemon(Pokemon pokemon) async {
    try {
      Map<String, dynamic> map = {
        'id': pokemon.id,
        'name': pokemon.name,
        'json': json.encode(pokemon.toJson()),
      };

      await _pokemonDatabaseHelper.insert(DatabaseTables.pokemon, map);
    } catch (e) {
      throw CacheErrorMapper.getException(e);
    }
  }

  Future<void> removeFavoritePokemon(Pokemon pokemon) async {
    try {
      await _pokemonDatabaseHelper.delete(
          DatabaseTables.pokemon, MapEntry('id', pokemon.id));
    } catch (e) {
      throw CacheErrorMapper.getException(e);
    }
  }

  Future<bool> isFavoritePokemon(Pokemon pokemon) async {
    try {
      await _pokemonDatabaseHelper.get(
          DatabaseTables.pokemon, MapEntry('id', pokemon.id));
      // No exception, item exists!
      return true;
    } catch (e) {
      return false;
    }
  }
}
