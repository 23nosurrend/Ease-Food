import '../powersync.dart';
import 'package:powersync/sqlite3.dart' as sqlite;


class RestoModal {
  int id;
  String name;
  String iconPath;
  String location;
  String delivery;

  RestoModal(
      {required this.id,required this.name,
      required this.iconPath,
      required this.location,
      required this.delivery});
  factory RestoModal.fromMap(Map<String, dynamic> data) {
    return RestoModal(
      id:data['id'],
      name: data['name'],
      iconPath: data['iconpath'],
      location: data['location'],
      delivery: data['delivery'],
    );
  }

 factory RestoModal.fromRow(sqlite.Row row) {
    return RestoModal(
      iconPath:row['iconpath'],
      id:  int.parse(row['id'].toString()),
      name: row['name'],
      location: row['location'],
     delivery: row['delivery'],
    );
  }
    static Stream<List<RestoModal>> watchRestaurants() {
    return db
        .watch('SELECT * FROM restos ORDER BY created_at DESC')
        .map((results) {
      return results
          .map((row) => RestoModal.fromRow(row))
          .toList(growable: false);
    });
  }



  @override
  String toString() {
    return 'RestolModal(id:$id,name:$name,iconPath:$iconPath,location:$location,delivery:$delivery)';
  }
}
