import 'dart:math';

import '../domain/Habit.dart';
import '../domain/HabitLog.dart';
import '../infra/HabitLogsRepository.dart';
import '../infra/HabitsRepository.dart';

class Habitservice {
  Habitsrepository habitsrepository = new Habitsrepository();
  Habitlogsrepository logRepository = new Habitlogsrepository();

  void listHabits() {
    if(habitsrepository.inMemoryHabits.isEmpty) {
      print("No habits created yet, create some...");
    }
    habitsrepository.inMemoryHabits.forEach((key, value) {
      print("ID: ${key} \n Name: ${value.name}\n Categories: ${value.categories} \n isActive: ${value.isActive} \n createdAt ${value.createdAt}");
    });
  }

  void listHabitLogs() {
    if(logRepository.inMemoryHabitLog.isEmpty) {
      print("No habits logs created yet, create some...");
    }
    logRepository.inMemoryHabitLog.forEach((key, value) {
      print("ID: ${key} \n HabitId: ${value.habitId} \n Completed?: ${value.completed}\n completedAt: ${value.date}");
    });
  }
  
  Habit createHabit(String name, List<String>? categories, bool? isActive) {
    Habit habit = habitsrepository.saveHabit(name, categories, isActive);
    return habit;
  }

  void activateOrDeactivateHabit(int id) {
    Habit? habit = habitsrepository.getHabitById(id);
    if(habit == null) return;

    habit.isActive = !habit.isActive;
    
    habitsrepository.editHabit(habit);
    print("Now the habit field isActive is => ${habit.isActive}");
  }

  void checkUncheckHabit(int id) {
    Habit? habit = habitsrepository.getHabitById(id);
    if(habit == null) return;

    if(!habit.isActive){
      print("Habit selected to check/uncheck is not active");
      return;
    }

    HabitLog habitLog = logRepository.getHabitLogById(habit.id);

    logRepository.saveHabitLog(habitLog);

    print("Habit check/uncheck for today => ${habit.name} is completed? ${habitLog.completed}");
  }

  //WEEKLY PROGRESS
  void listAllHabitCompletedInTheWeek(){
    List<HabitLog> habitLogs = logRepository.getAllHabitLogs();

    for(HabitLog log in habitLogs){
      if(log.completed && isThisWeek(log.date)){
        print("You weekly completed habits: ");
        print("Name: ${habitsrepository.inMemoryHabits[log.habitId]!.name} \n Completed at: ${log.date}");
      }
    }
  }

  bool isThisWeek(DateTime date){
    DateTime now = DateTime.now();

    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    startOfWeek = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);

    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6, hours: 23, minutes: 59));

    return date.isAfter(startOfWeek) && date.isBefore(endOfWeek);
  }
}