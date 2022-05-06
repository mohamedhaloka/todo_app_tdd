import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String? msg;
  final int? code;
  const Failure({this.msg, this.code});

  @override
  List<Object?> get props => [msg, code];
}

class CacheFailure extends Failure {
  const CacheFailure(String msg) : super(msg: msg);
}
