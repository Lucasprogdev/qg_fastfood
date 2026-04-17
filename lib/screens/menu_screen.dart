import 'package:flutter/material.dart';
import '../services/menu_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _activeTab = 0;
  List<MenuCategory> _categories = [];
  final Map<String, List<MenuItem>> _items = {};
  final MenuService _menuService = MenuService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        bottom: false,
        child: StreamBuilder<List<MenuCategory>>(
          stream: _menuService.categoriesStream(),
          builder: (context, catSnap) {
            if (catSnap.connectionState == ConnectionState.waiting) {
              return const _LoadingView();
            }
            if (catSnap.hasError) {
              return _ErrorView(message: catSnap.error.toString());
            }

            _categories = catSnap.data ?? [];

            if (_activeTab >= _categories.length) {
              _activeTab = 0;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildTabs(),
                if (_categories.isNotEmpty)
                  Expanded(
                    child: _buildItemsStream(_categories[_activeTab]),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemsStream(MenuCategory cat) {
    return StreamBuilder<List<MenuItem>>(
      stream: _menuService.itemsStream(cat.id),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const _LoadingView();
        }
        final items = snap.data ?? [];
        return _buildMenuList(items);
      },
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
              style: TextStyle(
                  color: Color(0xFFFF6B1A),
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
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
        itemCount: _categories.length,
        itemBuilder: (context, i) {
          final isActive = _activeTab == i;
          return GestureDetector(
            onTap: () => setState(() => _activeTab = i),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFFF6B1A)
                    : const Color(0xFF111111),
                border: Border.all(
                  color: isActive
                      ? const Color(0xFFFF6B1A)
                      : Colors.white12,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                _categories[i].label,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.white54,
                  fontWeight:
                      isActive ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuList(List<MenuItem> items) {
    if (items.isEmpty) {
      return const Center(
        child: Text(
          'Aucun plat dans cette catégorie',
          style: TextStyle(color: Color(0xFF999999), fontSize: 14),
        ),
      );
    }

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
                  child: Text(item.emoji,
                      style: const TextStyle(fontSize: 28)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (item.tag != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0x26FF6B1A),
                              border: Border.all(
                                  color: const Color(0x4DFF6B1A)),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              item.tag!,
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
                      item.desc,
                      style: const TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 12,
                          height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                item.price,
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

// ─── HELPERS ─────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFFFF6B1A),
        strokeWidth: 2,
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          '⚠️ Erreur de connexion\n$message',
          style: const TextStyle(color: Color(0xFF999999), fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}