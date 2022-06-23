import 'package:equatable/equatable.dart';

class ToDo extends Equatable{
  const ToDo({this.id, required this.title, required this.description, required this.status});

  final int? id;
  final String title;
  final String description;
  final int status;

  static const empty = ToDo(id: 0, title: '', description: '', status: 0);

  factory ToDo.fromJSON(Map<String, dynamic> json){
    return ToDo(id: json['id'], title: json['title'], description: json['description'], status: json['status']);
  }

  Map<String, dynamic> toJSON(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status
    };
  }

  @override
  List<Object> get props => [title, description, status];
}