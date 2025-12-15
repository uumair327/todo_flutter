import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';
import '../cubit/todo_state.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (context, index) {
            final todo = state.todos[index];

            return ListTile(
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (_) {
                  context.read<TodoCubit>().toggleTodo(todo);
                },
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<TodoCubit>().deleteTodo(todo.id);
                },
              ),
            );
          },
        );
      },
    );
  }
}
