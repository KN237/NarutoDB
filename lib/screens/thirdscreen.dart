import 'package:flutter/material.dart';
import 'package:naruto/network/helper.dart';
import '/utilities/widget.dart';

class ThirdScreen extends StatefulWidget {
  ThirdScreen({this.id});
  dynamic id;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final orange = Color(0xffff9346);
  final networkHelper = Helper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
                return CharacterInfos(p: snapshot.data, orange: orange);
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
          future: networkHelper.getCharacterById(widget.id),
        ),
      ),
    );
  }
}
