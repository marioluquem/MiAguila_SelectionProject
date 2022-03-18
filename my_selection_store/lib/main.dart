import 'package:flutter/material.dart';
import 'package:my_selection_store/helpers/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      onGenerateRoute: (RouteSettings settings) => MyRoutes.getRoutes(settings),
      initialRoute: MyRoutes.homePath,
    );
  }
}
