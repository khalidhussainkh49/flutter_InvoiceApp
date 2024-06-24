import 'package:flutter/material.dart';
import 'package:invoice_app/screens/list_persons.dart';
import 'package:invoice_app/store/person_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PersonProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PersonListPage(),
    );
  }
}
