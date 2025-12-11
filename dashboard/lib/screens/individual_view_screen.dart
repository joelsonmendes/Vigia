import 'package:flutter/material.dart';

class IndividualViewScreen extends StatelessWidget {
  final String studentName;
  final String courseId;

  const IndividualViewScreen({super.key, required this.studentName, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aluno: $studentName ($courseId)")),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.favorite, color: Colors.green),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bem-estar atual", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Alerta Leve – Sono irregular", style: TextStyle(color: Colors.orange)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text("Últimos 7 dias", style: TextStyle(fontSize: 18)),
            _WellBeingTimeline(),
            SizedBox(height: 24),
            Text("Ações da Psicóloga", style: TextStyle(fontSize: 18)),
            ListTile(
              leading: Icon(Icons.edit, color: Color(0xFF64B5F6)),
              title: Text("Adicionar nota clínica"),
              onTap: () => _openNoteDialog(context),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Color(0xFF64B5F6)),
              title: Text("Agendar conversa no SENAI"),
              onTap: () => _scheduleSession(context),
            ),
            Spacer(),
            _InterventionHistory(),
          ],
        ),
      ),
    );
  }

  void _openNoteDialog(BuildContext context) {}
  void _scheduleSession(BuildContext context) {}
}

class _WellBeingTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {"date": "10/05", "risk": 0},
      {"date": "11/05", "risk": 1},
      {"date": "12/05", "risk": 1},
      {"date": "13/05", "risk": 2},
      {"date": "14/05", "risk": 1},
      {"date": "15/05", "risk": 0},
      {"date": "16/05", "risk": 0},
    ];

    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          Color color = Colors.green;
          if (item["risk"] == 1) color = Colors.orange;
          if (item["risk"] == 2) color = Colors.red;

          return Container(
            width: 50,
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Text(item["date"], style: TextStyle(fontSize: 12)),
                Spacer(),
                Container(
                  width: 8,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InterventionHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Histórico de Intervenções", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("12/05 – Usou respiração 3x"),
            Text("13/05 – Aceitou conversar"),
          ],
        ),
      ),
    );
  }
}