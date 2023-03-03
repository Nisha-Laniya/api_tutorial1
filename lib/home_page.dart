import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/posts_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi () async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200) {
      // postList.clear();
      for(Map<String,dynamic> i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Integration'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context,snapshot) {
                if(!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.pinkAccent,),
                  );
                }
                else {
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (BuildContext context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                        "Title:- ",
                                        style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontWeight: FontWeight.bold
                                        ),
                                    ),
                                    Flexible(
                                      child: Text(
                                          postList[index].title.toString(),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                        'Body:- ',
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                          postList[index].body.toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
