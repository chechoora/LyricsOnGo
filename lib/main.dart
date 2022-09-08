import 'package:flutter/material.dart';
import 'package:lyrics_on_go/di/di.dart';
import 'package:lyrics_on_go/view_layer/routes/routes_const.dart';
import 'package:lyrics_on_go/view_layer/routes/routes_generator.dart';
import 'package:loggy/loggy.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(),
  );
  setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: RoutesConst.determine,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
