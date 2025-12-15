import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class SearchTodos implements UseCase<List<TodoEntity>, String> {
  final TodoRepository repository;

  SearchTodos(this.repository);

  @override
  Future<List<TodoEntity>> call(String params) async {
    return await repository.searchTodos(params);
  }
}