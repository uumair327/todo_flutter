import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoStatus {
  final TodoRepository repository;
  UpdateTodoStatus(this.repository);

  Future<void> call(TodoEntity todo) {
    return repository.updateTodo(todo);
  }
}
