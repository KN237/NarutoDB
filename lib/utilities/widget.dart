import 'package:flutter/material.dart';
import 'package:naruto/screens/sixthscreen.dart';
import '/network/personnage.dart';

class CharacterInfos extends StatelessWidget {
  const CharacterInfos({
    super.key,
    required this.p,
    required this.orange,
  });

  final Personnage? p;
  final Color orange;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffffc107), Color(0xffffa462)],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: NetworkImage(p!.images.length > 0
                      ? p!.images[0]
                      : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930'),
                  fit: BoxFit.fill)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              // Container(
              //   width: 30,
              //   height: 30,
              //   margin: EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(05),
              //       color: Colors.white),
              //   child: Icon(
              //     Icons.favorite,
              //     color: Colors.transparent,
              //     size: 14,
              //   ),
              // ),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: Text(
                  p!.name,
                  style: TextStyle(
                      fontFamily: "Naruto",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: orange),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Birthday',
                        style: TextStyle(
                            fontFamily: "Naruto",
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start,
                      ),
                      Text(p!.personal['birthdate'] ?? '/',
                          style: TextStyle(
                              fontFamily: "Nexa",
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(
                            fontFamily: "Naruto",
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start,
                      ),
                      Text( p!.personal['status'] ?? "/",
                          style: TextStyle(
                              fontFamily: "Nexa",
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Clan',
                        style: TextStyle(
                            fontFamily: "Naruto",
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start,
                      ),
                      Text(p!.personal['clan'] ?? "/",
                          style: TextStyle(
                              fontFamily: "Nexa",
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sex',
                        style: TextStyle(
                            fontFamily: "Naruto",
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start,
                      ),
                      Text(p!.personal['sex'] ?? "/",
                          style: TextStyle(
                              fontFamily: "Nexa",
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Debut',
                    style: TextStyle(
                        fontFamily: "Naruto",
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      p!.debut != null
                          ? p!.debut.toString()
                          : 'Nothing to display here',
                      style: TextStyle(
                          fontFamily: "Nexa",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Family',
                    style: TextStyle(
                        fontFamily: "Naruto",
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      p!.family != null
                          ? p!.family.toString()
                          : 'Nothing to display here',
                      style: TextStyle(
                          fontFamily: "Nexa",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Personal',
                    style: TextStyle(
                        fontFamily: "Naruto",
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      p!.personal != null
                          ? p!.personal.toString()
                          : 'Nothing to display here',
                      style: TextStyle(
                          fontFamily: "Nexa",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Jutsu',
                    style: TextStyle(
                        fontFamily: "Naruto",
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      p!.jutsu != null
                          ? p!.jutsu.toString()
                          : 'Nothing to display here',
                      style: TextStyle(
                          fontFamily: "Nexa",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Rank',
                    style: TextStyle(
                        fontFamily: "Naruto",
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      p!.rank != null
                          ? p!.rank.toString()
                          : 'Nothing to display here',
                      style: TextStyle(
                          fontFamily: "Nexa",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Voice Actors',
                    style: TextStyle(
                        fontFamily: "Naruto",
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      p!.voiceActor != null
                          ? p!.voiceActor.toString()
                          : 'Nothing to display here',
                      style: TextStyle(
                          fontFamily: "Nexa",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.justify),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/sign.png'),
                ),
                gradient: LinearGradient(
                  colors: [Color(0xffffc107), Color(0xffffa462)],
                  stops: [0, 1],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(),
            ),
            ListTile(
              title: const Text(
                'More Features Soon',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black12,
                    fontFamily: 'Nexa',
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
