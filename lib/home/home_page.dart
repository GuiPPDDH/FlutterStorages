import 'package:flutter/material.dart';
import 'package:flutter_sqlite_example/database/data_base_sqlite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DataBaseSqlite().openConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqlite'),
      ),
      body: Container(),
    );
  }
}
