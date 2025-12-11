import 'package:flutter/material.dart';

class ConsentScreen extends StatelessWidget {
  const ConsentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.favorite, size: 64, color: Color(0xFF64B5F6)),
            SizedBox(height: 24),
            Text(
              "Olá, eu sou o Vigia 👋",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              "Estou aqui pra te acompanhar de forma discreta. "
              "Vou observar seu movimento, sono e uso do celular — "
              "mas **nunca vou gravar áudio, fotos ou mensagens**.",
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            ),
            SizedBox(height: 24),
            Text(
              "✅ Dados ficam só no seu celular\n"
              "✅ Nada é vendido ou analisado por humanos\n"
              "✅ Você pode parar a qualquer momento",
              style: TextStyle(fontSize: 14, color: Colors.green),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF64B5F6),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text("Começar com segurança", style: TextStyle(fontSize: 18, color: Colors.black87)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Prefiro não usar", style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}