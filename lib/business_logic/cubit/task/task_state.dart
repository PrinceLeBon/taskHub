part of 'task_cubit.dart';

@immutable
abstract class TaskState {
  const TaskState();
}

class TaskInitial extends TaskState {}

class AddingTask extends TaskState {}

class TaskAdded extends TaskState {}

class AddingTaskFailed extends TaskState {
  final String error;

  const AddingTaskFailed({required this.error});
}

class UpdatingTask extends TaskState {}

class TaskUpdated extends TaskState {}

class UpdatingTaskFailed extends TaskState {
  final String error;

  const UpdatingTaskFailed({required this.error});
}

class DeletingTask extends TaskState {}

class TaskDeleted extends TaskState {}

class DeletingTaskFailed extends TaskState {
  final String error;

  const DeletingTaskFailed({required this.error});
}

class LoadingTask extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskAndUsers> taskAndUsersList;

  const TaskLoaded({required this.taskAndUsersList});
}

class LoadingTaskFailed extends TaskState {
  final String error;

  const LoadingTaskFailed({required this.error});
}

class CreatorGetting extends TaskState {}

class CreatorGotten extends TaskState {
  final User user;

  const CreatorGotten({required this.user});
}

class CreatorGettingFailed extends TaskState {
  final String error;

  const CreatorGettingFailed({required this.error});
}
