import 'package:equatable/equatable.dart';

abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

abstract class UseCaseNoParams<T> {
  Future<T> call();
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}