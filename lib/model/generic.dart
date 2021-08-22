import 'package:hive/hive.dart';

class GenericTypeAdapter<T extends GenericModel> extends TypeAdapter<T> {
  final T Function() generator;
  late final T instance = generator();

  GenericTypeAdapter(this.generator);

  @override
  T read(BinaryReader reader) => generator()..loadFromMap(reader.read());

  @override
  int get typeId => instance.typeId;

  @override
  void write(BinaryWriter writer, obj) {
    if (obj is! T) {
      throw ArgumentError('Attempting to write the incorrect type.');
    }
    writer.write(obj.toMap());
  }
}

/// This is the interface of all models that are saved.
abstract class GenericModel {
  GenericModel.fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap();
  void loadFromMap(Map<String, dynamic> map);

  /// Should be unique for each implementation of [GenericModel]
  int get typeId;
}
