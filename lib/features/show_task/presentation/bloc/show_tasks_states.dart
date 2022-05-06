abstract class ShowTaskState {}

class HomeEmpty extends ShowTaskState {}

class HomeLoading extends ShowTaskState {}

class HomeLoaded extends ShowTaskState {}

class HomeError extends ShowTaskState {
  final String? msg;
  HomeError(this.msg);
}
