import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/constants/constants.dart';
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
      height: sizeBoxHeightVeryLarge,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: paddingHorizontal),
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
        return AppStrings.filterAll;
      case FilterType.completed:
        return AppStrings.filterCompleted;
      case FilterType.pending:
        return AppStrings.filterPending;
      case FilterType.work:
        return AppStrings.filterWork;
      case FilterType.personal:
        return AppStrings.filterPersonal;
    }
  }
}