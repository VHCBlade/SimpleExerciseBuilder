enum MuscleGroup {
  chest,
  back,
  arms,
  legs,
  abdominals,
  shoulders,
}

enum ExerciseEquipment {
  pullup,
  balance,
  band,
  dumbbell,
  barbell,
  kettlebell,
  none,
}

/// Converts the given int, which is a [bitwise] value representing a set of bools, into a collection taken from [values]
///
/// The [bitwise] is reversed and for each bit that is a 1, the [values] will be added to the return value.
Set<T> convertIntToSet<T>(int bitwise, List<T> values) {
  final bitwiseString = bitwise.toRadixString(2).split('').reversed.toList();
  final retVal = <T>{};

  for (var i = 0; i < bitwiseString.length; i++) {
    if (values.length <= i) {
      return retVal;
    }
    if (bitwiseString[i] == '1') {
      retVal.add(values[i]);
    }
  }
  return retVal;
}

int convertIterableToInt<T>(List<T> values, Iterable<T> iterable) {
  final retValList = values.map((val) => '0').toList();
  iterable
      .map((val) => values.indexOf(val))
      .forEach((element) => retValList[element] = '1');

  final retVal =
      retValList.reversed.reduce((value, element) => '$value$element');

  return int.parse(retVal, radix: 2);
}

/// Converts the [bitwise] int representing booleans into the corresponding Set of [MuscleGroup]s
Set<MuscleGroup> convertIntToMuscleGroups(int bitwise) =>
    convertIntToSet(bitwise, MuscleGroup.values);

int convertMuscleGroupsToInt(Iterable<MuscleGroup> iterable) =>
    convertIterableToInt(MuscleGroup.values, iterable);

/// Converts the [bitwise] int representing booleans into the corresponding Set of [ExerciseEquipment]s
Set<ExerciseEquipment> convertIntToExerciseEquipment(int bitwise) =>
    convertIntToSet(bitwise, ExerciseEquipment.values);

int convertExerciseEquipmentToInt(Iterable<ExerciseEquipment> iterable) =>
    convertIterableToInt(ExerciseEquipment.values, iterable);
