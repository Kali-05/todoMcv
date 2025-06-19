import 'package:flutter/material.dart';
import 'package:todo_m_cv/provider/todo_provide.dart';
import 'package:todo_m_cv/view/todo_view.dart';
import 'package:provider/provider.dart';
//import 'package:todo_m_cv/controller/todo_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoProvider(),
          
        ),
        
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: TodoView(),
      ),
    );
  }
  

}
