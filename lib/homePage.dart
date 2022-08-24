import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List todo = [];
  Future getTodos() async {
    String url = 'https://jsonplaceholder.typicode.com/todos';
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    // print(responsebody[2]);

    setState(() {
      todo.addAll(responsebody);
    });
  }

  @override
  void initState() {
    getTodos();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: todo == null || todo.isEmpty
          ? const Center(child: CircularProgressIndicator(
        color: Color(0xff6E85B7),
      ))
          : ListView.separated(
        itemCount: todo.length,
        separatorBuilder: ((context, index) => const SizedBox(height: 7,)),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              color:  const Color(0xffC4D7E0),
              child: ListTile(
                title: Text('${todo[index]['title']}'),
                trailing: Checkbox(
                  activeColor: Color(0xff6E85B7),
                  checkColor: Color(0xffFAFFAF),
                  value: todo[index]['completed'],
                  onChanged: (value) {
                    setState(() {
                      todo[index]['completed'] = value!;
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}