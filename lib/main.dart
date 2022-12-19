import 'package:flutter/material.dart';
import 'package:pre_finals/mainpage.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    title:  "Pre-Finals Hands On Exam",
    home: const ToDoListDisplay(),
  ));

}