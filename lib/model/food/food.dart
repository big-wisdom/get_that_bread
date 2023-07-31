import 'package:uuid/uuid.dart';

abstract class Food {
  String name;
  String id;
  Food(this.name) : id = Uuid().v1();
}
