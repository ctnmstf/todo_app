part of 'edit_bloc.dart';

abstract class EditEvent extends Equatable {
  const EditEvent();

  @override
  List<Object> get props => [];
}

class TitleUpdate extends EditEvent {
  const TitleUpdate(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class DescriptionUpdate extends EditEvent {
  const DescriptionUpdate(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class Update extends EditEvent {
  const Update(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class Done extends EditEvent {
  const Done(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class Delete extends EditEvent {
  const Delete(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
