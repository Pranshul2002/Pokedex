class PokemonInfoIndividual{
  List abilities = List();
  String base_experience = "";
String weight = "";
  PokemonInfoIndividual(
     { this.abilities, this.base_experience, this.moves,this.weight});

  List moves = List();


  factory PokemonInfoIndividual.fromJson(Map<String, dynamic> json) {
    List arr = json["abilities"];
    List ab= [];
    List moves = json["moves"];
    List mv = [];
    for(int i = 0; i< arr.length;i++){
      ab.add(arr[i]["ability"]["name"]);
    }
    for(int i =0 ; i< moves.length;i++){
      mv.add(moves[i]["move"]["name"]);
    }
    return PokemonInfoIndividual(
      abilities: ab,
      moves: mv,
      base_experience: json["base_experience"].toString(),
      weight: json["weight"].toString()
    );
  }
}