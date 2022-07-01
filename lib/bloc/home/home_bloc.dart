import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/repo/todo_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required ToDoRepo toDoRepo})
      : _toDoRepo = toDoRepo,
        super(const HomeState()) {
    on<FetchToDo>(_onFetchToDo);
  }

  final ToDoRepo _toDoRepo;

  Future<void> _onFetchToDo(FetchToDo event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final toDoList = await _toDoRepo.getAllToDo();
      return emit(state.copyWith(status: HomeStatus.success, toDo: toDoList));
    } catch (e) {
      return emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
