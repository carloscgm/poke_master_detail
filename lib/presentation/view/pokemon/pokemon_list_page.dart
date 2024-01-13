import 'package:flutter/material.dart';
import 'package:poke_master_detail/di/app_modules.dart';
import 'package:poke_master_detail/model/pokemon_list.dart';
import 'package:poke_master_detail/presentation/common/base/resource_state.dart';
import 'package:poke_master_detail/presentation/common/localization/app_localizations.dart';
import 'package:poke_master_detail/presentation/common/widget/pokemon/empty_grid_card.dart';
import 'package:poke_master_detail/presentation/common/widget/pokemon/pokedex_grid_card.dart';
import 'package:poke_master_detail/presentation/common/widget/error/error_overlay.dart';
import 'package:poke_master_detail/presentation/common/widget/loading/loading_overlay.dart';
import 'package:poke_master_detail/presentation/navigation/navigation_routes.dart';
import 'package:poke_master_detail/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';
import 'package:shimmer/shimmer.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage>
    with AutomaticKeepAliveClientMixin {
  final controller = ScrollController();
  final _pokemonViewModel = inject<PokemonViewModel>();
  late Pokemonlist _pokemonList;
  bool loadingNext = false;
  bool initLoading = true;

  @override
  void initState() {
    super.initState();

    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        if (!loadingNext) {
          loadingNext = true;
          await _pokemonViewModel.fetchNextPokemons();
        }
      }
    });

    _pokemonViewModel.pokemonListState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          if (initLoading) {
            LoadingOverlay.show(context);
          }
          break;
        case Status.COMPLETED:
          if (initLoading) {
            LoadingOverlay.hide();
          }
          setState(() {
            loadingNext = false;
            initLoading = false;
            _pokemonList = state.data;
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error, onRetry: () {
            _pokemonViewModel.fetchPokemons();
          });
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });

    _pokemonViewModel.fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pokemon_title),
        centerTitle: true,
      ),
      body: initLoading ? _shimmer() : _body(context, _pokemonList),
    );
  }

  Widget _shimmer() {
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade600,
          child: GridView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: 20,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
            itemBuilder: (context, index) => const EmptyGridCard(),
          )),
    );
  }

  Widget _body(BuildContext context, Pokemonlist pokemonList) {
    return GridView.builder(
      controller: controller,
      padding: const EdgeInsets.all(5),
      itemCount: pokemonList.results.length + 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
      itemBuilder: (context, index) {
        if (index == pokemonList.results.length) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return PokedexGridCard(
              pokemon: pokemonList.results[index],
              index: index + 1,
              route: NavigationRoutes.pokemonDetailRoute);
        }
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
