import 'package:flutter/material.dart';

class PrincipalScr extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hola usuario'),
      ),
      body: Center(
        child: Container(
          color: Colors.blue,
          child: Text('Pagina principal'),
        ),
      ),
    );
  }
}