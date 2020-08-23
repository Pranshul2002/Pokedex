import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokemon_app/ApiManager/Pokemon.dart';
import 'package:pokemon_app/ApiManager/PokemonApi.dart';
import 'package:pokemon_app/pages/PokemonInfo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(backgroundColor: Colors.black,
      brightness: Brightness.dark
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = true;
  Pokemon _pokemon;
  List<PokemonData> pokemonList = new List<PokemonData>();
  @override
  void initState() {
    _pokemon = new Pokemon();
callData();
    super.initState();
  }
  Future<void> callData() async {
    var pokemonlist = await _pokemon.storeData();
    print(pokemonlist);
    setState(() {
     pokemonList = pokemonlist;
      loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      title: Text("Pokemon" , style: TextStyle(fontSize: 25),),
      centerTitle: true,
    ),
    body: loading ? Center(
        child: new CircularProgressIndicator(
          valueColor:
          new AlwaysStoppedAnimation<Color>(Colors.white),
        )) : ListView.builder(itemCount: pokemonList.length,itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left:16.0,right:16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonInfo(index: index,url: pokemonList[index].url,name:pokemonList[index].name)));
                },
                child: Container(
                  color: Color(0xff1e1e1e),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                        Expanded(
                          child: Stack(
                            children: [ClipRRect(
                              borderRadius: BorderRadius.circular(75.0),
                              child: Container(color: Colors.white,height: 75,width: 75,),
                            ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(8.0),
                                width: MediaQuery.of(context).size.width,
                                height: 75,
                                child: Material(
                                    color: Colors.transparent,
                                    child: CachedNetworkImage(imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + (index+1).toString() + ".png",)),
                              ),

                            ],
                          ),
                        flex: 1,
                        ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(left: 32.0),
                          child: Text(pokemonList[index].name.toUpperCase(),style: TextStyle(fontSize: 16.0),),
                        ),
                      )
                      ],
                  ),
                ),
              ),
            ),
          );
    }),
    );
  }
}
