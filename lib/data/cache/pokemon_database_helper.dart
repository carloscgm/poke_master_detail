import 'package:poke_master_detail/data/cache/base/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'database_tables.dart';

class PokemonDatabaseHelper extends DatabaseHelper {
  PokemonDatabaseHelper() : super('pokemon_database.db');

  @override
  void onCreate(Database db, int version) async {
    // Create db tables
    final batch = db.batch();

    _createFavoritePokemonTable(batch);

    await batch.commit();
  }

  _createFavoritePokemonTable(Batch batch) {
    batch.execute(
        '''CREATE TABLE IF NOT EXISTS ${DatabaseTables.pokemon} (id INTEGER PRIMARY KEY, name TEXT, json TEXT)''');
  }
}
