import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_master_detail/di/app_modules.dart';
import 'package:poke_master_detail/model/pokemon.dart';
import 'package:poke_master_detail/presentation/common/base/resource_state.dart';
import 'package:poke_master_detail/presentation/common/extensions/state_extensions.dart';
import 'package:poke_master_detail/presentation/common/localization/app_localizations.dart';
import 'package:poke_master_detail/presentation/common/resources/app_styles.dart';
import 'package:poke_master_detail/presentation/common/widget/error/error_overlay.dart';
import 'package:poke_master_detail/presentation/common/widget/loading/loading_overlay.dart';
import 'package:poke_master_detail/presentation/common/widget/pokemon/custom_background.dart';
import 'package:poke_master_detail/presentation/common/widget/pokemon/panel.dart';
import 'package:poke_master_detail/presentation/navigation/navigation_routes.dart';
import 'package:poke_master_detail/presentation/view/pokemon/provider/fav_pokemon_provider.dart';
import 'package:poke_master_detail/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';
//import 'package:share_plus/share_plus.dart';

class PokemonDetailPage extends StatefulWidget {
  final int index;

  const PokemonDetailPage({Key? key, required this.index}) : super(key: key);

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  final _pokemonViewModel = inject<PokemonViewModel>();
  final _favPokemonProvider = inject<FavPokemonProvider>();
  bool isFavorite = false;
  late Pokemon pokemon;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    _pokemonViewModel.isFavoritePokemonState.stream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          //LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          LoadingOverlay.hide();
          setState(() {
            loading = false;
            isFavorite = event.data;
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(event.error, onRetry: () {});
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });

    _pokemonViewModel.detailPokemonState.stream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          //LoadingOverlay.hide();
          setState(() {
            pokemon = event.data;
            _pokemonViewModel.isFavoritePokemons(pokemon);
            listenToProvider(_favPokemonProvider, () async {
              _pokemonViewModel.isFavoritePokemons(pokemon);
            });
          });
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(event.error, onRetry: () {});
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });
    _pokemonViewModel.getPokemonById(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : CustomBackground(
            pokemon: pokemon,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text(pokemon.name.toUpperCase()),
              ),
              body: _body(),
              floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    if (isFavorite) {
                      _pokemonViewModel.removeFavoritePokemons(pokemon);
                    } else {
                      _pokemonViewModel.addFavoritePokemons(pokemon);
                    }
                    isFavorite = !isFavorite;
                    setState(() {});
                  },
                  label: isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_outline)),
            ),
          );
  }

  Widget _body() {
    final responsive = MediaQuery.of(context).size;
    return Container(
      height: responsive.height,
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _firstSection(responsive),
              const SizedBox(height: 15),
              Panel(
                  title: AppLocalizations.of(context)!.stats_title,
                  child: stats()),
              const SizedBox(height: 15),
              moves(),
              const SizedBox(height: 15),
              Panel(
                  title: AppLocalizations.of(context)!.sprites_title,
                  child: sprites()),
              const SizedBox(height: 15),
              Panel(
                  title: AppLocalizations.of(context)!.abilities_title,
                  child: abilities()),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Row _firstSection(Size responsive) {
    return Row(
      children: [
        Hero(
          tag: pokemon.name,
          child: SizedBox(
            height: responsive.width / 2.3,
            width: responsive.width / 2.3,
            child: Image(
              image: CachedNetworkImageProvider(
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${widget.index}.png',
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
            child: SizedBox(
                height: responsive.width / 2.3,
                child: Panel(
                    title: AppLocalizations.of(context)!.data_title,
                    child: personalData()))),
      ],
    );
  }

  Widget moves() {
    return GestureDetector(
      onTap: (() => context.push(NavigationRoutes.movesPokemonDetailRoute,
          extra: pokemon.toJson())),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.moves_title,
                  style: AppStyles.appTheme.textTheme.titleMedium,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
                size: 15,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget personalData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppLocalizations.of(context)!.height} ${pokemon.height}',
            style: AppStyles.appTheme.textTheme.bodyMedium,
          ),
          Text(
            '${AppLocalizations.of(context)!.weight} ${pokemon.weight}',
            style: AppStyles.appTheme.textTheme.bodyMedium,
          ),
          Text(
            '${AppLocalizations.of(context)!.main_type} ${pokemon.types.first.type.name}',
            style: AppStyles.appTheme.textTheme.bodyMedium,
          ),
          pokemon.types.length == 2
              ? Text(
                  '${AppLocalizations.of(context)!.sec_type} ${pokemon.types[1].type.name}',
                  style: AppStyles.appTheme.textTheme.bodyMedium,
                )
              : Container(),
        ],
      ),
    );
  }

  Widget abilities() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pokemon.abilities.length,
      itemBuilder: (context, index) {
        return _abilityElement(index);
      },
    );
  }

  Widget _abilityElement(int index) {
    return ListTile(
      title: Text(
        pokemon.abilities[index].ability.name.toUpperCase(),
        style: const TextStyle(color: Colors.black),
      ),
      onTap: () {},
    );
  }

  Widget sprites() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          8,
          (index) => _spriteElement(index),
        ).toList(),
      ),
    );
  }

  Widget _spriteElement(int index) {
    String url = '';
    switch (index) {
      case 0:
        url = pokemon.sprites.frontDefault;
        break;
      case 1:
        url = pokemon.sprites.backDefault;
        break;
      case 2:
        url = pokemon.sprites.frontFemale ?? '';
        break;
      case 3:
        url = pokemon.sprites.backFemale ?? '';
        break;
      case 4:
        url = pokemon.sprites.frontShiny;
        break;
      case 5:
        url = pokemon.sprites.backShiny;
        break;
      case 6:
        url = pokemon.sprites.frontShinyFemale ?? '';
        break;
      case 7:
        url = pokemon.sprites.backShinyFemale ?? '';
        break;
    }

    if (url == '') {
      return Container();
    }

    return CachedNetworkImage(imageUrl: url);
  }

  Widget stats() {
    return Row(
      children: List.generate(5, (index) => _statElement(index)),
    );
  }

  Widget _statElement(int index) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Text(
            pokemon.stats[index].stat.name.toUpperCase(),
            textAlign: TextAlign.center,
          ),
          Text('${pokemon.stats[index].baseStat}'),
        ],
      ),
    );
  }
}
