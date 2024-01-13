import 'package:poke_master_detail/model/pokemon.dart';
import 'package:poke_master_detail/model/pokemon_list.dart';

abstract class PokemonRepository {
  Future<Pokemonlist> getPokemons();
  Future<Pokemon> getPokemonById(int id);
  Future<Pokemonlist> getNextPokemons();
  Future<List<Pokemon>> getFavoritePokemons();
  Future<List<Pokemon>> addFavoritePokemon(Pokemon pokemon);
  Future<List<Pokemon>> removeFavoritePokemon(Pokemon pokemon);
  Future<bool> isFavoritePokemon(Pokemon pokemon);
}
