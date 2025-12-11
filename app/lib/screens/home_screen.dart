import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Vigia", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/qr-link');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Como você está hoje?", style: TextStyle(fontSize: 24, color: Colors.white)),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.sunny, color: Colors.green, size: 32),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Seu bem-estar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("Estável hoje", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Text("Precisa de um apoio agora?", style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _InterventionCard(icon: Icons.air, label: "Respirar", color: Color(0xFF4FC3F7)),
                _InterventionCard(icon: Icons.music_note, label: "Música calma", color: Color(0xFF81C784)),
                _InterventionCard(icon: Icons.chat, label: "Conversar", color: Color(0xFFFF8A65)),
              ],
            ),
            Spacer(),
            Text.rich(
              TextSpan(
                text: "Em crise? Ligue para o ",
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: "CVV (188)",
                    style: TextStyle(color: Color(0xFFE57373), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InterventionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InterventionCard({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}