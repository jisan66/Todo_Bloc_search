import 'package:demo_bloc/todo/bloc/todo_bloc.dart';
import 'package:demo_bloc/todo/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<bool> hide = [];

  @override
  void initState() {
    toDo.add(TodoInitialEvent());
    super.initState();
  }

  final toDo = TodoBloc();
  Box<TodoModel> box = Hive.box('todo');

  final _titileController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
        appBar: AppBar(
          title: Text('T O  D O  A P P'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialog(context);
          },
          child: Icon(Icons.add),
        ),
        body: BlocConsumer<TodoBloc, TodoState>(
          listenWhen: (previous, current) => current is TodoActionState,
          buildWhen: (previous, current) => current is! TodoActionState,
          listener: (context, state) {
            if (state is TodoAddActionState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Successfull to add the data'),
                duration: Duration(milliseconds: 200),
                backgroundColor: Colors.green,
              ));
            } else if (state is TodoDeletActionState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Successfull Delete'),
                duration: Duration(milliseconds: 200),
                backgroundColor: Colors.red,
              ));
            } else if (state is TodoUpdateActionState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Successfully Update'),
                duration: Duration(milliseconds: 200),
                backgroundColor: Colors.green,
              ));
            }
          },
          bloc: toDo,
          builder: (context, state) {
            if (state is TodoLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TodoSuccessState) {
              return ListView.builder(
                itemBuilder: (context,
                        index) => /* box.getAt(index)!.done == false
                    ? */
                    Card(
                  child: ExpansionTile(
                    // expandedAlignment: Alignment.centerLeft,
                    // expandedCrossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                _showDialog(context,
                                    index: index,
                                    titile: state.box
                                        .getAt(index)!
                                        .titile
                                        .toString(),
                                    description: state.box
                                        .getAt(index)!
                                        .description
                                        .toString(),
                                    done: state.box.getAt(index)!.done);
                              },
                              icon: Icon(Icons.update)),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      content: Text(
                                        'ARE YOU WANT TO DELETE THIS ?',
                                        textAlign: TextAlign.center,
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      actions: [
                                        Card(
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('NO'),
                                          ),
                                        ),
                                        Card(
                                          child: MaterialButton(
                                            onPressed: () {
                                              toDo.add(TodoRemoveEvent(
                                                  index: index));
                                              Navigator.pop(context);
                                            },
                                            child: Text('YES'),
                                          ),
                                        ),
                                      ]),
                                );
                              },
                              icon: Icon(
                                Icons.remove_moderator_outlined,
                                color: Colors.red,
                              )),
                        ],
                      )
                    ],
                    trailing: IconButton(
                      onPressed: () {
                        toDo.add(TodoUpdateEvent(
                          index: index,
                          todo: TodoModel(
                              titile: box.getAt(index)!.titile.toString(),
                              done:
                                  box.getAt(index)!.done == true ? false : true,
                              description:
                                  box.getAt(index)!.description.toString()),
                        ));
                      },
                      icon: Icon(
                        box.getAt(index)!.done == false
                            ? Icons.check_box_outline_blank
                            : Icons.check_box,
                        color: Colors.red,
                      ),
                    ),

                    title: Text(state.box.getAt(index)!.titile),
                    subtitle:
                        Text(state.box.getAt(index)!.description.toString()),
                  ),
                ) /* : SizedBox() */,
                itemCount: state.box.length,
              );
            }
            return SizedBox();
          },
        ));
  }

  Future<dynamic> _showDialog(BuildContext context,
      {int? index, String? titile, String? description, bool? done}) {
    if (index != null) {
      _titileController.text = titile!;
      _descriptionController.text = description!;
    } else {
      _descriptionController.clear();
      _titileController.clear();
    }

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          // alignment: Alignment.center,
          title: Center(child: Text('T O  D O')),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titileController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'T I T L E'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  maxLines: 2,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'D E S C R I P T I O N'),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            Card(
              // margin: EdgeInsets.zero,
              // elevation: 0,
              child: MaterialButton(
                // color: Colors.grey,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('N O'),
              ),
            ),
            Card(
              // margin: EdgeInsets.zero,
              // elevation: 0,
              child: MaterialButton(
                // color: Colors.grey,
                onPressed: () {
                  if (_titileController.text.trim().isNotEmpty &&
                      _descriptionController.text.trim().isNotEmpty) {
                    toDo.add(index == null
                        ? TodoAddEvent(
                            todo: TodoModel(
                            titile: _titileController.text,
                            description: _descriptionController.text,
                          ))
                        : TodoUpdateEvent(
                            todo: TodoModel(
                                titile: _titileController.text,
                                description: _descriptionController.text,
                                done: done),
                            index: index,
                          ));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 200),
                      content: Text('E R R O R'),
                      backgroundColor: Colors.red,
                    ));
                    // Navigator.pop(context);
                  }
                },
                child: Text(index == null ? 'S A V E' : 'U P D A T E'),
              ),
            ),
          ]),
    );
  }
}






// Column(
//               children: [
//                 TextField(
//                   controller: _titileController,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), hintText: 'T I T L E'),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _descriptionController,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'D E S C R I P T I O N'),
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       if (_titileController.text.trim().isNotEmpty &&
//                           _descriptionController.text.trim().isNotEmpty) {
//                         toDo.add(TodoAddEvent(
//                             todo: TodoModel(
//                                 titile: _titileController.text,
//                                 description: _descriptionController.text)));
//                         _descriptionController.clear();
//                         _titileController.clear();
//                       }
//                     },
//                     child: Text('ADD'))
//               ],
//             )