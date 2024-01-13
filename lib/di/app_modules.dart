import 'package:poke_master_detail/data/cache/memory_cache.dart';
import 'package:poke_master_detail/data/cache/pokemon_database_helper.dart';
import 'package:poke_master_detail/data/pokemon/cache/pokemon_cache_impl.dart';
import 'package:poke_master_detail/data/pokemon/pokemon_data_impl.dart';
import 'package:poke_master_detail/data/pokemon/remote/pokemon_remote_impl.dart';
import 'package:poke_master_detail/data/remote/http_client.dart';
import 'package:poke_master_detail/domain/pokemon_repository.dart';
import 'package:poke_master_detail/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupMainModule();
    _setupPokemonModule();
  }

  _setupMainModule() {
    inject.registerSingleton(HttpClient());
    inject.registerSingleton(MemoryCache());
    inject.registerSingleton(PokemonDatabaseHelper());
  }

  _setupPokemonModule() {
    inject.registerFactory(() => PokemonRemoteImpl(inject.get()));
    inject.registerFactory(() => PokemonCacheImpl(inject.get(), inject.get()));
    inject.registerFactory<PokemonRepository>(
        () => PokemonDataImpl(inject.get(), inject.get()));
    inject.registerFactory(() => PokemonViewModel(inject.get()));
  }
}
