

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_m_cv/model/todo.dart';
import 'package:todo_m_cv/widgets/todo_item.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/searchBox.dart';


class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final todosList = Todo.todoList();
  final _controller = TextEditingController();
  @override
    void initState() {
    super.initState();
    loadTodos();
   }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title:  Text('Todo MVC App')),
      
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  //searchBox(),
                  taskTile(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: typeBox(_controller),
          )
        ],
      ),
    );
  }

  // void _handleTodoCHange(Todo todo) {
  //   setState(() {
  //     todo.isDone = !todo.isDone;
  //   });
  // }
   void _handleTodoCHange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    saveTodos();
   }

   void _deleteTodoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
    saveTodos();
    }


    void addTodoItem(String todo) {
    setState(() {
      todosList.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todo));
    });
    _controller.clear();
    saveTodos();}
    
  void loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos');
    if (todosString != null) {
      final List decoded = json.decode(todosString);
      setState(() {
        todosList.clear();
        todosList.addAll(decoded.map((e) => Todo.fromJson(e)).toList());
      });
    }
  }

  void saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(todosList.map((e) => e.toJson()).toList());
    await prefs.setString('todos', encoded);
  }

  Widget typeBox(TextEditingController _controller) {
    return Row(children: [
              Expanded(
                child:Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'add new todo',
                      border: InputBorder.none
                    ),
                  ),
                ) 
              ),
              Container(
                margin: EdgeInsets.only(right: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: (){
                    addTodoItem(_controller.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.red, // Background color
                ), child: Text("+",style: TextStyle(fontSize: 40),),),
              )
            ],);

            
  }

  Widget taskTile() {
    return Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 10),
                          child: Text(
                            'Todo List',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        for (Todo todoo in todosList)
                          TodoItem(
                            todo: todoo,
                            onToChanged: _handleTodoCHange,
                            onDeleteItem: _deleteTodoItem,
                          ),
                        
                      ],
                    ),
                  );}
}