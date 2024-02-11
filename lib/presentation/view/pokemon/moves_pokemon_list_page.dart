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
        backgroundColor:
            AppColors.getColorType(widget.pokemon.types.first.type.name),
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
}
