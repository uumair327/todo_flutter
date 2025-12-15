import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class GetAllTodos implements UseCaseNoParams<List<TodoEntity>> {
  final TodoRepository repository;

  GetAllTodos(this.repository);

  @override
  Future<List<TodoEntity>> call() async {
    return await repository.getAllTodos();
  }
}