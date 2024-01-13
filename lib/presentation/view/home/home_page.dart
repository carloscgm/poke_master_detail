import 'package:flutter/material.dart';
import 'package:poke_master_detail/presentation/common/localization/app_localizations.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.navigationShell}) : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: widget.navigationShell.currentIndex,
      onDestinationSelected: (index) {
        widget.navigationShell.goBranch(
          index,
          initialLocation: index == widget.navigationShell.currentIndex,
        );
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.list),
          label: AppLocalizations.of(context)!.pokemon_title,
        ),
        NavigationDestination(
          icon: const Icon(Icons.favorite_outline),
          label: AppLocalizations.of(context)!.pokemon_title_fav,
        ),
        NavigationDestination(
          icon: const Icon(Icons.info_outlined),
          label: AppLocalizations.of(context)!.about_title,
        ),
      ],
    );
  }
}
