import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/usecases/filter_todos.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getAllTodos();
  Future<void> addTodo(TodoEntity todo);
  Future<void> deleteTodo(String id);
   Future<void> updateTodo(TodoEntity todo);
  Future<List<TodoEntity>> searchTodos(String query);
  Future<List<TodoEntity>> filterTodos(FilterType filter);
}
