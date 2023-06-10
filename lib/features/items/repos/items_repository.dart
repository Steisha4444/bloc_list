import 'package:bloc_list/features/items/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsRepository {
  static final _db = FirebaseFirestore.instance;

  static Future<void> addItem(Item item) async {
    final doc = _db.collection('items').doc(item.id.toString());
    final json = item.toMap();
    await doc.set(json);
  }

  static Future<List<Item>> getItems() async {
    final snapshot = await _db.collection('items').get();

    return snapshot.docs.map((e) => Item.fromMap(e.data())).toList();
  }

  static Future<void> deleteItem(Item repo) async {
    final doc = _db.collection('items').doc(repo.id.toString());

    await doc.delete();
  }
}
