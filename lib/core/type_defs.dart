import 'package:fpdart/fpdart.dart';
import 'package:socbp/core/core.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
