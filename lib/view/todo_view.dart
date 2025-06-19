

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_m_cv/controller/todo_controller.dart';
import 'package:todo_m_cv/model/todo.dart';
import 'package:todo_m_cv/provider/todo_provide.dart';
import 'package:todo_m_cv/widgets/todo_item.dart';



class TodoView extends StatefulWidget {
  const TodoView({super.key});

 @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  
  
  
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
            child: typeBox(),
          )
        ],
      ),
    );
  }

  
  
   

  Widget typeBox( ) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
      return Row(children: [
                
      
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.3),
                          ),
                        ),
                        child: TextField(
                          controller: todoProvider.textController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Add new todo',
                            hintStyle: TextStyle(color: Colors.blue),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (value) {
                        TodoController.addTodoItem(context, value);
                      },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      
                Container(
                  margin: EdgeInsets.only(right: 20, bottom: 20),
                  child: ElevatedButton(
                    onPressed: (){
                      TodoController.addTodoItem(context, todoProvider.textController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      backgroundColor: Colors.blue, // Background color
                  ), child: Text("+",style: TextStyle(fontSize: 40,),),),
                )
              ],);}
    );

            
  }

  Widget taskTile() {
    return Expanded(
                    child: Consumer<TodoProvider>(
                      builder: (context, todoProvider, child) {
                      return ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: Text(
                              'Todo List',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          for (Todo todoo in todoProvider.todosList)
                            TodoItem(
                              todo: todoo,
                              onToChanged: (Todo todo) => TodoController.handleTodoCHange(context, todo),
                  onDeleteItem: (String id) => TodoController.deleteTodoItem(context, id),
                            ),
                          
                        ],
                      );}
                    ),
                  );}
}