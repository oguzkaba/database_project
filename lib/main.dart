import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/local/providers/local_data_provider.dart';
import 'views/home_view.dart';

void main() {
  runApp(ChangeNotifierProvider<LocalDataProvider>(
      create: ((context) => LocalDataProvider()), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
