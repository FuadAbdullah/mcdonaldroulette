import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math';
import 'dart:convert';
import 'aboutUs.dart';
import 'menuView.dart';

import 'package:flutter/services.dart';

// Global variables
String _menuID = "";

void main() {
  runApp((_Application()));
}

class _Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "McDonald's Menu Roulette",
      debugShowCheckedModeBanner: false,
      home: _ApplicationResponsive(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.yellow.shade800,
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))),
    );
  }
}

class _ApplicationResponsive extends StatefulWidget {
  @override
  __ApplicationResponsiveState createState() => __ApplicationResponsiveState();
}

class __ApplicationResponsiveState extends State<_ApplicationResponsive> {
  // Array
  List _menuString = [];

  // Object
  final _rnd = new Random();

  // Method
  String _changeMenu() {
    return _menuID = _menuString[_rnd.nextInt(_menuString.length)]["id"];
  }

  void _invokeChange() {
    setState(() {
      _changeMenu();
    });
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/menu.json');
    final data = await json.decode(response);
    setState(() {
      _menuString = data["menu"];
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBarWidget(),
        endDrawer: Drawer(
            child: Container(
          color: Colors.black87,
          child: ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Row(
                  children: <Widget>[
                    TextButton(
                      child: Text(
                        "ABOUT US",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AboutUs()))
                      },
                    )
                  ],
                ),
              ),
            )
          ]),
        )),
        body: Container(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 175.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Horizon',
                      color: Colors.yellow.shade800,
                    ),
                    child: Expanded(
                        child: AnimatedTextKit(
                      animatedTexts: [
                        RotateAnimatedText("Ayam Goreng McD",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Big Mac",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Quarter Pounder With Cheese",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Double Quarter Pounder with Cheese",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Beefburger",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Cheeseburger",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Double Cheeseburger",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("McChicken",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Spicy Chicken McDeluxe",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Grilled Chicken Burger",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Chicken McNuggets",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Fillet-O-Fish",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Bubur Ayam McD",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Smoky Grilled Beef",
                            textAlign: TextAlign.center),
                        RotateAnimatedText("Nasi Lemak McD",
                            textAlign: TextAlign.center),
                      ],
                      repeatForever: true,
                    )),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _invokeChange();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuView(id: _menuID)));
                    },
                    child: Text(
                      "Randomize",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.redAccent
                    ),
                  )
                ],
              ),
            )));
  }

  // Widgets
  Widget _appBarWidget() {
    return AppBar(
      title: Text("McDonald's Menu Roulette",
          style: TextStyle(color: Colors.white)),
      centerTitle: true,
    );
  }

  Widget _textWidget(String _text) {
    return Text(_text);
  }
}

//
// class _Application extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//        title: "McDonald's Menu Roulette",
//        debugShowCheckedModeBanner: false,
//        home: _ApplicationResponsive()
//     );
//   }
// }
//
// class _ApplicationResponsive extends StatefulWidget {
//   @override
//   __ApplicationResponsiveState createState() => __ApplicationResponsiveState();
// }
//
// class __ApplicationResponsiveState extends State<_ApplicationResponsive> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: _appBarWidget(),
//         body: new Container(
//           alignment: Alignment.center,
//           child: new Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               new Expanded(child: new Text(
//                   "dsadsaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaagdsfdafdfasfdfsadssads"))
//
//             ],
//           )
//         )
//     );
//   }
//
//   // Widgets
//   Widget _appBarWidget() {
//     return new AppBar(
//       title: _textWidget("McDonald's Menu Roulette"),
//       centerTitle: true,
//       foregroundColor: Colors.amber,
//     );
//   }
//
//   Widget _textWidget(String _text) {
//     return new Text(_text);
//    }
//   }
