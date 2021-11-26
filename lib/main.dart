import 'package:flutter/material.dart';
import 'model.dart';
import 'TodoListView.dart';
import 'package:provider/provider.dart';

void main() {
  var state = MyState();
  state.getTodoModel();

  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TIG169 Att göra lista',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListView(),
    );
  }
}