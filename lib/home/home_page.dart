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
    _database();
  }

  Future<void> _database() async {
    final database = await DataBaseSqlite().openConnection();

    //*Pode ser criado dessa forma orientada a objetos Dart
    /*database.insert('teste', {'nome': 'Guilherme'});
    database.update(
      'teste',
      {'nome': 'Guilherme Potter Petry'},
      where: 'nome = ?',
      whereArgs: ['Guilherme'],
    );
    database.delete('teste', where: 'nome = ?', whereArgs: ['Guilherme']);
    var result = await database.query('teste');*/
    //print(result);

    //*Pode ser criado em forma de Querys padrão de banco de dados
    database.rawInsert('insert into teste values(null, ?)', ['Guilherme']);
    database.rawUpdate('update teste set nome = ? where id = ?', ['Guilherme Academia do Flutter', 5]);
    database.rawDelete('delete from teste where id = ?', [5]);
    var resultRaw = await database.rawQuery('select * from teste');
    print(resultRaw);
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
