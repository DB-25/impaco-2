import 'package:flutter/material.dart';
import 'package:impaco/strings.dart';
import 'package:impaco/ui/components/home_card.dart';
import 'package:impaco/ui/impaco_theme.dart';
import 'package:impaco/ui/screens/register_screen.dart';

import '../screen_utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: BACKGROUND_COLOR,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: iw(30), right: iw(30), top: ih(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Impaco",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: iw(36),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: ih(38),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  children: <Widget>[
                    HomeCard(
                      title: Strings.hungry,
                      iconPath: "assets/reciever_icon.png",
                      desc: Strings.hungryDesc,
                      color: CARD_1_COLOR,
                      onTap: () {},
                    ),
                    Container(height: ih(10)),
                    HomeCard(
                      title: Strings.feedPeople,
                      iconPath: "assets/feeder_icon.png",
                      desc: Strings.feedDesc,
                      color: CARD_2_COLOR,
                      onTap: () {},
                    ),
                    Container(height: ih(10)),
                    HomeCard(
                      title: Strings.login,
                      iconPath: "assets/login_icon.png",
                      desc: Strings.loginDesc,
                      color: CARD_3_COLOR,
                      onTap: () {},
                      isSearchable: false,
                    ),
                    Container(height: ih(10)),
                    HomeCard(
                      title: Strings.register,
                      iconPath: "assets/register_icon.png",
                      desc: Strings.registerDesc,
                      color: CARD_4_COLOR,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => RegisterScreen(),
                          ),
                        );
                      },
                      isSearchable: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
