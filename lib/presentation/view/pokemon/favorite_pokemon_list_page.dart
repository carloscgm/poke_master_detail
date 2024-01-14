import 'package:flutter/material.dart';
import 'package:poke_master_detail/di/app_modules.dart';
import 'package:poke_master_detail/model/pokemon.dart';
import 'package:poke_master_detail/presentation/common/base/resource_state.dart';
import 'package:poke_master_detail/presentation/common/extensions/state_extensions.dart';
import 'package:poke_master_detail/presentation/common/localization/app_localizations.dart';
import 'package:poke_master_detail/presentation/common/widget/pokemon/fav_grid_card.dart';
import 'package:poke_master_detail/presentation/common/widget/error/error_overlay.dart';
import 'package:poke_master_detail/presentation/common/widget/loading/loading_overlay.dart';
import 'package:poke_master_detail/presentation/navigation/navigation_routes.dart';
import 'package:poke_master_detail/presentation/view/pokemon/provider/fav_pokemon_provider.dart';
import 'package:poke_master_detail/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';

class FavPokemonListPage extends StatefulWidget {
  const FavPokemonListPage({Key? key}) : super(key: key);

  @override
  State<FavPokemonListPage> createState() => _FavPokemonListPageState();
}

class _FavPokemonListPageState extends State<FavPokemonListPage>
    with AutomaticKeepAliveClientMixin {
  final _pokemonViewModel = inject<PokemonViewModel>();
  final _favoritePokemonProvider = inject<FavPokemonProvider>();
  List<Pokemon> _pokemonList = [];

  @override
  void initState() {
    super.initState();

    _pokemonViewModel.pokemonFavoriteListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          LoadingOverlay.hide();
          setState(() {
            _pokemonList = state.data;
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _pokemonViewModel.fetchFavoritePokemons();
          });
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });

    listenToProvider(_favoritePokemonProvider, () {
      _pokemonViewModel.fetchFavoritePokemons();
    });

    _pokemonViewModel.fetchFavoritePokemons();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pokemon_title_fav),
        centerTitle: true,
      ),
      body: _body(context, _pokemonList),
    );
  }

  Widget _body(BuildContext context, List<Pokemon> pokemonList) {
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: pokemonList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
      itemBuilder: (context, index) {
        return FavGridCard(
            pokemon: _pokemonList[index],
            route: NavigationRoutes.favoritePokemonDetailRoute);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pokemonViewModel.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
