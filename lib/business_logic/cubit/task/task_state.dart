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
