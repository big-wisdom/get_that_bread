import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'backend.g.dart';

main() {
  Future.delayed(Duration(seconds: 1)).then((value) => print("Eli"));
  print("Hermann");
}

abstract class FoodTest {
  String name;
  String id;
  FoodTest(this.name) : id = Uuid().v1();
}

@JsonSerializable()
class Eli extends FoodTest {
  Eli(String name) : super(name);

  factory Eli.fromJson(Map<String, dynamic> json) => _$EliFromJson(json);

  Map<String, dynamic> toJson() => _$EliToJson(this);
}
