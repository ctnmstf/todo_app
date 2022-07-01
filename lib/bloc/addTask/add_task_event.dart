part of 'add_task_bloc.dart';

abstract class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object> get props => [];
}

class TitleChanged extends AddTaskEvent {
  const TitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class DescriptionChanged extends AddTaskEvent {
  const DescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class FormSubmitted extends AddTaskEvent {
  const FormSubmitted();
}
