import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Pokemon.dart';
var base_url = "https://pokeapi.co/api/v2/pokemon?limit=1048";
class Pokemon{
  List<PokemonData> pokemon = new List<PokemonData>();

static Future<List> getData()async{
 try{
   var response = await http.get(base_url);
   if(response.statusCode == 200){
  var body = jsonDecode(response.body);
   List posts = body["results"];
   return posts;
   }else{
     print(response.statusCode);
   }
 }catch(e){
   print(e);
 }
  }
  Future<List<PokemonData>> storeData() async{
  List posts = await getData();
if(posts != null){
  for(int i = 0; i < posts.length; i++){
    PokemonData _pokemon = new PokemonData();
    _pokemon.name = posts[i]["name"];
    _pokemon.url = posts[i]["url"];
    pokemon.add(_pokemon);
  }
  return pokemon;
}
else{
print("error");
}
  }
}

