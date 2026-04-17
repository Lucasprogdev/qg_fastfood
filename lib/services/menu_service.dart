import 'package:cloud_firestore/cloud_firestore.dart';

// ─── MODELS ──────────────────────────────────────────────────

class MenuCategory {
  final String id;
  final String label;
  const MenuCategory({required this.id, required this.label});

  factory MenuCategory.fromMap(Map<String, dynamic> map) {
    return MenuCategory(
      id: map['id'] as String,
      label: map['label'] as String,
    );
  }
}

class MenuItem {
  final String id;
  final String emoji;
  final String name;
  final String desc;
  final String price;
  final String? tag;
  final int order;

  const MenuItem({
    required this.id,
    required this.emoji,
    required this.name,
    required this.desc,
    required this.price,
    this.tag,
    this.order = 0,
  });

  factory MenuItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MenuItem(
      id: doc.id,
      emoji: data['emoji'] as String? ?? '🍽️',
      name: data['name'] as String? ?? '',
      desc: data['desc'] as String? ?? '',
      price: data['price'] as String? ?? '',
      tag: data['tag'] as String?,
      order: (data['order'] as num?)?.toInt() ?? 0,
    );
  }

  // Convert to the map format used in MenuScreen
  Map<String, dynamic> toMenuMap() => {
    'emoji': emoji,
    'name': name,
    'desc': desc,
    'price': price,
    'tag': tag,
  };
}

// ─── SERVICE ─────────────────────────────────────────────────

class MenuService {
  static final MenuService _instance = MenuService._internal();
  factory MenuService() => _instance;
  MenuService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream of categories list
  Stream<List<MenuCategory>> categoriesStream() {
    return _db.doc('menu/categories').snapshots().map((snap) {
      if (!snap.exists) return _defaultCategories;
      final list = snap.data()?['list'] as List<dynamic>? ?? [];
      return list
          .whereType<Map<String, dynamic>>()
          .map((m) => MenuCategory.fromMap(m))
          .toList();
    });
  }

  // Stream of items for a given category
  Stream<List<MenuItem>> itemsStream(String categoryId) {
    return _db
        .collection('menu/$categoryId/items')
        .orderBy('order')
        .snapshots()
        .map((snap) => snap.docs.map(MenuItem.fromFirestore).toList());
  }

  static List<MenuCategory> get _defaultCategories => const [
    MenuCategory(id: 'tacos', label: '🌯 Tacos'),
    MenuCategory(id: 'burgers', label: '🍔 Burgers'),
    MenuCategory(id: 'bowls', label: '🥗 Bowls'),
    MenuCategory(id: 'enfants', label: '🧒 Enfants'),
  ];
}