import 'package:flutter/material.dart';
import 'package:poke_master_detail/model/pokemon.dart';
import 'package:poke_master_detail/presentation/common/localization/app_localizations.dart';
import 'package:poke_master_detail/presentation/common/resources/app_colors.dart';
//import 'package:share_plus/share_plus.dart';

class MovesPokemonPage extends StatefulWidget {
  final Pokemon pokemon;

  const MovesPokemonPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<MovesPokemonPage> createState() => _MovesPokemonPageState();
}

class _MovesPokemonPageState extends State<MovesPokemonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _getColorType(),
        title: Text(widget.pokemon.name.toUpperCase()),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: widget.pokemon.moves.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
            expandedAlignment: Alignment.center,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.all(2),
            title: Text(widget.pokemon.moves[index].move.name),
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  AppLocalizations.of(context)!.how_moves,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context)!.game,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppLocalizations.of(context)!.level,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppLocalizations.of(context)!.source,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              howGetThisMoveList(index),
            ]);
      },
    );
  }

  Widget howGetThisMoveList(int index) {
    return ListView.builder(
      itemCount: widget.pokemon.moves[index].versionGroupDetails.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index2) {
        return Container(
          color: index2 % 2 == 0 ? Colors.white : Colors.grey.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  widget.pokemon.moves[index].versionGroupDetails[index2]
                      .versionGroup.name,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${widget.pokemon.moves[index].versionGroupDetails[index2].levelLearnedAt}',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  widget.pokemon.moves[index].versionGroupDetails[index2]
                      .moveLearnMethod.name,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getColorType() {
    switch (widget.pokemon.types.first.type.name) {
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
