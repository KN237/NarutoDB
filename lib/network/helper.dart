import 'package:http/http.dart';
import 'dart:convert';
import 'dart:math';
import 'clan.dart';
import 'personnage.dart';
import 'package:flutter/material.dart';

class Helper {

  Future<dynamic> getClans() async {
      final url = Uri.parse('https://narutodb.xyz/api/clan?limit=58');
      dynamic response = await get(url);
      dynamic clan = jsonDecode(response.body)['clans'];
      List clans = [];

      for (var element in clan) {
        var tst = Clan.fromJson(element);
        clans.add(tst);
      }

      return clans;
  }

  Future<List> getCharacters() async {
    int num = Random().nextInt(48);
    final url =
        Uri.parse('https://narutodb.xyz/api/character?page=$num&limit=30');
    dynamic response = await get(url);
    dynamic character = jsonDecode(response.body)['characters'];
    List characters = [];

    for (var element in character) {
      var tst = Personnage.fromJson(element);
      characters.add(tst);
    }

    return characters;
  }

  Future<List> getCharactersByName(dynamic name) async {
    int num = Random().nextInt(48);
    final url = Uri.parse('https://narutodb.xyz/api/character?limit=1431');
    dynamic response = await get(url);
    dynamic character = jsonDecode(response.body)['characters'];
    List characters = [];

    for (var element in character) {
      if ((element['name'].toLowerCase()).contains(name.toLowerCase())) {
        var tst = Personnage.fromJson(element);
        characters.add(tst);
      }
    }

    return characters;
  }

  Future<List> getCharactersByClan(dynamic clan) async {
    int num = Random().nextInt(48);
    final url = Uri.parse('https://narutodb.xyz/api/clan/$clan');
    dynamic response = await get(url);
    dynamic character = jsonDecode(response.body)['characters'];
    List characters = [];

    for (var element in character) {
      var tst = Personnage.fromJson(element);
      characters.add(tst);
    }

    return characters;
  }

  Future<Personnage> getCharacterById(dynamic num) async {
    final url = Uri.parse('https://narutodb.xyz/api/character/$num');
    dynamic response = await get(url);
    dynamic character = jsonDecode(response.body);
    var tst = Personnage.fromJson(character);
    return tst;
  }

 Future<List> getCharactersListByName(List<String> names) async {
    int num = Random().nextInt(48);
    final url = Uri.parse('https://narutodb.xyz/api/character?limit=1431');
    dynamic response = await get(url);
    dynamic character = jsonDecode(response.body)['characters'];
    List characters = [];

    for (var element in character) {
      if (names.contains(element['name'])) {
        var tst = Personnage.fromJson(element);
        characters.add(tst);
      }
    }

    return characters;
  }
}
