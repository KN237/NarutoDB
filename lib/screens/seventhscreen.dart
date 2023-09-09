import 'dart:math';
import 'package:flutter/material.dart';
import 'package:naruto/network/helper.dart';
import 'package:naruto/screens/fifthscreen.dart';
import 'package:naruto/screens/fourthscree.dart';
import 'package:naruto/screens/thirdscreen.dart';
import 'package:naruto/utilities/widget.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeventhScreen extends StatefulWidget {
  @override
  State<SeventhScreen> createState() => _SeventhScreenState();
}

class _SeventhScreenState extends State<SeventhScreen> {
  bool isKeyboardEnabled = true;
  TextEditingController searchKey = TextEditingController();
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final orange = Color(0xffff9346);
  final networkHelper = Helper();
  late Future<Widget> gen;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late Future<List<String>> favorites;

  Future<Widget> generateCharacters() async {
    final SharedPreferences prefs = await _prefs;
    final List<String> fav = prefs.getStringList('favorites') ?? ['Akemaru'];
    print(prefs.getStringList('favorites'));
    IconData hearth=Icons.favorite_border;

    dynamic characters = await networkHelper.getCharactersListByName(fav);
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
                          image: NetworkImage(element.images.length > 0
                              ? element.images[0]
                              : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      try {
                        addFavorite(element.name);
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title: 'Success',
                            text:
                                '${element.name} was added to your favorites',
                            confirmBtnText: 'Okay',
                            confirmBtnTextStyle: TextStyle(
                                fontFamily: 'Nexa',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            confirmBtnColor: orange);
                            setState(() {
                              hearth=Icons.favorite;
                            });
                            
                      } catch (e) {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: 'Error',
                            text: 'Something went wrong, please try again !',
                            confirmBtnText: 'Okay',
                            confirmBtnTextStyle: TextStyle(
                                fontFamily: 'Nexa',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            confirmBtnColor: orange);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 10.0),
                      child: heart(hearth: hearth, orange: orange),
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
    gen = generateCharacters();
  }

  Future<void> addFavorite(newCharacter) async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.getStringList('favorites') == null) {
      final List<String> fav = [];
      setState(() {
        favorites = prefs.setStringList('favorites', fav).then((bool success) {
          return favorites;
        });
      });
    } else {
      final List<String>? fav = prefs.getStringList('favorites');
      fav!.contains(newCharacter) ? fav.add(newCharacter) : 0;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Favorites', style: TextStyle(fontFamily: 'Nexa', color: Colors.black),),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Column(
          children: [
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
    );
  }
}

class heart extends StatelessWidget {
  const heart({
    super.key,
    required this.hearth,
    required this.orange,
  });

  final IconData hearth;
  final Color orange;

  @override
  Widget build(BuildContext context) {
    return Icon(
      hearth,
      color: orange,
      size: 20,
    );
  }
}
