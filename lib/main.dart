
import 'package:flutter/material.dart';
import 'package:mousam/Activity/home.dart';
import 'package:mousam/Activity/loading.dart';

void main() {
  runApp(MaterialApp(
    //home: Home(),
    routes: {
      "/": (context) => const Loading(),
      "/home": (context) => Home(),
      "/loading" : (context) => const Loading(),
    },
  )
  );
}
