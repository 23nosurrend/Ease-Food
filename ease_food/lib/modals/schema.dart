import 'package:powersync/powersync.dart';

const schema = Schema([
  Table('restos', [
    Column.text('created_at'),
    Column.text('name'),
    Column.text('delivery'),
    Column.text('iconpath'),
    Column.text('location')
  ]),
  Table('foods', [
    Column.text('created_at'),
    Column.integer('restoId'),
    Column.text('food_name'),
    Column.text('food_price'),
    Column.text('description'),
    Column.text('food_image')
  ])
]);

