import 'package:poke_master_detail/data/pokemon/cache/pokemon_cache_impl.dart';
import 'package:poke_master_detail/data/pokemon/remote/pokemon_remote_impl.dart';
import 'package:poke_master_detail/domain/pokemon_repository.dart';
import 'package:poke_master_detail/model/pokemon.dart';
import 'package:poke_master_detail/model/pokemon_list.dart';

class PokemonDataImpl implements PokemonRepository {
  final PokemonRemoteImpl _remoteImpl;
  final PokemonCacheImpl _cacheImpl;
  String previousRequest = '';
  String nextRequest = '';
  late Pokemonlist result;

  PokemonDataImpl(this._remoteImpl, this._cacheImpl);

  @override
  Future<Pokemonlist> getPokemons() async {
    Pokemonlist pokemonList = await _remoteImpl.getPokemons();

    previousRequest = pokemonList.previous ?? '';
    nextRequest = pokemonList.next ?? '';

    result = pokemonList;

    return pokemonList;
  }

  @override
  Future<Pokemon> getPokemonById(int id) async {
    final cachedPokemon = _cacheImpl.getCachedPokemon(id);

    if (cachedPokemon != null) {
      return cachedPokemon;
    } else {
      final pokemon = await _remoteImpl.getPokemonById(id);
      _cacheImpl.addCachedPokemon(id, pokemon);
      return pokemon;
    }
  }

  @override
  Future<Pokemonlist> getNextPokemons() async {
    Pokemonlist pokemonList = await _remoteImpl.getNextPokemons(nextRequest);

    previousRequest = pokemonList.previous ?? '';
    nextRequest = pokemonList.next ?? '';

    result.add(pokemonList);

    return result;
  }

  @override
  Future<List<Pokemon>> addFavoritePokemon(Pokemon pokemon) {
    _cacheImpl.addFavoritePokemon(pokemon);
    return _cacheImpl.getFavoritePokemons();
  }

  @override
  Future<List<Pokemon>> getFavoritePokemons() async {
    List<Pokemon> l = await _cacheImpl.getFavoritePokemons();
    return l;
  }

  @override
  Future<List<Pokemon>> removeFavoritePokemon(Pokemon pokemon) {
    _cacheImpl.removeFavoritePokemon(pokemon);
    return _cacheImpl.getFavoritePokemons();
  }

  @override
  Future<bool> isFavoritePokemon(Pokemon pokemon) {
    return _cacheImpl.isFavoritePokemon(pokemon);
  }
}
