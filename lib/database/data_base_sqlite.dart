import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseSqlite {
  Future<Database> openConnection() async {
    final dataBasePath = await getDatabasesPath();
    final dataBaseFinalPath = join(dataBasePath, 'SQLITE_EXAMPLE');
    print(dataBasePath);
    print(dataBaseFinalPath);

    return await openDatabase(
      dataBaseFinalPath,
      version: 2,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      //*Chamado somente no momento da criação do banco de dados
      //*Primeira vez que carrrega o aplicativo
      onCreate: (Database db, int version) {
        print('onCreate chamado.');

        final batch = db.batch();
        batch.execute('''
            create table produto(
              id Integer primary key autoincrement,
              nome varchar(200)
              )
        ''');

        batch.execute('''
            create table teste(
              id Integer primary key autoincrement,
              nome varchar(200)
              )
        ''');

        batch.commit();
      },
      //*Será chamado sempre que houver uma alteração no version incrementa(1 -> 2)
      onUpgrade: (Database db, int oldVersion, int newVersion) {
        print('onUpgrade chamado.');

        final batch = db.batch();

        /*if (oldVersion == 2) {
          batch.execute('''
            create table teste(
              id Integer primary key autoincrement,
              nome varchar(200)
              )
        ''');
        }*/
        batch.commit();
      },
      //*Será chamado sempre que houver uma alteração no version decrementa(2 -> 1)
      onDowngrade: (Database db, int oldVersion, int newVersion) {
        print('onDowngrade chamado.');

        final batch = db.batch();
        if (oldVersion == 1) {
          batch.execute('''
            drop table teste
        ''');
        }
        batch.commit();
      },
    );
  }
}
