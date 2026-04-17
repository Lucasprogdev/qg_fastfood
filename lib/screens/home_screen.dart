import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  final void Function(int index) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHero(context),
            _buildStats(),
            _buildWhyUs(),
            _buildGallery(),
            _buildCTA(context),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ─── HERO ───
  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        gradient: RadialGradient(
          center: Alignment(0.8, 0),
          radius: 1.2,
          colors: [Color(0x30FF6B1A), Color(0xFF0A0A0A)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0x26FF6B1A),
                  border: Border.all(color: const Color(0x4DFF6B1A)),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(
                  '🏆  N°1 TACOS À SAVERNE',
                  style: TextStyle(
                    color: Color(0xFFFF6B1A),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              const Text(
                'LE MEILLEUR\nFASTFOOD\nDE SAVERNE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  height: 0.95,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'STREET FOOD',
                style: TextStyle(
                  color: Color(0xFFFF6B1A),
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  height: 0.95,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tacos XXL, Smash Burgers qui claquent, Bowls frais… Fait avec passion au cœur de Saverne.',
                style: TextStyle(
                  color: Color(0xAAFFFFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 28),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onNavigate(1), // → Menu
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B1A),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Center(
                          child: Text(
                            '📋  Voir le Menu',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onNavigate(3), // → Contact
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Center(
                          child: Text(
                            '📍  Nous trouver',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Featured card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  border: Border.all(color: const Color(0x33FF6B1A)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🌯', style: TextStyle(fontSize: 40)),
                    const SizedBox(height: 8),
                    const Text(
                      'FRENCH TACOS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Garnitures généreuses, sauce au choix, fromage fondu',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('À partir de ', style: TextStyle(color: Color(0xFF999999), fontSize: 12)),
                        const Text(
                          '6,90€',
                          style: TextStyle(
                            color: Color(0xFFFF6B1A),
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      children: ['Médium', 'Large', 'XL', 'XXL'].map((size) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0x26FF6B1A),
                            border: Border.all(color: const Color(0x4DFF6B1A)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            size,
                            style: const TextStyle(
                              color: Color(0xFFFF6B1A),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── STATS ───
  Widget _buildStats() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem('4.7/5', 'Note Google'),
          _divider(),
          _statItem('69+', 'Avis clients'),
          _divider(),
          _statItem('N°1', 'À Saverne'),
          _divider(),
          _statItem('6,90€', 'Dès'),
        ],
      ),
    );
  }

  Widget _statItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Color(0xFFFF6B1A),
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF999999), fontSize: 11),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(width: 1, height: 36, color: Colors.white12);
  }

  // ─── WHY US ───
  Widget _buildWhyUs() {
    final items = [
      {'icon': '🏆', 'title': 'N°1 Tacos à Saverne', 'text': 'Note Google de 4.7/5 sur plus de 60 avis.'},
      {'icon': '🥩', 'title': 'Ingrédients frais', 'text': 'Viandes fraîches, légumes croquants. Rien de surgelé.'},
      {'icon': '⚡', 'title': 'Service ultra-rapide', 'text': 'Votre commande prête en quelques minutes.'},
      {'icon': '💰', 'title': 'Rapport qualité/prix', 'text': 'Menus complets à partir de 6,90€.'},
      {'icon': '😊', 'title': 'Accueil chaleureux', 'text': 'Une équipe souriante aux petits soins.'},
      {'icon': '🌙', 'title': 'Ouvert tard le soir', 'text': 'Ouvert jusqu\'à 22h, 23h en fin de semaine.'},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
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
              'Pourquoi nous',
              style: TextStyle(color: Color(0xFFFF6B1A), fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'CE QUI NOUS REND UNIQUES',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: items.length,
            itemBuilder: (context, i) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  border: Border.all(color: Colors.white.withOpacity(0.07)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(items[i]['icon']!, style: const TextStyle(fontSize: 28)),
                    const SizedBox(height: 8),
                    Text(
                      items[i]['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[i]['text']!,
                      style: const TextStyle(color: Color(0xFF999999), fontSize: 11, height: 1.4),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─── GALLERY ───
  Widget _buildGallery() {
    final items = [
      {'emoji': '🥗', 'label': 'Crudités Fraiches'},
      {'emoji': '🌶️', 'label': 'Sauce Samouraï'},
      {'emoji': '🧒', 'label': 'Menu Enfant'},
      {'emoji': '🌯', 'label': 'Médium Tacos'},
      {'emoji': '🏆', 'label': 'N°1 Saverne'},
      {'emoji': '🤤', 'label': 'Double Cheese'},
      {'emoji': '🌙', 'label': 'Soirée QG'},
      {'emoji': '🔥', 'label': 'Suprême Beef'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Text(
            'GALERIE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            itemCount: items.length,
            itemBuilder: (context, i) {
              final isOrange = i % 2 == 1;
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: isOrange ? const Color(0x26FF6B1A) : const Color(0xFF1A1A1A),
                  border: Border.all(
                    color: isOrange ? const Color(0x4DFF6B1A) : Colors.white12,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(items[i]['emoji']!, style: const TextStyle(fontSize: 30)),
                    const SizedBox(height: 6),
                    Text(
                      items[i]['label']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isOrange ? const Color(0xFFFF6B1A) : Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  // ─── CTA ───
  Widget _buildCTA(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B1A), Color(0xFFE0530A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PASSEZ AU QG CE SOIR !',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Tacos XXL, smash burger qui claque ou bowl bien garni — on vous attend au cœur de Saverne.',
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 20),
          _ctaCard('📍', '10 Rue des Bains', '67700 Saverne'),
          const SizedBox(height: 10),
          _ctaCard('⏰', 'Lun–Ven 11h30–14h & 18h–22h', 'Sam–Dim : 18h–23h'),
          const SizedBox(height: 10),
          _ctaCard('📞', '07 68 28 57 92', 'Commande & Info'),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _launch('tel:0768285792'),
            child: SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Text(
                    '📞  Appeler pour commander',
                    style: TextStyle(
                      color: Color(0xFFFF6B1A),
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ctaCard(String icon, String title, String detail) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
              Text(detail, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  // ─── FOOTER ───
  Widget _buildFooter() {
    return Container(
      color: const Color(0xFF111111),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'QG',
                  style: TextStyle(color: Color(0xFFFF6B1A), fontSize: 22, fontWeight: FontWeight.w900),
                ),
                TextSpan(
                  text: ' FASTFOOD',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Le QG de la street food à Saverne. Tacos, Burgers, Bowls — faits avec passion.',
            style: TextStyle(color: Color(0xFF999999), fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _footerIcon('📷', () => _launch('https://www.instagram.com/qg_fastfood_france')),
              const SizedBox(width: 10),
              _footerIcon('🗺️', () => _launch('https://maps.google.com/?q=10+Rue+des+Bains+67700+Saverne')),
              const SizedBox(width: 10),
              _footerIcon('📞', () => _launch('tel:0768285792')),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white12),
          const SizedBox(height: 12),
          const Text(
            '© 2026 QG Fastfood France — Tous droits réservés',
            style: TextStyle(color: Color(0xFF999999), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _footerIcon(String emoji, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(child: Text(emoji, style: const TextStyle(fontSize: 18))),
      ),
    );
  }
}