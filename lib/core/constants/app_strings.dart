library;

abstract class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'Todo App';

  // Button Labels
  static const String addTodo = 'Add Todo';
  static const String cancel = 'Cancel';

  // Dialog Titles and Messages
  static const String addNewTodo = 'Add New Todo';
  static const String createTaskSubtitle = 'Create a new task to stay organized';
  static const String taskTitle = 'Task Title';
  static const String category = 'Category';

  // Hint Texts
  static const String enterTaskHint = 'Enter your task here...';
  static const String searchTodosHint = 'Search todos...';

  // Error Messages
  static const String enterTodoTitle = 'Please enter a todo title';
  static const String failedToAddTodo = 'Failed to add todo. Please try again.';

  // Success Messages
  static const String todoAddedSuccess = 'Todo added successfully!';

  // Empty State
  static const String noTodosYet = 'No todos yet!';

  // Filter Labels
  static const String filterAll = 'All';
  static const String filterCompleted = 'Completed';
  static const String filterPending = 'Pending';
  static const String filterWork = 'Work';
  static const String filterPersonal = 'Personal';

  // Category Labels
  static const String categoryWork = 'Work';
  static const String categoryPersonal = 'Personal';
}
