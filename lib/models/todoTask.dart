
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TodoTask extends Equatable {
  final String title;
  bool? isDone;
  bool? isDeleted;

  TodoTask({
    required this.title,
    this.isDone,
    this.isDeleted,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  TodoTask copyWith({
    String? title,
    bool? isDone,
    bool? isDeleted,
  }) {
    return TodoTask(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory TodoTask.fromMap(Map<String, dynamic> map) {
    return TodoTask(
      title: map['title'] as String,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
    );
  }
  
  @override
  List<Object?> get props => [
    title,isDone,isDeleted,
  ];
}
