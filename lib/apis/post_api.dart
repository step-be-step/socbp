import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:socbp/constants/constants.dart';
import 'package:socbp/core/core.dart';
import 'package:socbp/core/providers.dart';
import 'package:socbp/model/post_model.dart';

final postAPIProvider = Provider((ref) {
  return PostAPI(
      db: ref.watch(
    appwriteDatabaseProvider,
  ));
});

abstract class IPostApi {
  FutureEither<Document> sharePost(Post post);
}

class PostAPI implements IPostApi {
  final Databases _db;
  PostAPI({required db}) : _db = db;

  @override
  FutureEither<Document> sharePost(Post post) async {
    try {
      final document = await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.postCollection,
        documentId: ID.unique(),
        data: post.toMap(),
      );
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Произошла неожидання ошибка", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
