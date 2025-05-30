import 'package:cours_dsia/models/fav_contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactProvider {
  late Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableContact ( 
  $columnId integer primary key autoincrement, 
  $columnName text not null,
  $columnPhone text not null)
''');
    });
  }

  Future<FavContact> insert(FavContact contact) async {
    contact.id = await db.insert(tableContact, contact.toMap());
    return contact;
  }

  Future<List<FavContact>> getAllContacts() async {
    final List<Map<String, dynamic>> maps = await db.query(tableContact);
    return List.generate(maps.length, (i) {
      return FavContact(
        id: maps[i][columnId],
        name: maps[i][columnName],
        phone: maps[i][columnPhone],
      );
    });
  }

  Future<FavContact?> getContactById(int id) async {
    List<Map> maps = await db.query(tableContact,
        columns: [columnId, columnName, columnPhone],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return FavContact.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableContact, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(FavContact contact) async {
    return await db.update(tableContact, contact.toMap(),
        where: '$columnId = ?', whereArgs: [contact.id]);
  }

  Future close() async => db.close();
}
