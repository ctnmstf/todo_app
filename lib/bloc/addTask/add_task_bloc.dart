import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/repo/todo_repo.dart';
import 'package:todo_app/validator/description_validator.dart';
import 'package:todo_app/validator/title_validator.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc({required ToDoRepo toDoRepo})
      : _toDoRepo = toDoRepo,
        super(const AddTaskState()) {
    on<TitleChanged>(_onTitleChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<FormSubmitted>(_onSubmitted);
  }

  final ToDoRepo _toDoRepo;

  void _onTitleChanged(
    TitleChanged event,
    Emitter<AddTaskState> emit,
  ) {
    final title = TitleV.dirty(event.title);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([title, state.description]),
    ));
  }

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<AddTaskState> emit,
  ) {
    final description = DescriptionV.dirty(event.description);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([description, state.title]),
    ));
  }

  void _onSubmitted(
    FormSubmitted event,
    Emitter<AddTaskState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _toDoRepo.createToDo(ToDo(
            title: state.title.value,
            description: state.description.value,
            status: 0));
        return emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        return emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
