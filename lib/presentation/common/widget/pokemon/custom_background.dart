import 'package:flutter/material.dart';
import 'package:poke_master_detail/model/pokemon.dart';
import 'package:poke_master_detail/presentation/common/resources/app_styles.dart';

class CustomBackground extends StatelessWidget {
  final Pokemon pokemon;
  final Widget child;
  const CustomBackground(
      {super.key, required this.child, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          height: double.infinity,
          width: double.infinity,
          decoration: AppStyles.getBackground(pokemon)),
      child,
    ]);
  }
}
