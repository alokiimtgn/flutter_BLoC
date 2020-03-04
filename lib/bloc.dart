import 'dart:async';

import 'package:blocmediumblog/main.dart';
//step 1
class DemoBloc implements Bloc {
  //StreamController of private type
  final StreamController _apiController = StreamController<List>();
  //getter for the stream
  Stream get apiController => _apiController.stream;
  //step 5
  //1
  getData() async {
    ApiControllerJson apiControllerJson = ApiControllerJson();
    List data = await apiControllerJson.fetchPost();
    //2
    if (data.length>20) data = data.sublist(0,25);
    //3
    _apiController.sink.add(data);

  }
//step 2
  @override
  void dispose() {
    // TODO: implement dispose
    _apiController.close();
  }
}
//step 2
abstract class Bloc {
  void dispose();
}
