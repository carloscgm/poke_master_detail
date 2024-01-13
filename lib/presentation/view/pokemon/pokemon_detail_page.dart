import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_master_detail/di/app_modules.dart';
import 'package:poke_master_detail/model/pokemon.dart';
import 'package:poke_master_detail/presentation/common/base/resource_state.dart';
import 'package:poke_master_detail/presentation/common/localization/app_localizations.dart';
import 'package:poke_master_detail/presentation/common/resources/app_colors.dart';
import 'package:poke_master_detail/presentation/common/resources/app_styles.dart';
import 'package:poke_master_detail/presentation/common/widget/error/error_overlay.dart';
import 'package:poke_master_detail/presentation/common/widget/loading/loading_overlay.dart';
import 'package:poke_master_detail/presentation/navigation/navigation_routes.dart';
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
        : Scaffold(
            appBar: AppBar(
              backgroundColor: _getColorType(),
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
          );
  }

  Widget _body() {
    final responsive = MediaQuery.of(context).size;
    return Container(
      height: responsive.height,
      color: _getColorType(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _firstSection(responsive),
              const SizedBox(height: 15),
              panels(AppLocalizations.of(context)!.stats_title, stats()),
              const SizedBox(height: 15),
              moves(),
              const SizedBox(height: 15),
              panels(AppLocalizations.of(context)!.sprites_title, sprites()),
              const SizedBox(height: 15),
              panels(
                  AppLocalizations.of(context)!.abilities_title, abilities()),
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
          tag: pokemon.sprites.frontDefault,
          child: SizedBox(
            height: responsive.width / 2.3,
            width: responsive.width / 2.3,
            child: Image(
              image: CachedNetworkImageProvider(
                pokemon.sprites.frontDefault,
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
            child: SizedBox(
                height: responsive.width / 2.3,
                child: panels(
                    AppLocalizations.of(context)!.data_title, personalData()))),
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

  Widget panels(String titlePanel, Widget child) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 8, top: 5),
              child: Text(
                titlePanel,
                style: AppStyles.appTheme.textTheme.titleMedium,
              )),
          const SizedBox(height: 5),
          SizedBox(width: double.infinity, child: child),
          const SizedBox(height: 5),
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
      title: Text(pokemon.abilities[index].ability.name.toUpperCase()),
      onTap: () {},
    );
  }

  Widget sprites() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _spriteElement(0),
          _spriteElement(1),
          _spriteElement(2),
          _spriteElement(3),
          _spriteElement(4),
          _spriteElement(5),
          _spriteElement(6),
          _spriteElement(7),
        ],
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
      children: [
        _statElement(0),
        _statElement(1),
        _statElement(2),
        _statElement(3),
        _statElement(4),
      ],
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

  Color _getColorType() {
    switch (pokemon.types.first.type.name) {
      case "normal":
        return AppColors.normalColor.withOpacity(0.3);
      case "fighting":
        return AppColors.fightingColor.withOpacity(0.3);
      case "flying":
        return AppColors.flyingColor.withOpacity(0.3);
      case "poison":
        return AppColors.poisonColor.withOpacity(0.3);
      case "ground":
        return AppColors.groundColor.withOpacity(0.3);
      case "rock":
        return AppColors.rockColor.withOpacity(0.3);
      case "bug":
        return AppColors.bugColor.withOpacity(0.3);
      case "ghost":
        return AppColors.ghostColor.withOpacity(0.3);
      case "steel":
        return AppColors.steelColor.withOpacity(0.3);
      case "fire":
        return AppColors.fireColor.withOpacity(0.3);
      case "water":
        return AppColors.waterColor.withOpacity(0.3);
      case "grass":
        return AppColors.grassColor.withOpacity(0.3);
      case "electric":
        return AppColors.electricColor.withOpacity(0.3);
      case "psychic":
        return AppColors.psychicColor.withOpacity(0.3);
      case "ice":
        return AppColors.iceColor.withOpacity(0.3);
      case "dragon":
        return AppColors.dragonColor.withOpacity(0.3);
      case "dark":
        return AppColors.darkColor.withOpacity(0.3);
      case "fairy":
        return AppColors.fairyColor.withOpacity(0.3);
      case "unknown":
        return AppColors.unknownColor.withOpacity(0.3);
      case "shadow":
        return AppColors.shadowColor.withOpacity(0.3);
    }
    return AppColors.unknownColor.withOpacity(0.3);
  }
}
