import 'package:simple_exercise_builder/model/generic.dart';

class TestModel extends GenericModel {
  int? data;
  @override
  void loadFromMap(Map<String, dynamic> map) => data = map['data'];

  @override
  Map<String, dynamic> toMap() => {'data': data};

  @override
  int get typeId => 0;
}
