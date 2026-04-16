import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  final List<Map<String, dynamic>> _reviews = const [
    {
      'name': 'Théo M.',
      'rating': 5,
      'date': 'Il y a 2 semaines',
      'text': 'Le meilleur tacos de Saverne sans aucun doute ! La viande est généreuse, les sauces sont top et le service est rapide. Je recommande vivement le XXL !',
      'tag': 'Tacos XXL',
    },
    {
      'name': 'Sarah K.',
      'rating': 5,
      'date': 'Il y a 1 mois',
      'text': 'Super resto ! Les burgers sont vraiment bons, on sent que c\'est fait avec des produits frais. Le personnel est sympa et souriant.',
      'tag': 'Smash Burger',
    },
    {
      'name': 'Maxime R.',
      'rating': 5,
      'date': 'Il y a 3 semaines',
      'text': 'On est venus en famille, tout le monde était satisfait. Les menus enfants sont bien dosés. Prix très corrects pour la qualité.',
      'tag': 'Menu Famille',
    },
    {
      'name': 'Léa D.',
      'rating': 4,
      'date': 'Il y a 2 mois',
      'text': 'Très bon rapport qualité-prix ! Le bowl poulet est délicieux et bien copieux. Seul bémol : un peu d\'attente le vendredi soir.',
      'tag': 'Bowl',
    },
    {
      'name': 'Kevin B.',
      'rating': 5,
      'date': 'Il y a 1 semaine',
      'text': 'Je viens ici au moins 2 fois par semaine. La régularité de la qualité est impressionnante. Le tacos suprême est une tuerie !',
      'tag': 'Habitué',
    },
    {
      'name': 'Amina S.',
      'rating': 5,
      'date': 'Il y a 3 mois',
      'text': 'Ouvert tard le soir, c\'est parfait après une soirée. La qualité est constante même en fin de service. Un sans-faute !',
      'tag': 'Tacos Large',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildRatingHero()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _buildReviewCard(_reviews[i]),
                  childCount: _reviews.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
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
              'Avis clients',
              style: TextStyle(color: Color(0xFFFF6B1A), fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'CE QUE DISENT NOS CLIENTS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Plus de 69 avis vérifiés sur Google.',
            style: TextStyle(color: Color(0xFF999999), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingHero() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        border: Border.all(color: const Color(0x33FF6B1A)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '4.7',
                style: TextStyle(
                  color: Color(0xFFFF6B1A),
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < 4 ? Icons.star_rounded : Icons.star_half_rounded,
                    color: const Color(0xFFFFD700),
                    size: 22,
                  );
                }),
              ),
              const SizedBox(height: 4),
              const Text(
                '69+ avis Google',
                style: TextStyle(color: Color(0xFF999999), fontSize: 12),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              children: [
                _ratingBar('5 ⭐', 0.78),
                _ratingBar('4 ⭐', 0.14),
                _ratingBar('3 ⭐', 0.05),
                _ratingBar('2 ⭐', 0.02),
                _ratingBar('1 ⭐', 0.01),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBar(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF999999), fontSize: 11)),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.white12,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF6B1A)),
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF1A1A1A),
                child: Text(
                  review['name'][0],
                  style: const TextStyle(
                    color: Color(0xFFFF6B1A),
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      review['date'],
                      style: const TextStyle(color: Color(0xFF999999), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0x26FF6B1A),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  review['tag'],
                  style: const TextStyle(
                    color: Color(0xFFFF6B1A),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(5, (i) {
              return Icon(
                Icons.star_rounded,
                color: i < review['rating'] ? const Color(0xFFFFD700) : Colors.white12,
                size: 16,
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            review['text'],
            style: const TextStyle(
              color: Color(0xCCFFFFFF),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}