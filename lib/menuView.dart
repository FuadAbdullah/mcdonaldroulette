import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/services.dart';



class MenuView extends StatefulWidget {
  final id;
  MenuView({
    this.id
  });

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {

  List _menuString = [];
  String _menuName = "test";
  String _menuUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/VAN_CAT.png/1024px-VAN_CAT.png";

  Future<void> fetchJson() async {
    final String response = await rootBundle.loadString('assets/menu.json');
    final data = await json.decode(response);
    setState(() {
      _menuString = data["menu"];
      _menuName = _menuString[int.parse(widget.id) - 1]["name"];
      _menuUrl = _menuString[int.parse(widget.id) - 1]["imgurl"];
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
        title: Text(_menuName, style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            decoration: TextDecoration.underline
        )),
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
                    height: 300, width: 300,
                    child:ClipOval(
                      child: Container(
                        color: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl: _menuUrl,
                          height: 300,
                          width: 200,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                  )),
                ),
        FlatButton(
          color: Colors.red,
        child: Text("Order Now"),
    onPressed: () {
          launch("https://www.mcdelivery.com.my/my/").then((e) => print("Success")).catchError((err) => {print(err)});
    },
    )]
          )
      )
  );
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