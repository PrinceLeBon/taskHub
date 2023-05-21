import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:appwrite/appwrite.dart';
import '../../../data/models/task.dart';
import '../../../utils/constants.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  Future addTasks(Client client, TaskModel task) async {
    emit(AddingTask());
    try {
      final Databases databases = Databases(client);
      final String documentId = ID.unique();
      task.id = documentId;

      await databases.createDocument(
          databaseId: databaseId,
          collectionId: taskCollectionId,
          documentId: documentId,
          data: task.toMap());

      emit(TaskAdded());
    } on AppwriteException catch (e) {
      Logger().e("Error while adding task to database: $e");
      emit(AddingTaskFailed(error: "Error while adding task to database: $e"));
    }
  }
}
