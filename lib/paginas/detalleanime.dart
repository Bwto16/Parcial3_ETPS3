import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class detalleanime extends StatefulWidget {
  final animedetalle;
  final Color color;
  final int idanime;

  const detalleanime(
      {super.key,
      required this.animedetalle,
      required this.color,
      required this.idanime});
  @override
  State<detalleanime> createState() => _detalleanimeState();
}

class _detalleanimeState extends State<detalleanime> {
  @override
  Widget build(BuildContext context) {
    var anchodeta = MediaQuery.of(context).size.width;
    var altodeta = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 40,
            left: 1,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 80,
            left: 20,
            child: Text(
              widget.animedetalle['title'],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
          ),
          Positioned(
            top: 120,
            left: 20,
            child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                  child: Text(
                    widget.animedetalle['status'],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.black26)),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: anchodeta,
              height: altodeta * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: anchodeta * 0.3,
                                  child: Text(
                                    "Nombre :",
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 16),
                                  )),
                              Container(
                                  width: anchodeta * 0.3,
                                  child: Text(
                                    widget.animedetalle['title'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: anchodeta * 0.3,
                                  child: Text(
                                    "Nombre en Japones :",
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 16),
                                  )),
                              Container(
                                  width: anchodeta * 0.5,
                                  child: Text(
                                    widget.animedetalle['title_japanese'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: anchodeta * 0.3,
                                  child: Text(
                                    "Enlace :",
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 16),
                                  )),
                              Container(
                                  width: anchodeta * 0.5,
                                  child: Text(
                                    widget.animedetalle['url'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                 width: anchodeta * 0.3,
                                  child: Text(
                                "Duracion :",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18),
                              )),
                              Container(
                                  width: anchodeta * 0.5,
                                  child: Text(
                                    widget.animedetalle['duration'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                 width: anchodeta * 0.3,
                                  child: Text(
                                "Generos :",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18),
                              )),
                              Container(
                                width: anchodeta * 0.2,
                                  child: Text(
                                widget.animedetalle['genres'][0]['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )),
                              Container(
                                width: anchodeta * 0.2,
                                  child: Text(
                                widget.animedetalle['genres'][1]['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )),
                            ]),
                      ),
                    ]),
              ),
            ),
          ),
          Positioned(
            top: (altodeta * 0.18) - 10,
            left: (altodeta / 2) - 240,
            child: CachedNetworkImage(
                imageUrl: widget.animedetalle['images']['jpg']['image_url'],
                height: 230,
                fit: BoxFit.fitHeight),
          )
        ],
      ),
    );
  }
}
