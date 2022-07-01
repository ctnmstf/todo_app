part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.toDo = const [],
  });

  final HomeStatus status;
  final List<ToDo> toDo;

  HomeState copyWith({
    HomeStatus? status,
    List<ToDo>? toDo,
  }) {
    return HomeState(status: status ?? this.status, toDo: toDo ?? this.toDo);
  }

  @override
  List<Object> get props => [status, toDo];
}
