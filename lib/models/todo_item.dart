class TodoItem {
  final int id;
  final String description;
  final bool isDone;

  TodoItem(
    this.id,
    this.description,
    this.isDone,
  );

  @override
  String toString() {
    return 'TodoItem{id: $id, name: $description, isDone: $isDone}';
  }
}
