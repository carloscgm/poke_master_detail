import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_master_detail/model/pokemon_list.dart';

class PokedexGridCard extends StatelessWidget {
  final Result pokemon;
  final int index;
  final String route;

  const PokedexGridCard(
      {super.key,
      required this.pokemon,
      required this.route,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => context.go(route, extra: index)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Hero(
              transitionOnUserGestures: true,
              tag: pokemon.name,
              child: Image(
                  image: CachedNetworkImageProvider(
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$index.png',
              )),
            ),
            Text(
              '$index - ${pokemon.name}',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
