import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodo implements UseCase<void, TodoEntity> {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  @override
  Future<void> call(TodoEntity params) async {
    return await repository.updateTodo(params);
  }
}