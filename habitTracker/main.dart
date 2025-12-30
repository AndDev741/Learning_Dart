import 'dart:io';

import 'services/HabitService.dart';

void main() {
  bool stop = false;
  Habitservice service = new Habitservice();
  do {
    stdout.write(
    "Which method you want to use? \n 1: Create Habit \n 2: List Habits \n 3: Activate or Deactivate habit \n 4: Check or uncheck habit \n 5: List Habit logs \n 6: Weekly Report \n 0: Stop application \n",
    );

    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      throw Exception("No input detected");
    }

    switch (input) {
      case "0":
        stop = true;
        break;
      case "1":
        habitCase(service);
        break;
      case "2":
        service.listHabits();
        break;
      case "3":
        activateDeactivateCase(service);
        break;
      case "4":
        checkOrUncheckHabit(service);
        break;
      case "5":
        service.listHabitLogs();
        break;
      case "6":
        service.listAllHabitCompletedInTheWeek();
        break;
      default:
        print("No method found, try again");
    }
  }
  while(stop != true);
}

void habitCase(Habitservice service) {
  stdout.write("What's the name of the habit?\n");
  String? name = stdin.readLineSync();
  stdout.write("What's the categories of the habit? Ex: life, work\n");
  String? categoriesString = stdin.readLineSync();
  List<String>? categories = categoriesString == null
      ? null
      : categoriesString.split(',');
  stdout.write("Already active? YES or NO\n");
  String? isActiveString = stdin.readLineSync();
  bool isActive = isActiveString == null
      ? false
      : isActiveString == "YES"
      ? true
      : false;

  service.createHabit(name != null ? name : "", categories, isActive);
}

void activateDeactivateCase(Habitservice service) {
  service.listHabits();
  stdout.write("Choose an habit ID to activate or deactivate (Will inverse the value)\n");
  String? id = stdin.readLineSync();
  if(id != null){
    service.activateOrDeactivateHabit(int.parse(id));
  }
}

void checkOrUncheckHabit(Habitservice service){
  service.listHabitLogs();
  service.listHabits();
  stdout.write("Choose an habit ID to mark or remove check for today\n");
  String? id = stdin.readLineSync();
  if(id != null){
    service.checkUncheckHabit(int.parse(id));
  }
}
