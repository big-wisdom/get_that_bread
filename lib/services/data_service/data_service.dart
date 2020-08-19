import 'dart:io';

import 'package:get_that_bread/model/menu/menu.dart';
import 'package:get_that_bread/services/persistence_service/persistence_service.dart';

// this will control a list of Menus, list of Dishes, and list of Ingredients
class DataService {
  final PersistenceService persistenceService = PersistenceService();
  List<Menu> menus = [];

  DataService() {
    _loadMenus();
  }

  void _loadMenus() {
    persistenceService.decodeMenus().then((value) {
      menus = value.map((e) => Menu.fromJson(e));
    });
  }

  void printMenus() {
    _loadMenus();
    print("Menus");
    for (int x = 0; x < menus.length; x++) {
      print(menus[x].name);
    }
  }

  void addMenu(Menu menu) {
    print("Adding Menu");
    menus.add(menu);
    persistenceService.encodeMenus(menus);
  }
}
