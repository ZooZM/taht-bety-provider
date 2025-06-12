import 'package:hive/hive.dart';
import 'package:taht_bety_provider/features/product/data/basket_model.dart';

class BasketStorage {
  static late Box<BasketModel> _box;

  static Future<void> init() async {
    if (!Hive.isBoxOpen('basketbox')) {
      _box = await Hive.openBox<BasketModel>('basketbox');
    } else {
      _box = Hive.box<BasketModel>('basketbox');
    }
  }

  static Future<void> clear() async {
    await _box.clear();
  }

  static Future<void> deleteBox() async {
    await Hive.deleteBoxFromDisk('basketbox');
  }

  static Future<void> addToBasket({
    required String id,
    required String image,
    required int count,
    required String providerId,
    required int price,
    required String title,
    required String description,
  }) async {
    final item = BasketModel(
      id: id,
      image: image,
      count: count,
      providerId: providerId,
      price: price,
      title: title,
      description: description,
    );

    try {
      await _box.put(id, item); // Use `id` as the key
    } catch (e) {
      print("Error adding to basket: $e");
    }
  }

  static BasketModel? getBasketItem(String id) {
    return _box.get(id);
  }

  static Future<void> removeFromBasket(String id) async {
    try {
      await _box.delete(id);
    } catch (e) {
      print("Error removing item: $e");
    }
  }

  static List<BasketModel> getAllBasketItems() {
    return _box.values.toList();
  }

  static List<BasketModel> getItemsByProvider(String providerId) {
    return _box.values.where((item) => item.providerId == providerId).toList();
  }
}
