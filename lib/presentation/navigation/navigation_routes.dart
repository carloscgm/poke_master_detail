import 'package:flutter/widgets.dart';
import 'package:poke_master_detail/model/pokemon.dart';
import 'package:poke_master_detail/presentation/view/about/about_page.dart';
import 'package:poke_master_detail/presentation/view/home/home_page.dart';
import 'package:poke_master_detail/presentation/view/pokemon/fav_pokemon_detail_page.dart';
import 'package:poke_master_detail/presentation/view/pokemon/favorite_pokemon_list_page.dart';
import 'package:poke_master_detail/presentation/view/pokemon/moves_pokemon_list_page.dart';
import 'package:poke_master_detail/presentation/view/pokemon/pokemon_detail_page.dart';
import 'package:poke_master_detail/presentation/view/pokemon/pokemon_list_page.dart';
import 'package:poke_master_detail/presentation/view/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRoutes {
  // Route paths (for subroutes) - private access
  static const String _pokemonDetailPath = 'detail';
  static const String _favPokemonDetailPath = 'favdetail';
  static const String _movesPokemonPath = 'moves';

  // Route names
  static const String initialRoute = '/';

  static const String pokemonRoute = '/pokemon';
  static const String pokemonDetailRoute = '$pokemonRoute/$_pokemonDetailPath';
  static const String movesPokemonDetailRoute =
      '$pokemonDetailRoute/$_movesPokemonPath';

  static const String favoritePokemonRoute = '/favpokemon';
  static const String favoritePokemonDetailRoute =
      '$favoritePokemonRoute/$_favPokemonDetailPath';
  static const String movesfavoritePokemonDetailRoute =
      '$favoritePokemonDetailRoute/$_movesPokemonPath';

  static const String aboutRoute = '/about';
}

// Nav keys
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _pokemonNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _aboutNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _favPokemonNavigatorKey =
    GlobalKey<NavigatorState>();

final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: NavigationRoutes.pokemonRoute,
    routes: [
      // Routes
      GoRoute(
          path: NavigationRoutes.initialRoute,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const SplashPage()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => HomePage(navigationShell: shell),
        branches: [
          StatefulShellBranch(navigatorKey: _pokemonNavigatorKey, routes: [
            GoRoute(
                path: NavigationRoutes.pokemonRoute,
                parentNavigatorKey: _pokemonNavigatorKey,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: PokemonListPage()),
                routes: [
                  GoRoute(
                    path: NavigationRoutes._pokemonDetailPath,
                    builder: (context, state) {
                      final extra = state.extra as int;
                      return PokemonDetailPage(index: extra);
                    },
                    routes: [
                      GoRoute(
                        path: NavigationRoutes._movesPokemonPath,
                        builder: (context, state) {
                          final extra = state.extra as Map<String, dynamic>;
                          return MovesPokemonPage(
                              pokemon: Pokemon.fromJson(extra));
                        },
                      )
                    ],
                  ),
                ]),
          ]),
          StatefulShellBranch(navigatorKey: _favPokemonNavigatorKey, routes: [
            GoRoute(
                path: NavigationRoutes.favoritePokemonRoute,
                parentNavigatorKey: _favPokemonNavigatorKey,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: FavPokemonListPage()),
                routes: [
                  GoRoute(
                      path: NavigationRoutes._favPokemonDetailPath,
                      builder: (context, state) {
                        final extra = state.extra as Pokemon;
                        return FavPokemonDetailPage(pokemon: extra);
                      },
                      routes: [
                        GoRoute(
                          path: NavigationRoutes._movesPokemonPath,
                          builder: (context, state) {
                            final extra = state.extra as Map<String, dynamic>;
                            return MovesPokemonPage(
                                pokemon: Pokemon.fromJson(extra));
                          },
                        )
                      ]),
                ]),
          ]),
          StatefulShellBranch(navigatorKey: _aboutNavigatorKey, routes: [
            GoRoute(
                path: NavigationRoutes.aboutRoute,
                parentNavigatorKey: _aboutNavigatorKey,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: AboutPage())),
          ])
        ],
      ),
    ]);
