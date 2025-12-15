import 'package:todo/core/usecases/usecases.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class DeleteTodo implements UseCase<void, String> {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  @override
  Future<void> call(String params) async {
    return await repository.deleteTodo(params);
  }
}