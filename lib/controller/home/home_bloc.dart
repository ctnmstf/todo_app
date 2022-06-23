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
    on<UpdateToDo>(_onUpdateToDo);
    on<DeleteToDo>(_onDeleteToDo);
  }

  final ToDoRepo _toDoRepo;

  Future<void> _onFetchToDo(FetchToDo event, Emitter<HomeState> emit) async {
    if (state.status == HomeStatus.initial) {
      try {
        final toDoList = await _toDoRepo.getAllToDo();
        return emit(state.copyWith(status: HomeStatus.success, toDo: toDoList));
      } catch (e) {
        return emit(state.copyWith(status: HomeStatus.failure));
      }
    }
  }

  Future<void> _onUpdateToDo(UpdateToDo event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
      try {
        final response = await _toDoRepo.updateToDo(event.toDo);
        final toDoList = await _toDoRepo.getAllToDo();
        return emit(state.copyWith(status: HomeStatus.success, toDo: toDoList));
      } catch (e) {
        return emit(state.copyWith(status: HomeStatus.failure));
      }
  }

  Future<void> _onDeleteToDo(DeleteToDo event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
      try {
        final response = await _toDoRepo.deleteToDo(event.id);
        final toDoList = await _toDoRepo.getAllToDo();
        return emit(state.copyWith(status: HomeStatus.success, toDo: toDoList));
      } catch (e) {
        return emit(state.copyWith(status: HomeStatus.failure));
      }
  }
}
