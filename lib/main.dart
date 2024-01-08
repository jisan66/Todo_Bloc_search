// import 'package:demo_bloc/home/ui/home_screen.dart';
import 'package:demo_bloc/searching/searching.dart';
import 'package:demo_bloc/todo/models/todo_model.dart';
import 'package:demo_bloc/todo/ui/todo.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  Box<TodoModel> box = await Hive.openBox('todo');

  // box.clear();

  // await box.put('abc', TodoModel(titile: 'Text',description: 'ajdajdj'));

  // var a = TodoModel(titile: 'titile', description: 'ajdjjad');

  // box.add(a);
  // await a.save();
  // final TodoModel todoModel;

  // print(box.values.first.description);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: false,
      ),
      home: Searching(),
    );
  }
}
