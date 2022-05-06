import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_tdd/features/add_task/data/model/task_model.dart';
import 'package:todo_app_tdd/features/add_task/domain/entity/task.dart';

String ficture(String fileName) =>
    File('test/fixture/' + fileName).readAsStringSync();

void main() {
  final tTaskModel = TaskModel(
      title: 'Title',
      description: 'test',
      dateTime: '',
      isDone: 1,
      views: 1202);

  test('should [TaskModel] equal [TaskEntity] subclass', () {
    //arrange
    //act
    //assert
    expect(TaskModel(), isA<TaskEntity>());
  });

  test('should convert json to [TaskModel]', () {
    //arrange
    //act
    final task = TaskModel.fromJson(json.decode(ficture('task.json')));
    //assert
    expect(task, equals(tTaskModel));
  });

  test('should convert model to json', () {
    //arrange
    final taskJson = json.decode(ficture('task.json'));
    //act
    final task = tTaskModel.toJson();
    //assert
    expect(task, equals(taskJson));
  });
}
