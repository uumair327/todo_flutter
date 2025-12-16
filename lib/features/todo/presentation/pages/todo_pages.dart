import 'package:flutter/material.dart';
import 'package:todo/core/constants/constants.dart';
import 'package:todo/features/todo/presentation/widgets/add_todo_dialog.dart';
import 'package:todo/features/todo/presentation/widgets/todo_filter_chips.dart';
import 'package:todo/features/todo/presentation/widgets/todo_list_widget.dart';
import 'package:todo/features/todo/presentation/widgets/todo_search_bar.dart';

class TodoPages extends StatefulWidget {
  const TodoPages({super.key});

  @override
  State<TodoPages> createState() => _TodoPagesState();
}

class _TodoPagesState extends State<TodoPages> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          TodoSearchBar(controller: _searchController),
          const TodoFilterChips(),
          const Expanded(child: TodoListWidget()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTodoDialog(context),
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.addTodo),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: smallElevation,
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: barrierColor,
      builder: (context) => const AddTodoDialog(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
