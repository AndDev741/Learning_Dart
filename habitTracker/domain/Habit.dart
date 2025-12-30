class Habit {
  int id;
  String name;
  List<String>? categories;
  bool isActive;
  DateTime createdAt;

  Habit(this.id, this.name, this.categories, this.isActive, this.createdAt);
  
}