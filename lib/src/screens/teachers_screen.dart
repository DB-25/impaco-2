import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:impaco/src/apis/api_driver.dart';
import 'package:impaco/src/screens/form_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class TeachersScreen extends StatefulWidget {
  @override
  TeachersScreenState createState() => TeachersScreenState();
}

class TeachersScreenState extends State<TeachersScreen> {
  ApiDriver apiDriver = new ApiDriver();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2b2e44),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Column(
            children: <Widget>[
              titleTag(),
              FutureBuilder(
                future: apiDriver.read(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<DataModel>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      final response = snapshot.data;
                      print(response);
                      return firstElement(response);
                      break;
                    default:
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleTag() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(children: <Widget>[
        Text(
          "Future Classes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FormScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Schedule new Classes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget firstElement(List<DataModel> dataModel) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: dataModel == null ? 0 : dataModel.length,
          itemBuilder: (context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 3.2 / 1.4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF678CC0),
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
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                dataModel[index].startDate.substring(8, 10),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                month(dataModel[index].startDate),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
//                          Text(dataModel[index].attrOne),
                                Text(
                                  dataModel[index].name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  dataModel[index].subject,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  time(dataModel[index].startTime),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  dataModel[index].appName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                InkWell(
                                  onTap: () =>
                                      launch(dataModel[index].meetingLink),
                                  child: Text(
                                    dataModel[index].meetingLink,
                                    style: TextStyle(
                                      color: Color(0xFF80deea),
                                      fontSize: 17,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  String month(String dateString) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(dateString);
    return DateFormat('MMM').format(tempDate).toString();
  }

  String time(String savedDateString) {
    DateTime tempDate = new DateFormat("hh:mm:ss").parse(savedDateString);
    return DateFormat('h:mm a').format(tempDate);
  }
}
