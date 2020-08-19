import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/model/ingredient/ingredient.dart';
import 'package:get_that_bread/model/menu/menu.dart';
import 'package:path_provider/path_provider.dart';

class PersistenceService {
  Future<void> encodeMenus(List<Menu> menus) async {
    _writeJson(await _menusFile, json.encode(menus));
  }

  Future<void> encodeDishes(List<Dish> dishes) async {
    _writeJson(await _dishesFile, json.encode(dishes));
  }

  Future<void> encodeIngredients(List<Ingredient> ingredients) async {
    _writeJson(await _ingredientsFile, json.encode(ingredients));
  }

  Future<List<dynamic>> decodeMenus() async {
    return _readJson(await _menusFile);
  }

  Future<List<dynamic>> decodeDishes() async {
    return _readJson(await _dishesFile);
  }

  Future<List<dynamic>> decodeIngredients() async {
    return _readJson(await _ingredientsFile);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _menusFile async {
    final path = await _localPath;
    return createFileIfNonexistant(File('$path/menus.json'));
  }

  Future<File> get _dishesFile async {
    final path = await _localPath;
    return createFileIfNonexistant(File('$path/dishes.json'));
  }

  Future<File> get _ingredientsFile async {
    final path = await _localPath;
    return createFileIfNonexistant(File('$path/ingredients.json'));
  }

  Future<File> createFileIfNonexistant(File file) async {
    if (await file.exists()) {
      return file;
    } else {
      print("JSON File Doesn't Exist, creating it");
      file.writeAsStringSync("{}");
      return file;
    }
  }

  File _writeJson(File file, String data) {
    // Write the file.
    return file..writeAsStringSync(data);
  }

  List<dynamic> _readJson(File file) {
    try {
      // Read the file.
      String contents = file.readAsStringSync();

      return contents == "{}" ? [] : json.decode(contents);
    } catch (e) {
      debugPrint("Failed to read JSON");
      throw (e);
    }
  }
}
