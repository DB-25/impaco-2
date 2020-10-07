import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:impaco/src/models/course_model.dart';
import 'package:impaco/src/apis/api_driver.dart';
import 'package:impaco/src/screens/login_screen.dart';
import 'package:impaco/src/screens/result_screen.dart';
import 'package:impaco/src/screens/teachers_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:impaco/src/screens/course_form_screen.dart';
import 'package:impaco/src/apis/login_driver.dart';

class CourseScreen extends StatefulWidget {
  @override
  CourseScreenState createState() => CourseScreenState();
}

class CourseScreenState extends State<CourseScreen> {
  LoginDriver loginDriver = new LoginDriver();
  ApiDriver apiDriver = new ApiDriver();
  bool refreshBool;
  void refresh() {
    if (refreshBool) {
      setState(() {
        refreshBool = false;
      });
    }
  }

  String email = '';
  bool admin = false;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('emailId');
      admin = (prefs.containsKey('admin')) ? prefs.getBool('admin') : false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
                    Icon(Icons.content_paste),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Classes',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String userType = prefs.getString('userType');
                  if (userType == 'Student')
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultScreen(email)));
                  else
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeachersScreen(email)));
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFF2b2e44),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: Column(
              children: <Widget>[
                titleTag(),
                FutureBuilder(
                  future: apiDriver.readCourse(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<CourseModel>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      //   Text(
                      //   'Loading....',
                      //   style: TextStyle(color: Colors.white),
                      // );
                      case ConnectionState.done:
                        final response = snapshot.data;
                        return (response == null)
                            ? Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'No Courses registered',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                ),
                              )
                            : listView(response);
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
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          Text(
            "Recommended Courses",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          (admin)
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CourseForm(
                                    update: false,
                                  )));
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF2DA488),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: Text(
                          "Register new Course",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget listView(List<CourseModel> courseModel) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: courseModel == null ? 0 : courseModel.length,
          itemBuilder: (context, int index) {
            return (admin)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(children: <Widget>[
                      card(courseModel[index]),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width - 90),
                        child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CourseForm(
                                          update: true,
                                          courseModel: courseModel[index])));
                            }),
                      ),
                    ]),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: card(courseModel[index]),
                  );
          }),
    );
  }

  Widget card(CourseModel courseModel) {
    return Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                height: MediaQuery.of(context).size.height / 6,
                child: Image.network(
                  'https://www.fullstack.com.au/fullstack/wp-content/uploads/2020/01/10-Udemy-Courses.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                courseModel.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Created By : ' + courseModel.instructor,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () => launch(courseModel.websiteLink),
                child: Text(
                  courseModel.platform.toUpperCase() +
                      " : " +
                      courseModel.websiteLink,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () => launch(courseModel.courseLink),
                child: Text(
                  "Click here to know more",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.of(context).pop(false);
                  });
                },
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () {
                  setState(() {
                    SystemChannels.platform
                        .invokeMethod<void>('SystemNavigator.pop');
                  });
                },
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
