import '../../domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required super.id,
    required super.title,
    required super.isCompleted,
    required super.category,
  });

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      title: entity.title,
      isCompleted: entity.isCompleted,
      category: entity.category,
    );
  }
}
