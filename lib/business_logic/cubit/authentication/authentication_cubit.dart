import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:appwrite/appwrite.dart';
import 'package:task_manager/data/models/user.dart';
import '../../../data/models/session.dart';
import '../../../data/repositories/authentication.dart';
import 'package:hive/hive.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationCubit({required this.authenticationRepository})
      : super(AuthenticationInitial());

  void login(Account account, String email, String password) async {
    emit(Login());
    try {
      final Session session =
          await authenticationRepository.login(account, email, password);
      final Box taskHubBox = Hive.box("TaskHub");
      taskHubBox.put("userId", session.userId);
      taskHubBox.put("sessionId", session.sessionId);
      emit(Logged(session: session));
    } on AppwriteException catch (e) {
      Logger().e("Error when logging: $onError");
      emit(LoginFailed(error: "Error when logging: $onError"));
    }
  }

  Future signUp(Account account, User user, String password) async {
    emit(Signing());
    try {
      final String uniqueId = ID.unique();
      user.id = uniqueId;
      await authenticationRepository.signUp(account, user, password);
      Logger().i("Account create successful");
      emit(Signed());
    } on AppwriteException catch (e) {
      Logger().e("Error when creating account: $e");
      emit(SigningFailed(error: "Error when creating account: $e"));
    }
  }
}
