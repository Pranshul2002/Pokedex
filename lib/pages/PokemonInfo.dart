import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/ApiManager/IndividualPokemon.dart';
import 'package:pokemon_app/ApiManager/PokemonInfoIndividual.dart';

class PokemonInfo extends StatefulWidget {
  int index;
  String url;
String name;
  PokemonInfo({this.index, this.url,this.name});

  @override
  _PokemonInfoState createState() => _PokemonInfoState();
}

class _PokemonInfoState extends State<PokemonInfo> {
IndividualPokemon individualPokemon;
PokemonInfoIndividual pokemonInfoIndividual;
bool loading = true;
@override
  void initState() {
  individualPokemon = IndividualPokemon(url: widget.url);
  getPokeData();
    super.initState();
  }
  getPokeData()async{
var    pokemonInfoIndividual1 =  await individualPokemon.getData1();
  setState(() {
    pokemonInfoIndividual = pokemonInfoIndividual1;

  loading = false;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(backgroundColor: Colors.transparent,
        title: Text(widget.name.toUpperCase() , style: TextStyle(fontSize: 25),),
        centerTitle: true,),

      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Stack(alignment: Alignment.topCenter,
              children: [
                Container(alignment: Alignment.topRight,height: 200,color: Colors.transparent,child: loading?null:Text(pokemonInfoIndividual.base_experience,style: TextStyle(fontSize: 25),),),
                Container(alignment: Alignment.bottomRight,height: 200,color: Colors.transparent,child: loading?null:Text(pokemonInfoIndividual.weight,style: TextStyle(fontSize: 25),),),
                Container(
                  height: 200,
                  child: CachedNetworkImage(imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/" + (widget.index+1).toString() + ".png",),
                ),

              ],

            ),
            loading? Center(
                child: new CircularProgressIndicator(
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.white),
                )) : Expanded(
                  child: ListView(
              children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0,bottom: 16.0),
                    child: ExpansionTile(title: Text("Abilities"),children: [
                      for(String a in pokemonInfoIndividual.abilities)
                        Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(a.toUpperCase()))
                    ],),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                  child: ExpansionTile(title: Text("Moves"),children: [
                    for(String a in pokemonInfoIndividual.moves)
                      Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(a.toUpperCase()))
                  ],),
                ),
              ],
            ),
                )
          ],
        ),

      ),
    );
  }
}


