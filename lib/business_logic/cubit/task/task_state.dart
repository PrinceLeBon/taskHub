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
