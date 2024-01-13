import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get app_title => 'PokeApi - Flutter MVVM';

  @override
  String get home_title => 'Inicio';

  @override
  String get pokemon_title => 'Pokedex';

  @override
  String get about_title => 'Acerca de';

  @override
  String about_description(Object cleanArch, Object lang) {
    return 'Ejemplo de MVVM en Flutter.\n\nDesarrollado en lenguaje $lang siguiendo los principios de $cleanArch.';
  }

  @override
  String get error_title => 'Error';

  @override
  String get error_default => 'Ha ocurrido un error.';

  @override
  String get error_timeout => 'Estamos experimentando algunos problemas temporales. Por favor, inténtelo de nuevo en unos minutos.';

  @override
  String get error_no_internet => 'No hay conexión a Internet. Comprueba tu conexión Wi-Fi o de datos móviles, por favor.';

  @override
  String get error_server => 'Estamos experimentando algunos problemas en este momento. Por favor, vuelva de nuevo mas tarde.';

  @override
  String get error_empty_field => 'Este campo no puede estar vacío';

  @override
  String get action_ok => 'Aceptar';

  @override
  String get action_cancel => 'Cancelar';

  @override
  String get action_retry => 'Reintentar';

  @override
  String get how_moves => 'Cómo conseguir este movimiento';

  @override
  String get game => 'Juego';

  @override
  String get level => 'Nivel';

  @override
  String get source => 'Fuente';

  @override
  String get height => 'Altura: ';

  @override
  String get weight => 'Peso: ';

  @override
  String get main_type => 'Tipo principal:';

  @override
  String get sec_type => 'Tipo secundario:';

  @override
  String get pokemon_title_fav => 'Pokemons Favoritos';

  @override
  String get data_title => 'Datos físicos';

  @override
  String get stats_title => 'Panel de Estadísticas';

  @override
  String get sprites_title => 'Panel de imágenes';

  @override
  String get abilities_title => 'Panel de habilidades';

  @override
  String get moves_title => 'Movimientos';
}
