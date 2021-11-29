import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'api.dart';


TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  TodoModel({
    required this.id,
    required this.title,
    this.done = false,
  });

  String id;
  String title;
  bool done;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        title: json["title"],
        done: json["done"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "done": done,
      };
}

class MyState extends ChangeNotifier {
  List<TodoModel> _list = [];
  List<TodoModel> get list => _list;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  String _filterValue = 'All';
  String get filterValue => _filterValue;

  Future getTodoModel() async {
    isLoading.value = true;
    List<TodoModel> list = await Api.getTodoModel();
    _list = list;
    isLoading.value = false;
    notifyListeners();
  }

  void addTodoModel(TodoModel todo) async {
    _list.add(todo);
    await Api.addTodoModel(todo);
    await getTodoModel();
  }

  void setDoneTodoModel(TodoModel todo, bool done) async {
    todo.done = done;
    await Api.updateTodo(todo, todo.id);
    await getTodoModel();
  }

  void removeTodoModel(TodoModel todo) async {
    await Api.removeTodoModel(todo.id);
    await getTodoModel();
  }

  void filterTodoModel(String filterValue) {
    _filterValue = filterValue;
    notifyListeners();
  }
}
