import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRLinkScreen extends StatefulWidget {
  const QRLinkScreen({super.key});

  @override
  State<QRLinkScreen> createState() => _QRLinkScreenState();
}

class _QRLinkScreenState extends State<QRLinkScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Conectar ao SENAI", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Text("Aponte a câmera para o QR do seu orientador", 
               style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 20),
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Color(0xFF64B5F6),
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        _linkToSENAIL(scanData.code!);
        controller.pauseCamera();
      }
    });
  }

  void _linkToSENAIL(String code) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Conectado ao SENAI!")),
    );
    Navigator.pop(context);
  }
}