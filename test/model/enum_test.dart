import 'package:flutter_test/flutter_test.dart';
import 'package:simple_exercise_builder/model/enum.dart';

void main() {
  group('Enum', () {
    test('Muscle Group', muscleGroupTest);
    test('Exercise Equipment', equipmentTest);
  });
}

void muscleGroupTest() {
  expect(convertIntToMuscleGroups(0xFFFFF), MuscleGroup.values);
  expect(convertIntToMuscleGroups(0x3), [MuscleGroup.chest, MuscleGroup.back]);
  expect(convertIntToMuscleGroups(0xD),
      [MuscleGroup.chest, MuscleGroup.arms, MuscleGroup.legs]);
  expect(convertIntToMuscleGroups(0x32),
      [MuscleGroup.back, MuscleGroup.abdominals, MuscleGroup.shoulders]);

  expect(convertMuscleGroupsToInt(MuscleGroup.values), 0x3F);
  expect(convertMuscleGroupsToInt([MuscleGroup.chest, MuscleGroup.back]), 0x3);
  expect(
      convertMuscleGroupsToInt(
          [MuscleGroup.chest, MuscleGroup.arms, MuscleGroup.legs]),
      0xD);
  expect(
      convertMuscleGroupsToInt(
          [MuscleGroup.back, MuscleGroup.abdominals, MuscleGroup.shoulders]),
      0x32);
}

void equipmentTest() {
  expect(convertIntToExerciseEquipment(0xFFFFFF), ExerciseEquipment.values);
  expect(convertIntToExerciseEquipment(0x3),
      [ExerciseEquipment.pullup, ExerciseEquipment.balance]);
  expect(convertIntToExerciseEquipment(0xD), [
    ExerciseEquipment.pullup,
    ExerciseEquipment.band,
    ExerciseEquipment.dumbbell
  ]);
  expect(convertIntToExerciseEquipment(0x72), [
    ExerciseEquipment.balance,
    ExerciseEquipment.barbell,
    ExerciseEquipment.kettlebell,
    ExerciseEquipment.none
  ]);

  expect(convertExerciseEquipmentToInt(ExerciseEquipment.values), 0x7F);
  expect(
      convertExerciseEquipmentToInt(
          [ExerciseEquipment.pullup, ExerciseEquipment.balance]),
      0x3);
  expect(
      convertExerciseEquipmentToInt([
        ExerciseEquipment.pullup,
        ExerciseEquipment.band,
        ExerciseEquipment.dumbbell
      ]),
      0xD);
  expect(
      convertExerciseEquipmentToInt([
        ExerciseEquipment.balance,
        ExerciseEquipment.barbell,
        ExerciseEquipment.kettlebell,
        ExerciseEquipment.none
      ]),
      0x72);
}
