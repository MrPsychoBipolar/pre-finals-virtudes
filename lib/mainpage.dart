import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ToDoListDisplay extends StatefulWidget {
  const ToDoListDisplay({Key? key}) : super(key: key);

  @override
  State<ToDoListDisplay> createState() => _ToDoListDisplayState();
}

class _ToDoListDisplayState extends State<ToDoListDisplay> {
  List userDataArray = <dynamic>[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var url = "https://jsonplaceholder.typicode.com/comments";
    var response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      setState((){
        userDataArray = convert.jsonDecode(response.body) as List<dynamic>;
      });
    }
  }

  void deleteData(var id) async {
    var url = "https://jsonplaceholder.typicode.com/comments";
    var response = await http.delete(Uri.parse(url));

    if(response.statusCode == 200) {
      final filteredId = userDataArray.where((element) => element['id'] != id).toList();
    setState(() {
      userDataArray = filteredId;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("To Do List"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: userDataArray.length,
          itemBuilder: (context, index){
            return Dismissible(
              background: Container(
                color: Colors.red,
                child: const Icon(Icons.delete),
              ),
              key: ValueKey<Map>(userDataArray[index]),
              onDismissed: (DismissDirection direction){
                deleteData(userDataArray[index]['id']);
              },
              child: Card(
                child: ListTile(
                  title: Text(userDataArray[index]['name']),
                  subtitle: Text(userDataArray[index]['name']),
                ),
              ),
            );
          }
      ),
    );
  }
}
