import '../domain/HabitLog.dart';

class Habitlogsrepository {
  int incrementalId = 0;
  var inMemoryHabitLog = <int, HabitLog>{};

  HabitLog saveHabitLog(HabitLog habitLog){
    incrementalId++;
    inMemoryHabitLog.addAll({
      incrementalId: habitLog
    });
    return habitLog;
  }

  HabitLog getHabitLogById(int habitId) {
    HabitLog habitLog = inMemoryHabitLog.values.singleWhere((log) => log.habitId == habitId, orElse: () => new HabitLog(habitId, DateTime.now(), true));
    return habitLog;
  }

  List<HabitLog> getAllHabitLogs() {
    return inMemoryHabitLog.values.toList();
  }
}