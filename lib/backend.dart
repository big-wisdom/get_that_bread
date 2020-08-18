// import 'dart:convert';
// import 'dart:io';

import 'package:get_that_bread/model/menu/menu.dart';
// import 'package:path_provider/path_provider.dart';

main() {
  Menu menu = Menu("Budget");
  print(menu.toJson());
}

// Future<String> get _localPath async {
//   final directory = await getApplicationDocumentsDirectory();
//   return directory.path;
// }

// Future<File> get _menusFile async {
//   final path = await _localPath;
//   return File('$path/menus.json');
// }

// Future<File> get _dishesFile async {
//   final path = await _localPath;
//   return File('$path/dishes.json');
// }

// Future<File> get _ingredientsFile async {
//   final path = await _localPath;
//   return File('$path/dishes.json');
// }

// Future<File> writeJson(File file, String data) async {
//   // Write the file.
//   return file.writeAsString(data);
// }

// Future<Map<String, dynamic>> readJson(File file) async {
//   try {
//     // Read the file.
//     String contents = await file.readAsString();

//     return json.decode(contents);
//   } catch (e) {
//     print("Failed to read JSON");
//   }
// }
