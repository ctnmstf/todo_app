part of 'add_task_bloc.dart';

class AddTaskState extends Equatable {
  const AddTaskState(
      {this.status = FormzStatus.pure,
      this.title = const TitleV.pure(),
      this.description = const DescriptionV.pure()});

  final FormzStatus status;
  final TitleV title;
  final DescriptionV description;

  AddTaskState copyWith({
    FormzStatus? status,
    TitleV? title,
    DescriptionV? description,
  }) {
    return AddTaskState(
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object> get props => [status, title, description];
}
