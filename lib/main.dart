import 'package:flutter/material.dart';
import 'screens/secondscreen.dart';
import 'screens/firstscreen.dart';
import 'package:flutter/services.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Naructionary',
      theme: Theme.of(context).copyWith(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        'second': (context) => SecondScreen(),
      },
    );
  }
}

//TODO : Ajouter un un splashScreen - Ajouter une icone - Ajouter un systeme de favoris
