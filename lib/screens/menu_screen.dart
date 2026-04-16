import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _activeTab = 0;

  final List<String> _tabs = ['🌯 Tacos', '🍔 Burgers', '🥗 Bowls', '🧒 Enfants'];

  final List<List<Map<String, dynamic>>> _menuItems = [
    // TACOS
    [
      {'emoji': '🌯', 'name': 'Tacos Médium', 'desc': '1 viande, frites, sauce, fromage', 'price': '6,90€', 'tag': 'Populaire'},
      {'emoji': '🌯', 'name': 'Tacos Large', 'desc': '2 viandes, frites, sauce, fromage', 'price': '8,90€', 'tag': null},
      {'emoji': '🌯', 'name': 'Tacos XL', 'desc': '3 viandes, frites, sauce, fromage', 'price': '10,90€', 'tag': 'Best-seller'},
      {'emoji': '🌯', 'name': 'Tacos XXL', 'desc': '4 viandes, frites, sauce, fromage', 'price': '12,90€', 'tag': '🔥 Hot'},
      {'emoji': '🌯', 'name': 'Tacos Suprême', 'desc': 'XL + crudités + double fromage + sauce spéciale', 'price': '13,90€', 'tag': 'Nouveau'},
    ],
    // BURGERS
    [
      {'emoji': '🍔', 'name': 'Smash Classic', 'desc': 'Steak smashé, cheddar, salade, tomate, oignon', 'price': '8,50€', 'tag': 'Populaire'},
      {'emoji': '🍔', 'name': 'Smash Double', 'desc': 'Double steak smashé, double cheddar', 'price': '10,90€', 'tag': 'Best-seller'},
      {'emoji': '🍔', 'name': 'Smash Suprême', 'desc': 'Double steak, bacon, sauce BBQ, cheddar fondu', 'price': '12,50€', 'tag': '🔥 Hot'},
      {'emoji': '🍔', 'name': 'Chicken Burger', 'desc': 'Poulet croustillant, salade, sauce ranch', 'price': '9,50€', 'tag': null},
    ],
    // BOWLS
    [
      {'emoji': '🥗', 'name': 'Bowl Poulet', 'desc': 'Riz, poulet grillé, crudités, sauce au choix', 'price': '9,90€', 'tag': 'Healthy'},
      {'emoji': '🥗', 'name': 'Bowl Beef', 'desc': 'Riz, bœuf haché, légumes, sauce samouraï', 'price': '10,90€', 'tag': 'Populaire'},
      {'emoji': '🥗', 'name': 'Bowl Mixte', 'desc': 'Riz, poulet + bœuf, crudités, double sauce', 'price': '11,90€', 'tag': 'Best-seller'},
    ],
    // ENFANTS
    [
      {'emoji': '🧒', 'name': 'Menu Enfant Tacos', 'desc': 'Petit tacos + boisson + dessert', 'price': '6,50€', 'tag': '< 12 ans'},
      {'emoji': '🧒', 'name': 'Menu Enfant Burger', 'desc': 'Petit burger + frites + boisson', 'price': '6,90€', 'tag': '< 12 ans'},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildTabs(),
            Expanded(child: _buildMenuList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0x26FF6B1A),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              'Notre carte',
              style: TextStyle(color: Color(0xFFFF6B1A), fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'NOTRE MENU',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tout est préparé frais, avec générosité.',
            style: TextStyle(color: Color(0xFF999999), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return SizedBox(
      height: 46,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: _tabs.length,
        itemBuilder: (context, i) {
          final isActive = _activeTab == i;
          return GestureDetector(
            onTap: () => setState(() => _activeTab = i),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFFF6B1A) : const Color(0xFF111111),
                border: Border.all(
                  color: isActive ? const Color(0xFFFF6B1A) : Colors.white12,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                _tabs[i],
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.white54,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuList() {
    final items = _menuItems[_activeTab];
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            border: Border.all(color: Colors.white.withOpacity(0.07)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(item['emoji'], style: const TextStyle(fontSize: 28)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (item['tag'] != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0x26FF6B1A),
                              border: Border.all(color: const Color(0x4DFF6B1A)),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              item['tag'],
                              style: const TextStyle(
                                color: Color(0xFFFF6B1A),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['desc'],
                      style: const TextStyle(color: Color(0xFF999999), fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                item['price'],
                style: const TextStyle(
                  color: Color(0xFFFF6B1A),
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}