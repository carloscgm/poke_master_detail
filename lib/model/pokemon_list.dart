import 'dart:convert';

Pokemonlist pokemonlistFromJson(String str) =>
    Pokemonlist.fromJson(json.decode(str));

String pokemonlistToJson(Pokemonlist data) => json.encode(data.toJson());

class Pokemonlist {
  final int count;
  final String? next;
  final String? previous;
  final List<Result> results;

  Pokemonlist({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory Pokemonlist.fromJson(Map<String, dynamic> json) => Pokemonlist(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  void add(Pokemonlist list) {
    for (var element in list.results) {
      results.add(element);
    }
  }
}

class Result {
  final String name;
  final String url;

  Result({
    required this.name,
    required this.url,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
