import 'package:flutter/material.dart';

Size screenSize;

double get _widthRatio => screenSize.width / 414;

double get _heightRatio => screenSize.height / 896;

double iw(x) => x * _widthRatio;

double ih(y) => y * _heightRatio;