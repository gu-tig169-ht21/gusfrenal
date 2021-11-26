import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'model.dart';

const API_URL = 'https://todoapp-api-pyq5q.ondigitalocean.app';
const API_KEY = '7037674e-2262-4502-a2e1-29c940bd2a7a';

class Api {
  static Future addTodoModel(TodoModel todo) async {
    var json = todo.toJson();
    var bodyString = jsonEncode(json);
    

    var response = await http.post(Uri.parse('$API_URL/todos?key=$API_KEY'), 
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',}, 
    body: bodyString);
    if (response.statusCode == 200) {
      return response;
    } else {
      print('error on add');
      return null;
    }
  }

  static Future updateTodo(TodoModel todo, todoId) async {
    var json = todo.toJson();
    var bodyString = jsonEncode(json);


    var response = await http.put(Uri.parse('$API_URL/todos?key=$API_KEY'), 
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',}, 
    body: bodyString);
    if (response.statusCode == 200) {
      return response;
    } else {
      print('error on update');
      return null;
    }
  }

  static Future removeTodoModel(String todoId) async {
    try {
      var response = await http.delete(Uri.parse('$API_URL/todos/$todoId?key=$API_KEY'));
      if (response.statusCode == 200) {
        return response;
      }
      print('exception on remove');
    } catch (exception) {
      throw exception;
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
      throw exception;
    }
  }
}