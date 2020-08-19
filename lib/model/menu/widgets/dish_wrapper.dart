import 'package:get_that_bread/model/dish/dish.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dish_wrapper.g.dart';

@JsonSerializable(explicitToJson: true)
class DishWrapper {
  factory DishWrapper.fromJson(Map<String, dynamic> json) =>
      _$DishWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$DishWrapperToJson(this);

  Dish dish;
  int count;
  DishWrapper({this.dish, this.count});
}
