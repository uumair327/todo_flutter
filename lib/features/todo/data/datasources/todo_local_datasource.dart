import 'package:todo/core/constants/constants.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:todo/features/todo/domain/usecases/filter_todos.dart';

class TodoLocalDatasource {
  final List<TodoModel> _todos = [];

  List<TodoModel> getAll() => _todos;

  void add(TodoModel todo) => _todos.add(todo);

  void delete(String id) => _todos.removeWhere((t) => t.id == id);

  void update(TodoModel todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  List<TodoModel> search(String query) => _todos
      .where((t) => t.title.toLowerCase().contains(query.toLowerCase()))
      .toList();

  List<TodoModel> filter(FilterType type) {
    switch (type) {
      case FilterType.completed:
        return _todos.where((t) => t.isCompleted).toList();
      case FilterType.pending:
        return _todos.where((t) => !t.isCompleted).toList();
      case FilterType.work:
        return _todos.where((t) => t.category == AppCategories.work).toList();
      case FilterType.personal:
        return _todos.where((t) => t.category == AppCategories.personal).toList();
      default:
        return _todos;
    }
  }
}
