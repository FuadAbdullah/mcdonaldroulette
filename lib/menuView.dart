import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/services.dart';

class MenuView extends StatefulWidget {
  final id;

  MenuView({this.id});

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  List _menuString = [];
  String _menuName = "Placeholder";
  String _menuIMG =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/VAN_CAT.png/1024px-VAN_CAT.png";
  String _menuURL = "https://www.mcdonalds.com.my/menu";
  String _menuDesc =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.";

  Future<void> fetchJson() async {
    final String response = await rootBundle.loadString('assets/menu.json');
    final data = await json.decode(response);
    setState(() {
      _menuString = data["menu"];
      _menuName = _menuString[int.parse(widget.id) - 1]["name"];
      _menuIMG = _menuString[int.parse(widget.id) - 1]["imgurl"];
      _menuURL = _menuString[int.parse(widget.id) - 1]["menurl"];
      _menuDesc = _menuString[int.parse(widget.id) - 1]["desc"] == "null"
          ? "No Description Provided"
          : _menuString[int.parse(widget.id) - 1]["desc"];
    });
  }

  @override
  void initState() {
    fetchJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_menuName,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.underline)),
          centerTitle: true,
        ),
        body: Container(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SizedBox(
                        height: 300,
                        width: 300,
                        child: ClipOval(
                          child: Container(
                            color: Colors.white,
                            child: CachedNetworkImage(
                              imageUrl: _menuIMG,
                              height: 300,
                              width: 200,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        )),
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35.0, vertical: 10.0),
                    child: Text(
                      _menuDesc,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red, onPrimary: Colors.redAccent),
                    child: Text(
                      "Order Now",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      launch(_menuURL)
                          .then((e) => print("Success"))
                          .catchError((err) => {print(err)});
                    },
                  )
                ])));
  }
}

//
// final id;
// MenuView({
//   this.id
// });
//
//
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//           child: ListView(
//               children: <Widget>[
//                 Text(id)
//               ]
//           )
//       )
//   );
// }
