import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:socbp/constants/constants.dart';
import 'package:socbp/core/failure.dart';
import 'package:socbp/core/providers.dart';

import 'package:socbp/core/type_defs.dart';
import 'package:socbp/model/user_model.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(
    db: ref.watch(appwriteDatabaseProvider),
  );
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<models.Document> getUserData(String uid);
}

class UserAPI implements IUserAPI {
  final Databases _db;

  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? 'Произошла неожиданная ошибка', st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<models.Document> getUserData(String uid) {
    return _db.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersCollection,
      documentId: uid,
    );
  }
}
