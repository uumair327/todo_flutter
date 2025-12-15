import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/presentation/cubit/todo_cubit.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoEntity todo;

  const TodoItemWidget({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (value) {
            context.read<TodoCubit>().toggleTodo(todo);
          },
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted 
                ? TextDecoration.lineThrough 
                : TextDecoration.none,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(
              todo.category == 'work' ? Icons.work : Icons.person,
              size: 16,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text('${todo.category[0].toUpperCase()}${todo.category.substring(1)}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            context.read<TodoCubit>().deleteTodoItem(todo.id);
          },
        ),
      ),
    );
  }
}