import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/constants/constants.dart';
import 'package:todo/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:todo/features/todo/presentation/cubit/todo_state.dart';
import 'package:todo/features/todo/presentation/widgets/todo_item_widget.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        if (state.todos.isEmpty) {
          return const Center(
            child: Text(
              AppStrings.noTodosYet,
              style: TextStyle(fontSize: fontSizeLarge, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (context, index) {
            final todo = state.todos[index];
            return TodoItemWidget(todo: todo);
          },
        );
      },
    );
  }
}