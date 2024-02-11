import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_master_detail/di/app_modules.dart';
import 'package:poke_master_detail/model/pokemon.dart';
import 'package:poke_master_detail/presentation/common/base/resource_state.dart';
import 'package:poke_master_detail/presentation/common/extensions/state_extensions.dart';
import 'package:poke_master_detail/presentation/common/localization/app_localizations.dart';
import 'package:poke_master_detail/presentation/common/resources/app_colors.dart';
import 'package:poke_master_detail/presentation/common/resources/app_styles.dart';
import 'package:poke_master_detail/presentation/common/widget/error/error_overlay.dart';
import 'package:poke_master_detail/presentation/common/widget/loading/loading_overlay.dart';
import 'package:poke_master_detail/presentation/common/widget/pokemon/custom_background.dart';
import 'package:poke_master_detail/presentation/common/widget/pokemon/panel.dart';
import 'package:poke_master_detail/presentation/navigation/navigation_routes.dart';
import 'package:poke_master_detail/presentation/view/pokemon/provider/fav_pokemon_provider.dart';
import 'package:poke_master_detail/presentation/view/pokemon/viewmodel/pokemon_view_model.dart';
//import 'package:share_plus/share_plus.dart';

class FavPokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;

  const FavPokemonDetailPage({Key? key, required this.pokemon})
      : super(key: key);

  @override
  State<FavPokemonDetailPage> createState() => _FavPokemonDetailPageState();
}

class _FavPokemonDetailPageState extends State<FavPokemonDetailPage> {
  final _pokemonViewModel = inject<PokemonViewModel>();
  final _favPokemonProvider = inject<FavPokemonProvider>();
  bool isFavorite = false;

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

    listenToProvider(_favPokemonProvider, () {
      _pokemonViewModel.isFavoritePokemons(widget.pokemon);
    });

    _pokemonViewModel.isFavoritePokemons(widget.pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        pokemon: widget.pokemon,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:
                AppColors.getColorType(widget.pokemon.types.first.type.name),
            title: Text(widget.pokemon.name.toUpperCase()),
          ),
          body: _body(),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                if (isFavorite) {
                  _pokemonViewModel.removeFavoritePokemons(widget.pokemon);
                } else {
                  _pokemonViewModel.addFavoritePokemons(widget.pokemon);
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
        ));
  }

  Widget _body() {
    final responsive = MediaQuery.of(context).size;
    return Container(
      height: responsive.height,
      color: AppColors.getColorType(widget.pokemon.types.first.type.name),
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
          tag: widget.pokemon.name,
          child: SizedBox(
            height: responsive.width / 2.3,
            width: responsive.width / 2.3,
            child: Image(
              image: CachedNetworkImageProvider(
                widget.pokemon.sprites.frontDefault,
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
          extra: widget.pokemon.toJson())),
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
            '${AppLocalizations.of(context)!.height} ${widget.pokemon.height}',
            style: AppStyles.appTheme.textTheme.bodyMedium,
          ),
          Text(
            '${AppLocalizations.of(context)!.weight} ${widget.pokemon.weight}',
            style: AppStyles.appTheme.textTheme.bodyMedium,
          ),
          Text(
            '${AppLocalizations.of(context)!.main_type} ${widget.pokemon.types.first.type.name}',
            style: AppStyles.appTheme.textTheme.bodyMedium,
          ),
          widget.pokemon.types.length == 2
              ? Text(
                  '${AppLocalizations.of(context)!.sec_type} ${widget.pokemon.types[1].type.name}',
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
      itemCount: widget.pokemon.abilities.length,
      itemBuilder: (context, index) {
        return _abilityElement(index);
      },
    );
  }

  Widget _abilityElement(int index) {
    return ListTile(
      title: Text(widget.pokemon.abilities[index].ability.name.toUpperCase()),
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
        url = widget.pokemon.sprites.frontDefault;
        break;
      case 1:
        url = widget.pokemon.sprites.backDefault;
        break;
      case 2:
        url = widget.pokemon.sprites.frontFemale ?? '';
        break;
      case 3:
        url = widget.pokemon.sprites.backFemale ?? '';
        break;
      case 4:
        url = widget.pokemon.sprites.frontShiny;
        break;
      case 5:
        url = widget.pokemon.sprites.backShiny;
        break;
      case 6:
        url = widget.pokemon.sprites.frontShinyFemale ?? '';
        break;
      case 7:
        url = widget.pokemon.sprites.backShinyFemale ?? '';
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
            widget.pokemon.stats[index].stat.name.toUpperCase(),
            textAlign: TextAlign.center,
          ),
          Text('${widget.pokemon.stats[index].baseStat}'),
        ],
      ),
    );
  }
}
