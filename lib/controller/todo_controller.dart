import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_m_cv/provider/todo_provide.dart';
import '../model/todo.dart';

class TodoController extends ChangeNotifier {
   static TodoProvider getProvider(BuildContext context, {bool listen = true}) {
    return Provider.of<TodoProvider>(context, listen: listen);
  }
  
  
  
  static void addTodoItem(BuildContext context, String todoText) {
    final provider = getProvider(context, listen: false);
    provider.addTodoItem(todoText);
  }

  static void handleTodoCHange(BuildContext context, Todo todo) {
    final provider = getProvider(context, listen: false);
    provider.handleTodoCHange(todo);
  }
  
  // Delete todo item
  static void deleteTodoItem(BuildContext context, String id) {
    final provider = getProvider(context, listen: false);
    provider.deleteTodoItem(id);
  }
    static TextEditingController getTextController(BuildContext context) {
    final provider = getProvider(context, listen: false);
    return provider.textController;
  }
  

  
}
