import 'package:task_manager/data/providers/authentication.dart';
import 'package:appwrite/appwrite.dart';
import '../models/session.dart';
import '../models/user.dart';

class AuthenticationRepository {
  final AuthenticationAPI authenticationAPI = AuthenticationAPI();

  Future<Session> login(Account account, String email, String password) async {
    final sessionFromAppWrite = await authenticationAPI.login(
      account,
      email,
      password,
    );

    final Session session = Session(
      userId: sessionFromAppWrite.userId,
      sessionId: sessionFromAppWrite.$id,
    );

    return session;
  }

  Future<void> signUp(Account account, User user, String password) async {
    await authenticationAPI.signUp(account, user, password);
    await authenticationAPI.addUserToDatabase(account.client, user);
  }
}
