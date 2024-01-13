class NetworkEndpoints {
  //static const String _baseUrl = "https://5178af27-2e3e-481f-ad80-7c5e7703f0ee.mock.pstmn.io/";
  static const String _baseUrl = "https://pokeapi.co/api/v2/";

  static String loginUrl = "${_baseUrl}oauth/token";
  static String refreshTokenUrl = "${_baseUrl}oauth/token";
  static String artistsUrl =
      "https://5178af27-2e3e-481f-ad80-7c5e7703f0ee.mock.pstmn.io/items";
  static String pokemonListUrl = "${_baseUrl}pokemon";
  static String pokemonDetailUrl = "${_baseUrl}pokemon/";
}
