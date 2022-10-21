import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'detalleanime.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

    List<String> imageList = ['https://i.pinimg.com/564x/24/9f/02/249f0231843fddb6c2efeaec438cef0e.jpg'
    ,'https://i.pinimg.com/564x/5c/e5/f5/5ce5f513c0861a2a68aca16dbc078dea.jpg'];

 var AnimeApi =
      "https://api.jikan.moe/v4/top/anime";
  List anime = [];
  @override
  Widget build(BuildContext context) {
    var ancho = MediaQuery.of(context).size.width;
    var alto = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 104, 100, 100),
        body: Stack(
          children: [
            Positioned(
               child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
              CarouselSlider(items: imageList.map((e) => ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(e, height:200, width: 100, fit: BoxFit.cover,)
                  ],
                ),
              )).toList(), options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                height: 120
              ))
              ])
            ),
            Positioned(
              top: 90,
              left: 140,
              child: Text(
                "TOP ANIMES",
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
                          var tipo = anime[index]['status'];

                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: anime[index]['status'] == "Currently Airing"
                                          ? Colors.greenAccent
                                          : Colors.pink,
                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                  child: Stack(children: [
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
                                        top: 70,
                                        left: 20,
                                        child: Text(
                                          anime[index]['source'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.white),
                                        )),
                                    Positioned(
                                      bottom: 5,
                                      right: 10,
                                      child: CachedNetworkImage(
                                        imageUrl: anime[index]['images']['jpg']['image_url'],
                                        height: 115,
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
                                      builder: (_) => detalleanime(
                                          animedetalle: anime[index],
                                          color: Colors.green,
                                          idanime: index)));
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
      datosanime();
    }
  }

  void datosanime() {
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
