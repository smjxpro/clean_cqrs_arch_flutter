class Todo {
  Todo({
    required this.name,
    this.isComplete = false,
    this.id,
  });

  String name;
  bool isComplete;
  String? id;

  void markComplete() {
    isComplete = true;
  }

  void markIncomplete() {
    isComplete = false;
  }
}
