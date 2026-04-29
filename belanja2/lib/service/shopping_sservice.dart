import 'package:firebase_database/firebase_database.dart';

class ShoppingService {
  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('shopping_list');

  Stream<Map<String, Map<String, dynamic>>> getShoppingList() {
    return _database.onValue.map((event) {
      final Map<String, Map<String, dynamic>> items = {};
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> values =
            snapshot.value as Map<dynamic, dynamic>;

        values.forEach((key, value) {
          items[key] = Map<String, dynamic>.from(value);
        });
      }

      return items;
    });
  }

  void addShoppingItem(Map<String, dynamic> item) {
    _database.push().set(item);
  }

  Future<void> removeShoppingItem(String key) async {
    await _database.child(key).remove();
  }
}