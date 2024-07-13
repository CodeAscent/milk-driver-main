import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:water/API/API_handler/api_base_handler.dart';
import 'package:water/API/API_handler/api_urls.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  Future fetchQr() async {
    final res = await ApiHandler.get('driver/qrimage');

    final data = jsonDecode(res.body);

    return data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchQr(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: Image.network(
                    'https://www.mamasmilkfarm.com/app-assets/images/qrimage/' +
                        snapshot.data));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
