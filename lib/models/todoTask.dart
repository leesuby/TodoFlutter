
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TodoTask extends Equatable {
  final String title;
  final DateTime time;
  bool? isDone;
  bool? isDeleted;

  TodoTask({
    required this.title,
    required this.time,
    this.isDone,
    this.isDeleted,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  TodoTask copyWith({
    String? title,
    DateTime? time,
    bool? isDone,
    bool? isDeleted,
  }) {
    return TodoTask(
      title: title ?? this.title,
      time: time ?? this.time,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'time': time.toIso8601String(),
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory TodoTask.fromMap(Map<String, dynamic> map) {
    return TodoTask(
      title: map['title'] as String,
      time: DateTime.parse(map['time']),
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
    );
  }
  
  @override
  List<Object?> get props => [
    title,time,isDone,isDeleted,
  ];
}
