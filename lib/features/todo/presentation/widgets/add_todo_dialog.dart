import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/constants/constants.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/presentation/cubit/todo_cubit.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _selectedCategory = AppCategories.defaultCategory;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: fastAnimationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();

    // Auto-focus the text field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _addTodo() async {
    if (_controller.text.trim().isEmpty) {
      _showErrorSnackBar(AppStrings.enterTodoTitle);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final todo = TodoEntity(
        id: DateTime.now().toString(),
        title: _controller.text.trim(),
        isCompleted: false,
        category: _selectedCategory,
      );

      context.read<TodoCubit>().addTodoItem(todo);

      // Add a small delay for better UX
      await Future.delayed(slowAnimationDuration);

      if (mounted) {
        Navigator.pop(context);
        _showSuccessSnackBar(AppStrings.todoAddedSuccess);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar(AppStrings.failedToAddTodo);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: snackBarBackGroundColorError,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: snackBarBackGroundColorSuccess,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusLarge)),
        elevation: mediumElevation,
        child: Container(
          padding: const EdgeInsets.all(paddingAllLarge),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusLarge),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.surface,
                colorScheme.surface.withValues(alpha: 0.8),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon and title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.add_task,
                      color: colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: paddingHorizontal),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.addNewTodo,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          AppStrings.createTaskSubtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: paddingAllLarge),

              // Todo title input
              Text(
                AppStrings.taskTitle,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: sizeBoxHeight),
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                maxLength: maxTitleLength,
                decoration: InputDecoration(
                  hintText: AppStrings.enterTaskHint,
                  prefixIcon: Icon(Icons.edit_note, color: colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: borderWidth,
                    ),
                  ),
                  filled: true,
                  fillColor: colorScheme.surface,
                  counterText: '',
                ),
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (_) => _addTodo(),
              ),

              const SizedBox(height: sizeBoxHeightLarge),

              // Category selection
              Text(
                AppStrings.category,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: sizeBoxHeightSmall),

              // Category chips
              Row(
                children: [
                  Expanded(
                    child: _CategoryChip(
                      label: AppStrings.categoryPersonal,
                      icon: Icons.person,
                      isSelected: _selectedCategory == AppCategories.personal,
                      onTap: () {
                        setState(() {
                          _selectedCategory = AppCategories.personal;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: sizeBoxHeightSmall),
                  Expanded(
                    child: _CategoryChip(
                      label: AppStrings.categoryWork,
                      icon: Icons.work,
                      isSelected: _selectedCategory == AppCategories.work,
                      onTap: () {
                        setState(() {
                          _selectedCategory = AppCategories.work;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: sizeBoxHeightExtraLarge),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _isLoading
                          ? null
                          : () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: paddingVertical,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            borderRadiusSmall,
                          ),
                        ),
                      ),
                      child: Text(
                        AppStrings.cancel,
                        style: TextStyle(
                          fontSize: fontSizeMedium,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: sizeBoxHeightSmall),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _addTodo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          vertical: paddingVertical,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            borderRadiusSmall,
                          ),
                        ),
                        elevation: extrasmallElevation,
                      ),
                      child: _isLoading
                          ? SizedBox(
                              height: sizeBoxHeightLarge,
                              width: sizeBoxWidthLarge,
                              child: CircularProgressIndicator(
                                strokeWidth: strokeWidth,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  colorScheme.onPrimary,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: iconSizeMedium,
                                  color: colorScheme.onPrimary,
                                ),
                                const SizedBox(width: sizeBoxHeight),
                                Text(
                                  AppStrings.addTodo,
                                  style: TextStyle(
                                    fontSize: fontSizeMedium,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: animationDuration),
        padding: const EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.1)
              : colorScheme.surface,
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outline.withValues(alpha: 0.5),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(borderRadiusSmall),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSizeMedium,
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const SizedBox(width: sizeBoxHeight),
            Text(
              label,
              style: TextStyle(
                fontSize: fontSizeSmall,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
