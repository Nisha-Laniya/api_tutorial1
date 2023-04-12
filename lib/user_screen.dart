import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/posts_model.dart';
import 'models/user_model.dart';

class UserScreen extends StatelessWidget {
   UserScreen({Key? key}) : super(key: key);

   List<UserModel> postList = [];

   Future<List<UserModel>> getPostApi () async {
     final response = await http.get(Uri.parse('https://dummyjson.com/products'));
     var data = jsonDecode(response.body)['products'];
     if(response.statusCode == 200) {
       // postList.clear();
       for(Map<String,dynamic> i in data) {
         postList.add(UserModel.fromJson(i));
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
                print(snapshot);
                if(!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.pinkAccent,),
                  );
                }
                else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
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
                                        snapshot.data![index].title!
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
                                        postList[index].images.toString(),
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
