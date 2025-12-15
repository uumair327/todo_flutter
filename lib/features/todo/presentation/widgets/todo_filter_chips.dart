import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/usecases/filter_todos.dart';
import 'package:todo/features/todo/presentation/cubit/todo_cubit.dart';

class TodoFilterChips extends StatefulWidget {
  const TodoFilterChips({super.key});

  @override
  State<TodoFilterChips> createState() => _TodoFilterChipsState();
}

class _TodoFilterChipsState extends State<TodoFilterChips> {
  FilterType _currentFilter = FilterType.all;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: FilterType.values.map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(_getFilterLabel(filter)),
              selected: _currentFilter == filter,
              onSelected: (selected) {
                setState(() {
                  _currentFilter = filter;
                });
                context.read<TodoCubit>().applyFilter(filter);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getFilterLabel(FilterType filter) {
    switch (filter) {
      case FilterType.all:
        return 'All';
      case FilterType.completed:
        return 'Completed';
      case FilterType.pending:
        return 'Pending';
      case FilterType.work:
        return 'Work';
      case FilterType.personal:
        return 'Personal';
    }
  }
}