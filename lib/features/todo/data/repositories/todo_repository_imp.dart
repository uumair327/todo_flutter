import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo/features/todo/domain/usecases/filter_todos.dart';
import '../datasources/todo_local_datasource.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDatasource dataSource;

  TodoRepositoryImpl(this.dataSource);

  @override
  Future<void> addTodo(TodoEntity todo) async {
    dataSource.add(TodoModel.fromEntity(todo));
  }

  @override
  Future<void> deleteTodo(String id) async {
    dataSource.delete(id);
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    dataSource.update(TodoModel.fromEntity(todo));
  }

  @override
  Future<List<TodoEntity>> getAllTodos() async {
    return dataSource.getAll();
  }

  @override
  Future<List<TodoEntity>> searchTodos(String query) async {
    return dataSource.search(query);
  }

  @override
  Future<List<TodoEntity>> filterTodos(FilterType filter) async {
    return dataSource.filter(filter);
  }
}
