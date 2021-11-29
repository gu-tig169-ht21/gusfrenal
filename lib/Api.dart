// ignore_for_file: file_names
import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'model.dart';

// ignore: constant_identifier_names
const String API_URL = 'https://todoapp-api-pyq5q.ondigitalocean.app';
// ignore: constant_identifier_names
const API_KEY = '7037674e-2262-4502-a2e1-29c940bd2a7a';

class Api {
  static Future addTodoModel(TodoModel todo) async {
    var json = todo.toJson();
    var bodyString = jsonEncode(json);

    var response = await http.post(Uri.parse('$API_URL/todos?key=$API_KEY'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyString);
    if (response.statusCode == 200) {
      return response;
    } else {
      log('error on add');
      return null;
    }
  }

  static Future updateTodo(TodoModel todo, todoId) async {
    var json = todo.toJson();
    var bodyString = jsonEncode(json);
    var response =
        await http.put(Uri.parse('$API_URL/todos/$todoId?key=$API_KEY'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: bodyString);
    if (response.statusCode == 200) {
      return response;
    } else {
      log('error on update ${response.body}');
      return null;
    }
  }

  static Future removeTodoModel(String todoId) async {
    try {
      var response =
          await http.delete(Uri.parse('$API_URL/todos/$todoId?key=$API_KEY'));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (exception) {
      log('exception on remove');
    }
  }

  static Future<List<TodoModel>> getTodoModel() async {
    try {
      var response = await http.get(Uri.parse('$API_URL/todos?key=$API_KEY'));
      var json = jsonDecode(response.body);
      return json.map<TodoModel>((data) {
        return TodoModel.fromJson(data);
      }).toList();
    } catch (exception) {
      log(exception.toString());
      return [];
    }
  }
}
