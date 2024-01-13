import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'PokeApi - Flutter MVVM';

  @override
  String get home_title => 'Home';

  @override
  String get pokemon_title => 'Pokedex';

  @override
  String get about_title => 'About';

  @override
  String about_description(Object cleanArch, Object lang) {
    return 'Flutter MVVM Example Project.\n\nDeveloped in $lang following the $cleanArch principles.';
  }

  @override
  String get error_title => 'Error';

  @override
  String get error_default => 'An error has occurred.';

  @override
  String get error_timeout => 'We are experiencing some temporary problems. Please, try again in a few moments.';

  @override
  String get error_no_internet => 'There is no Internet connection. Check your Wi-Fi or mobile data connection, please.';

  @override
  String get error_server => 'We are experiencing some problems at this time. Please come back later.';

  @override
  String get error_empty_field => 'This field can not be empty';

  @override
  String get action_ok => 'OK';

  @override
  String get action_cancel => 'Cancel';

  @override
  String get action_retry => 'Retry';

  @override
  String get how_moves => 'How to get this moves:';

  @override
  String get game => 'Game';

  @override
  String get level => 'Level';

  @override
  String get source => 'Source';

  @override
  String get height => 'Height: ';

  @override
  String get weight => 'Weight: ';

  @override
  String get main_type => 'Main type:';

  @override
  String get sec_type => 'Secondary type:';

  @override
  String get pokemon_title_fav => 'Favorite Pokemons';

  @override
  String get data_title => 'Physical Data';

  @override
  String get stats_title => 'Stats Panel';

  @override
  String get sprites_title => 'Sprites Panel';

  @override
  String get abilities_title => 'Abilities Panel';

  @override
  String get moves_title => 'Moves';
}
