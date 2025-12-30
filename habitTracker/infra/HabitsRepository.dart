import '../domain/Habit.dart';

class Habitsrepository {
  int incrementalId = 0;
  var inMemoryHabits = <int, Habit>{};

  Habit saveHabit(String name, List<String>? categories, bool? isActive) {
    incrementalId++;

    Habit habit = new Habit(
      incrementalId,
      name,
      categories,
      isActive != null ? isActive : false,
      DateTime.now(),
    );

    inMemoryHabits.addAll({incrementalId: habit});

    return habit;
  }

  Habit editHabit(Habit habit){
    inMemoryHabits.addAll({
      habit.id: habit
    });

    return habit;
  }

  Habit? getHabitById(int id) {
    Habit? habit = inMemoryHabits[id];

    if (habit == null) {
      print("Habit not found by ID. Try another one");
      return null;
    }

    return habit;
  }

  List<Habit> getAllHabits() {
    return inMemoryHabits.values.toList();
  }
}
