import 'package:flutter/material.dart';
import 'package:todo_m_cv/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo ;
  final onToChanged;
  final onDeleteItem;
  const TodoItem({super.key,required this.todo, required this.onToChanged, required this.onDeleteItem});
  
  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.blue.withOpacity(0.3),
            ),
          ),
      margin: EdgeInsets.only(bottom: 20),
   child: ListTile(
      onTap: (){
        onToChanged(todo);
      },
      shape: RoundedRectangleBorder
        (borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.blue,
        leading: Icon(todo.isDone ? Icons.check_box:Icons.check_box_outline_blank, color: Colors.white, size: 30),
        title: Text(todo.todoText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none, color: Colors.white)),
        trailing: IconButton(onPressed: (){
          onDeleteItem(todo.id);
        }, icon: Icon(Icons.delete, color: Colors.white, size: 30))
    ),
    );
  }
}