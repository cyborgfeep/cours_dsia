final String tableContact = 'contact';
final String columnId = '_id';
final String columnName = 'name';
final String columnPhone = 'phone';

class FavContact {
  int? id;
  String? name;
  String? phone;

  FavContact({this.id, this.name, this.phone});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnName: name, columnPhone: phone};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  FavContact.fromMap(Map<dynamic, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    phone = map[columnPhone];
  }
}
