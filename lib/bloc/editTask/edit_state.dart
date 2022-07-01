part of 'edit_bloc.dart';

class EditState extends Equatable {
  const EditState(
      {this.status = FormzStatus.pure,
      this.title = const TitleV.pure(),
      this.description = const DescriptionV.pure()});

  final FormzStatus status;
  final TitleV title;
  final DescriptionV description;

  EditState copyWith({
    FormzStatus? status,
    TitleV? title,
    DescriptionV? description,
  }) {
    return EditState(
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object> get props => [status, title, description];
}
