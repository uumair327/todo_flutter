import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/constants/constants.dart';
import 'package:todo/features/todo/presentation/cubit/todo_cubit.dart';

class TodoSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const TodoSearchBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(paddingAll),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: AppStrings.searchTodosHint,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
        onChanged: (query) {
          context.read<TodoCubit>().search(query);
        },
      ),
    );
  }
}