import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart' as model;
import 'package:fpdart/fpdart.dart';
import 'package:socbp/core/core.dart';
import 'package:socbp/core/providers.dart';

final aithAPIProvider = Provider((ref) {
  return AuthAPI(
    account: ref.watch(appwriteAccountProvider),
  );
});

abstract class IAuthAPI {
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  });
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Произошла неожиданная ошибка', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }
}
