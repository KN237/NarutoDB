import 'package:flutter/material.dart';
import 'package:naruto/network/helper.dart';
import '/utilities/widget.dart';
import 'thirdscreen.dart';

class SixthScreen extends StatefulWidget {
  SixthScreen({this.name});
  dynamic name;

  @override
  State<SixthScreen> createState() => _SixthScreenState();
}

class _SixthScreenState extends State<SixthScreen> {
  final orange = Color(0xffff9346);
  final networkHelper = Helper();

  Future<Widget> generateCharacters() async {
    List characters = await networkHelper.getCharactersByName(widget.name);
    if (characters.isEmpty) {
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'There is no character with that name in our database now',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black12,
                fontFamily: 'Nexa',
                fontSize: 25,
                fontWeight: FontWeight.w900),
          ),
        ],
      ));
    }
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
      children: tmp,
    );

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffffc107), Color(0xffffa462)],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textBaseline: TextBaseline.alphabetic,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(05),
                        color: Colors.white),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    'Results for ${widget.name}',
                    style: TextStyle(
                        fontFamily: "Nexa",
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.12,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: FutureBuilder(
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If we got an error
                      if (snapshot.hasError) {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  setState(() {});
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
                  future: generateCharacters(),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
