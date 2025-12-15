import 'package:equatable/equatable.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';

class TodoState extends Equatable {
  final List<TodoEntity> todos;
  const TodoState(this.todos);

  @override
  List<Object?> get props => [todos];
}
