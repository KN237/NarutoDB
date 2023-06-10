import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xffff9346);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(50.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffffc107), Color(0xffffa462)],
            stops: [0, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  const Text(
                    'Find out everything you ever wanted to know about your favorite ninja',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Nexa',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/naruto.png',
              ),
             
              Container(
                width: 160,
                height: 60,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'second');
                  },
                  style: ButtonStyle(),
                  child: Center(
                      child: const Text(
                    'Let\'s Go',
                    style: TextStyle(
                        fontFamily: 'naruto',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: orange),
                  )),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30.0),
                      right: Radius.circular(30.0)),
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
