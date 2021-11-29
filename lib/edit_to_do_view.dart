import 'package:flutter/material.dart';

import 'model.dart';

class EditTodoView extends StatefulWidget {
  final TodoModel todo;

  const EditTodoView(this.todo, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditTodoViewState();
}

class EditTodoViewState extends State<EditTodoView> {
  late TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Skapa en Todo",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            textField(),
            saveTodo(),
          ],
        ),
      ),
    );
  }

  Widget textField() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: TextField(
        controller: textEditingController,
        decoration: const InputDecoration(
          hintText: 'Vad vill du lägga till?',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }

  Widget saveTodo() {
    return Column(
      children: [
        TextButton.icon(
          onPressed: () {
            Navigator.pop(
                context, TodoModel(title: textEditingController.text, id: ''));
          },
          icon: const Icon(Icons.add),
          label: const Text(
            'Lägg till',
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }
}
