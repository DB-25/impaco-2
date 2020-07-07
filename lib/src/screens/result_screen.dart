import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:impaco/src/models/data_model.dart';
import 'package:impaco/src/apis/api_driver.dart';
import 'package:impaco/src/screens/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:impaco/src/apis/login_driver.dart';

class ResultScreen extends StatefulWidget {
  final String email;
  ResultScreen(this.email);
  @override
  ResultScreenState createState() => ResultScreenState(email);
}

class ResultScreenState extends State<ResultScreen> {
  String email;
  ResultScreenState(this.email);
  void initState() {
    super.initState();
  }

  LoginDriver loginDriver = new LoginDriver();
  ApiDriver apiDriver = new ApiDriver();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2b2e44),
          centerTitle: true,
          title: Text('EDUCATO'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Educato',
                      style: TextStyle(
                          fontSize: 55.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF2DA488),
                ),
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        email,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.power_settings_new),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Log Out',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  loginDriver.logOut();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
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
                      case ConnectionState.waiting:
                        return Text('Loading....');
                      case ConnectionState.done:
                        final response = snapshot.data;
//                        print(response);
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
      ),
    );
  }

  Widget titleTag() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(children: <Widget>[
        Text(
          "Classes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Text(
            "“Live as if you were to die tomorrow. Learn as if you were to live forever.” – Mahatma Gandhi",
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
    dataModel.sort((a, b) {
      var aDate = a.startDate;
      var bDate = b.startDate;
      return aDate.compareTo(bDate);
    });
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: dataModel == null ? 0 : dataModel.length,
          itemBuilder: (context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2, 4),
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 4),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFea668d),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                          ),
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
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
//                          Text(dataModel[index].attrOne),
                                Text(
                                  dataModel[index].name.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.85),
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  dataModel[index].subject,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  time(dataModel[index].startTime),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  dataModel[index].appName,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
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

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop'),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
