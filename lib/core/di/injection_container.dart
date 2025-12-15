import 'package:get_it/get_it.dart';
import 'package:todo/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:todo/features/todo/data/repositories/todo_repository_imp.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo/features/todo/domain/usecases/add_todo.dart';
import 'package:todo/features/todo/domain/usecases/delete_todo.dart';
import 'package:todo/features/todo/domain/usecases/get_all_todos.dart';
import 'package:todo/features/todo/domain/usecases/search_todos.dart';
import 'package:todo/features/todo/domain/usecases/update_todo.dart';
import 'package:todo/features/todo/presentation/cubit/todo_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Todo
  // Cubit
  sl.registerFactory(
    () => TodoCubit(
      getAllTodos: sl(),
      addTodo: sl(),
      deleteTodo: sl(),
      updateTodo: sl(),
      searchTodos: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllTodos(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  sl.registerLazySingleton(() => SearchTodos(sl()));

  // Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<TodoLocalDatasource>(
    () => TodoLocalDatasource(),
  );
}