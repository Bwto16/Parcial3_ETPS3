import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'detalleanime.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 var AnimeApi =
      "https://api.jikan.moe/v4/top/anime";
  List anime = [];
  @override
  Widget build(BuildContext context) {
    var ancho = MediaQuery.of(context).size.width;
    var alto = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              bottom: -50,
              right: -50,
              child: Image.asset(
                "assets/img/pokeball.png",
                width: 200,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Text(
                "Pokedex UTEC",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Positioned(
              top: 150,
              bottom: 0,
              width: ancho,
              child: Column(children: [
                anime.length != null
                    ? Expanded(
                        child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.4),
                        itemCount: anime.length,
                        itemBuilder: (context, index) {
                          var tipo = anime[index]['type'];

                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: anime[index]['type'] == "TV"
                                          ? Colors.greenAccent
                                          : Colors.pink,
                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                  child: Stack(children: [
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Image.asset(
                                        "assets/img/pokeball.png",
                                        height: 50,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    Positioned(
                                        top: 10,
                                        left: 20,
                                        child: Text(
                                          anime[index]['title'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    Positioned(
                                        top: 45,
                                        left: 20,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                                top: 4,
                                                bottom: 4),
                                            child: Text(tipo.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10)),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.black26),
                                        )),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: CachedNetworkImage(
                                        imageUrl: anime[index]['images']['jpg']['image_url'],
                                        height: 80,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ])),
                            ),
                            onTap: () {
                              //TODO: llamar pantalla
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DetallePokemon(
                                          pokemonDetalle: anime[index],
                                          color: Colors.green,
                                          idpokemon: index)));
                            },
                          );
                        },
                      ))
                    : Center(
                        child: CircularProgressIndicator(),
                      )
              ]),
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      detalleanime();
    }
  }

  void detalleanime() {
    var url = Uri.https('api.jikan.moe',
        '/v4/top/anime');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodejsonData = jsonDecode(value.body);
        anime = decodejsonData['data'];
        setState(() {});
      }
      //  print(decodejsonData);
    });
    //200 correcto
    //404 incorrecto
    //500
    //505,504,505
  }
}
