import 'package:poke_master_detail/data/remote/error/remote_error_mapper.dart';
import 'package:poke_master_detail/data/remote/http_client.dart';
import 'package:poke_master_detail/data/remote/network_endpoints.dart';
import 'package:poke_master_detail/model/pokemon.dart';
import 'package:poke_master_detail/model/pokemon_list.dart';

class PokemonRemoteImpl {
  final HttpClient _httpClient;
  PokemonRemoteImpl(this._httpClient);

  Future<Pokemonlist> getPokemons() async {
    try {
      dynamic response =
          await _httpClient.dio.get(NetworkEndpoints.pokemonListUrl);

      Pokemonlist list = Pokemonlist.fromJson(response.data);

      return list;
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<Pokemon> getPokemonById(int id) async {
    try {
      dynamic response =
          await _httpClient.dio.get('${NetworkEndpoints.pokemonDetailUrl}$id');

      Pokemon pokemon = Pokemon.fromJson(response.data);

      return pokemon;
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<Pokemonlist> getNextPokemons(String url) async {
    try {
      dynamic response = await _httpClient.dio.get(url);

      Pokemonlist list = Pokemonlist.fromJson(response.data);

      return list;
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<Pokemon> getPokemonByUrl(String url) async {
    try {
      dynamic response = await _httpClient.dio.get(url);

      Pokemon pokemon = Pokemon.fromJson(response.data);

      return pokemon;
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }
}
