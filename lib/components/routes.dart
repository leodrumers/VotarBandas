import 'package:bands/views/home.dart';
import 'package:bands/views/status.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  Home.routeName: (context) => Home(),
  StatusPage.routeName: (context) => StatusPage()
};
