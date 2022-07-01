import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/repo/todo_repo.dart';
import 'package:todo_app/validator/description_validator.dart';
import 'package:todo_app/validator/title_validator.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc({required ToDoRepo toDoRepo})
      : _toDoRepo = toDoRepo,
        super(const EditState()) {
    on<TitleUpdate>(_onTitleUpdate);
    on<DescriptionUpdate>(_onDescriptionUpdate);
    on<Update>(_onUpdate);
    on<Done>(_onDone);
    on<Delete>(_onDelete);
  }

  final ToDoRepo _toDoRepo;

  void _onTitleUpdate(
    TitleUpdate event,
    Emitter<EditState> emit,
  ) {
    final title = TitleV.dirty(event.title);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([state.title, state.description]),
    ));
  }

  void _onDescriptionUpdate(
    DescriptionUpdate event,
    Emitter<EditState> emit,
  ) {
    final description = DescriptionV.dirty(event.description);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([state.description, state.title]),
    ));
  }

  void _onUpdate(
    Update event,
    Emitter<EditState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _toDoRepo.updateToDo(ToDo(
          id: event.id,
          title: state.title.value,
          description: state.description.value,
          status: 0));
      return emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      return emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void _onDone(
    Done event,
    Emitter<EditState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _toDoRepo.updateToDo(ToDo(
          id: event.id,
          title: state.title.value,
          description: state.description.value,
          status: 1));
      return emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      return emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void _onDelete(
    Delete event,
    Emitter<EditState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _toDoRepo.deleteToDo(event.id);
      return emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      return emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
