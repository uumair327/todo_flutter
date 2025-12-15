class TodoEntity {
  final String id;
  final String title;
  final bool isCompleted;
  final String category;

  TodoEntity({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.category,
  });
  
    TodoEntity copyWith({bool? isCompleted}) {
    return TodoEntity(
      id: id,
      title: title,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category,
    );
  }
}
