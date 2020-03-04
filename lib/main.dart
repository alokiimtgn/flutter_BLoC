import 'dart:convert';

import 'package:blocmediumblog/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'json.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //1
  List list = [];
  DemoBloc bloc = DemoBloc();

  //2
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getData();
  }

  //3
  @override
  void dispose() {
    // TODO: implement deactivate
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          //6
          child: StreamBuilder<List>(
              stream: bloc.apiController,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasData) {
                      list = snapshot.data;
                    }
                    //5
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        //4
                        return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(list.length, (index) {
                            Post data = list[index];
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Text(data.id.toString()),
                                  Text(data.thumbnailUrl),
                                  Text(data.url),
                                  Text(data.title)
                                ],
                              ),
                            );
                          }),
                        );
                      },
                    );
                }
              }),
        ),
      ),
    );
  }
}

//Step 4
class ApiControllerJson {
  Future<List<Post>> fetchPost() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/photos');

    if (response.statusCode == 200) {
// If server returns an OK response, parse the JSON.

      var data = json.decode(response.body);
      var rest = data as List;
      List<Post> list = rest.map((json) => Post.fromJson(json)).toList();
      return list;
    } else {
// If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
