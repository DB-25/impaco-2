import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:impaco/src/apis/data_api.dart';

class ResultScreen extends StatefulWidget {
  @override
  ResultScreenState createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  DataApiDriver apiDriver = new DataApiDriver();
  Future<List<DataModel>> futureData;
  final List<String> items = ['apple', 'banana'];

  @override
  void initState() {
    super.initState();
    futureData = apiDriver.read();
    //for (var item in items)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2b2e44),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              titleTag(),
              FutureBuilder(
                future: futureData,
                builder: (BuildContext context,
                    AsyncSnapshot<List<DataModel>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      final response = snapshot.data;
                      return firstElement(response);
                      break;
                    default:
                      return null;
                  }
                },
              ),
              //for (var item in items) firstElement(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleTag() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(children: <Widget>[
        Text(
          "Available Receivers",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Text(
            "Here is a list of registered people as recievers nearby the pincode you have entered",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        )
      ]),
    );
  }

  Widget firstElement(List<DataModel> dataModel) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dataModel.length,
        itemBuilder: (context, int index) {
          return AspectRatio(
            aspectRatio: 353 / 110,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(2, 4),
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Column(
                        children: <Widget>[
                          Text("12",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                              )),
                          Text("People",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(dataModel[index].attrOne),
                          Text("8867861530"),
                          Text("H.No-1 Nai Basti, Bijnor"),
                          Text("246701"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
