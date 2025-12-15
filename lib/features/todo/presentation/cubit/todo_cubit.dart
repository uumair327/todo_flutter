import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/usecases/add_todo.dart';
import 'package:todo/features/todo/domain/usecases/delete_todo.dart';
import 'package:todo/features/todo/domain/usecases/filter_todos.dart';
import 'package:todo/features/todo/domain/usecases/get_all_todos.dart';
import 'package:todo/features/todo/domain/usecases/search_todos.dart';
import 'package:todo/features/todo/domain/usecases/update_todo.dart';
import 'package:todo/features/todo/presentation/cubit/todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetAllTodos getAllTodos;
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final UpdateTodo updateTodo;
  final SearchTodos searchTodos;

  List<TodoEntity> _allTodos = []; // MASTER LIST
  FilterType _currentFilter = FilterType.all;
  String _currentSearch = '';

  TodoCubit({
    required this.getAllTodos,
    required this.addTodo,
    required this.deleteTodo,
    required this.updateTodo,
    required this.searchTodos,
  }) : super(const TodoState([]));

  Future<void> loadTodos() async {
    _allTodos = await getAllTodos();
    _applyCurrentView();
  }

  Future<void> addTodoItem(TodoEntity todo) async {
    await addTodo(todo);
    await loadTodos(); // ALWAYS reload master list
  }

  Future<void> deleteTodoItem(String id) async {
    await deleteTodo(id);
    await loadTodos();
  }

  Future<void> toggleTodo(TodoEntity todo) async {
    final updated = todo.copyWith(isCompleted: !todo.isCompleted);
    await updateTodo(updated);
    await loadTodos();
  }

  void applyFilter(FilterType filter) {
    _currentFilter = filter;
    _applyCurrentView();
  }

  void search(String query) {
    _currentSearch = query;
    _applyCurrentView();
  }

  // SINGLE PLACE WHERE FILTERING HAPPENS
  void _applyCurrentView() {
    List<TodoEntity> visible = List.from(_allTodos);

    // Apply filter
    switch (_currentFilter) {
      case FilterType.completed:
        visible = visible.where((t) => t.isCompleted).toList();
        break;
      case FilterType.pending:
        visible = visible.where((t) => !t.isCompleted).toList();
        break;
      case FilterType.work:
        visible = visible.where((t) => t.category == 'work').toList();
        break;
      case FilterType.personal:
        visible = visible.where((t) => t.category == 'personal').toList();
        break;
      case FilterType.all:
        // Show all todos - no filtering needed
        break;
    }

    // Apply search
    if (_currentSearch.isNotEmpty) {
      visible = visible
          .where(
            (t) => t.title.toLowerCase().contains(_currentSearch.toLowerCase()),
          )
          .toList();
    }

    emit(TodoState(visible));
  }
}
