import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "TIG169 Att göra lista",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          _todoFilter(),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            _todoItem('Träna'),
            _todoItem('Plugga'),
            _todoItem('Spela'),
            _todoItem('Skicka in plugg'),
            _todoItem('Dricka 10 öl'),
          ],
        ),
      ),
      floatingActionButton: _addButton(context),
    );
  }

  Widget _todoFilter() {
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("Markera alla"),
        ),
        PopupMenuItem(
          child: Text("Avmarkera alla"),
        ),
      ],
      icon: Icon(Icons.more_vert, size: 30, color: Colors.black),
    );
  }

  Widget _todoItem(String text) {
    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (val) {},
        ),
        Expanded(
          flex: 5,
          child: Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _addButton(BuildContext context) {
    return FloatingActionButton(
      elevation: 0.0,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondView()),
        );
      },
      backgroundColor: (Colors.blue),
      child: Icon(
        Icons.add,
        size: 50,
      ),
    );
  }
}

class SecondView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "TIG169 Att göra lista",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            _textField(),
            _addButton(),
          ],
        ),
      ),
    );
  }

  Widget _textField() {
    return Container(
      padding: EdgeInsets.all(24),
      child: TextField(
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            hintText: "Vad ska du göra?"),
      ),
    );
  }

  Widget _addButton() {
    return Column(
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.add),
          label: Text(
            'Lägg till',
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }
}