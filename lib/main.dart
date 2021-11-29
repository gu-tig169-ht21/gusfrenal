import 'package:flutter/material.dart';
import 'model.dart';
import 'to_do_list_view.dart';
import 'package:provider/provider.dart';

void main() {
  var state = MyState();
  state.getTodoModel();

  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TIG169 Att göra lista',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TodoListView(),
    );
  }
}
