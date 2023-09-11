import 'dart:math';
import 'package:flutter/material.dart';
import 'package:naruto/network/helper.dart';
import 'package:naruto/screens/fifthscreen.dart';
import 'package:naruto/screens/fourthscree.dart';
import 'package:naruto/screens/seventhscreen.dart';
import 'package:naruto/screens/thirdscreen.dart';
import 'package:naruto/utilities/widget.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool isKeyboardEnabled = true;
  TextEditingController searchKey = TextEditingController();
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final orange = Color(0xffff9346);
  final networkHelper = Helper();
  late Future<Widget> cl;
  late Future<Widget> gen;

  Future<Widget> generateClan() async {
    dynamic clans = await networkHelper.getClans();
    List<Widget> tmp = [];
    for (var element in clans) {
      tmp.add(
        SizedBox(
          width: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FourthScreen(
                      clan: element.id,
                      name: element.name,
                    );
                  }));
                },
                child: Container(
                  width: 70,
                  height: 70,
                  margin: EdgeInsets.symmetric(horizontal: 05, vertical: 02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          spreadRadius: 0,
                          blurStyle: BlurStyle.outer)
                    ],
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20), right: Radius.circular(20)),
                  ),
                  child: Center(
                      child: Text(
                    element.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'naruto', fontSize: 12),
                  )),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget list = ListView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: tmp,
    );

    return list;
  }

  Future<Widget> generateCharacters() async {
    dynamic characters = await networkHelper.getCharacters();
    List<Widget> tmp = [];
    for (var element in characters) {
      tmp.add(
        Container(
          width: 200,
          height: 120,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ThirdScreen(id: element.id);
                  }));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            element.images.length > 0
                                ? element.images[0]
                                : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930',
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 10.0),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.transparent,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      element.name,
                      style: TextStyle(
                        fontFamily: 'Nexa',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox()
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget list = ListView(
      physics: BouncingScrollPhysics(),
      children: tmp,
    );

    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cl = generateClan();
    gen = generateCharacters();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late Future<List<String>> favorites;

  Future<void> addFavorite(newCharacter) async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.getStringList('favorites')!.isEmpty) {
      final List<String> fav = [];
      fav.add(newCharacter);
      setState(() {
        favorites = prefs.setStringList('favorites', fav).then((bool success) {
          return favorites;
        });
      });
    } else {
      print("debut non null");
      final List<String>? fav = prefs.getStringList('favorites');
      fav!.contains(newCharacter) ? 0 : fav.add(newCharacter);
      setState(() {
        favorites = prefs.setStringList('favorites', fav).then((bool success) {
          return favorites;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: key,
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            key.currentState!.openDrawer();
          },
          child: Icon(
            Icons.sort,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20.0),
        //     child: GestureDetector(
        //       onTap: () {
        //         Navigator.push(context, MaterialPageRoute(builder: (context) {
        //           return SeventhScreen();
        //         }));
        //       },
        //       child: Icon(
        //         Icons.favorite,
        //         color: orange,
        //         size: 20,
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: RefreshIndicator(
          color: Color(0xffffa462),
          onRefresh: () async {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return SecondScreen();
            }));
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 40),
                    child: Text('Search For a Character',
                        style: TextStyle(
                            fontFamily: 'Nexa',
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.black)),
                  ),
                  SizedBox()
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 60,
                child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: searchKey,
                  onEditingComplete: () {
                    print(searchKey.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FifthScreen(
                        name: searchKey.text,
                      );
                    }));
                  },
                  cursorColor: Colors.black12,
                  cursorWidth: 1,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: TextStyle(fontSize: 12),
                  maxLength: 20,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.black12,
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(40),
                              right: Radius.circular(40)),
                          borderSide: BorderSide.none)),
                ),
              ),
              Container(
                width: double.infinity,
                height: 90,
                margin: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                child: FutureBuilder(
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If we got an error
                      if (snapshot.hasError) {
                        return Center();

                        // if we got our data
                      } else if (snapshot.hasData) {
                        return snapshot.data as Widget;
                      }
                    }
                    // Displaying LoadingSpinner to indicate waiting state
                    return Center(
                      child: CircularProgressIndicator(
                        color: orange,
                      ),
                    );
                  },

                  // Future that needs to be resolved
                  // inorder to display something on the Canvas
                  future: cl,
                ),
              ),
              Container(
                child: Expanded(
                  child: FutureBuilder(
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If we got an error
                        if (snapshot.hasError) {
                          return Center(
                              child: Column(
                            children: [
                              Text(
                                snapshot.error.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black12,
                                    fontFamily: 'Nexa',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                super.widget));
                                  },
                                  child: Text(
                                    'Retry',
                                    style: TextStyle(
                                        color: orange,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline),
                                  )),
                            ],
                          ));

                          // if we got our data
                        } else if (snapshot.hasData) {
                          return snapshot.data as Widget;
                        }
                      }
                      // Displaying LoadingSpinner to indicate waiting state
                      return Center(
                        child: CircularProgressIndicator(
                          color: orange,
                        ),
                      );
                    },

                    // Future that needs to be resolved
                    // inorder to display something on the Canvas
                    future: gen,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
