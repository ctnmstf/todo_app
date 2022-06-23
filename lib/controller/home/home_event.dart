part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchToDo extends HomeEvent{}

class UpdateToDo extends HomeEvent{
  const UpdateToDo(this.toDo);

  final ToDo toDo;

  @override
  List<Object> get props => [toDo];
}

class DeleteToDo extends HomeEvent{
  const DeleteToDo(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
