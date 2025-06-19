import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/todo.dart';

class TodoProvider extends ChangeNotifier {
 
  final List<Todo> _todosList = [];
  List<Todo> get todosList => List.unmodifiable(_todosList);
  final TextEditingController textController = TextEditingController();
  
  TodoProvider() {
    _initializeProvider();
  }
  
  
  void _initializeProvider() {
    loadTodos();
  }
  

  Future<void> loadTodos() async {
  
      final prefs = await SharedPreferences.getInstance();
      final String? todosString = prefs.getString('todos');
      
      if (todosString != null) {
        final List decoded = json.decode(todosString);
        _todosList.clear();
        _todosList.addAll(decoded.map((e) => Todo.fromJson(e)).toList());
        notifyListeners(); 
      }
    
  }
  

  Future<void> saveTodos() async {

      final prefs = await SharedPreferences.getInstance();
      final String encoded = json.encode(_todosList.map((e) => e.toJson()).toList());
      await prefs.setString('todos', encoded);
    
  }
  
  
  void addTodoItem(String todoText) {
    if (todoText.trim().isEmpty) return; 
    
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: todoText.trim(),
    );
    
    _todosList.add(newTodo);
    textController.clear();
    saveTodos();
    notifyListeners(); 
  }
  
 
    void handleTodoCHange(Todo todo) {
    
      todo.isDone = !todo.isDone;
    
    saveTodos();
    notifyListeners();
   }
  
   void deleteTodoItem(String id) {
     _todosList.removeWhere((item) => item.id == id);
    saveTodos();
    notifyListeners();
  }
  

  int get totalTodos => _todosList.length;
 
  int get completedTodos => _todosList.where((todo) => todo.isDone).length;
  
  int get pendingTodos => _todosList.where((todo) => !todo.isDone).length;
  
  // // Clear all todos
  // void clearAllTodos() {
  //   _todosList.clear();
  //   saveTodos();
  //   notifyListeners();
  // }
  
  // // Clear completed todos
  // void clearCompletedTodos() {
  //   _todosList.removeWhere((todo) => todo.isDone);
  //   saveTodos();
  //   notifyListeners();
  // }
  
  // @override
  // void dispose() {
  //   textController.dispose();
  //   super.dispose();
  // }
}