import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  int? id;
  int? userId;
  DateTime? date;
  List<dynamic>? products;

  Cart({this.id, this.userId, this.date, this.products});

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
