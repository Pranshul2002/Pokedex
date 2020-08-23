import 'dart:convert';

import 'package:http/http.dart' as http;

import 'PokemonInfoIndividual.dart';

class IndividualPokemon {
  String url;

  IndividualPokemon({this.url});

  PokemonInfoIndividual pokemonInfoIndividual = new PokemonInfoIndividual();

  Future<PokemonInfoIndividual> getData1() async {
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        return PokemonInfoIndividual.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
